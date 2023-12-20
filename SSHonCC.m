#import "SSHonCC.h"

#import <objc/runtime.h> // objc_getClass()
#include <stdio.h> // snprintf, vsprintf, fopen, fgets etc..
#include <sys/types.h> // pid_t
#include <spawn.h> // posix_spawn and friends
#include <sys/wait.h> // waitpid
#include <string.h> // strerror
#include <sys/stat.h>  // stat
#include <stdarg.h> // for my log func

#include <roothide.h>
#define ROOT_PATH(cPath) jbroot(cPath)
#define ROOT_PATH_NS(path) jbroot(path)

// This probably isn't sending anything on arm64e devices on iOS14 if built with Xcode11
static void 
bhLog(NSString *format, ...){
	va_list argp;
	va_start(argp, format);
	NSLogv([NSString stringWithFormat:@"%.4f u.blanxd.opensshcc %@", ([[NSDate date] timeIntervalSince1970] * 1000.0)/1000, format], argp);
	va_end(argp);
}

@interface UIImage ()
+ (UIImage *)imageNamed:(NSString *)name inBundle:(NSBundle *)bundle;
@end

@interface FBSystemApp : UIApplication
@end

@interface SBUserAgent : NSObject
-(BOOL)deviceIsPasscodeLocked;
-(BOOL)deviceIsLocked;
-(BOOL)openURL:(id)arg1 allowUnlock:(BOOL)arg2 animated:(BOOL)arg3;
@end

@interface SpringBoard: FBSystemApp <UIApplicationDelegate>
-(SBUserAgent *)pluginUserAgent;
@end

/* so this seems to only work starting iOS 13. For 11,12 still need to attach the GestureRecognizer straight to the ToggleViewController  */
@interface CCUIToggleViewController (SSHonCC)
-(BOOL)shouldFinishTransitionToExpandedContentModule;
@end

@implementation CCUIToggleViewController (SSHonCC)
-(BOOL)shouldFinishTransitionToExpandedContentModule {

	if ( [[self module] isKindOfClass:[SSHonCC class]] )
		[(SSHonCC*)[self module] openSshSettings];

	return NO;
}
@end


@implementation SSHonCC

@synthesize iconGlyph; 
@synthesize selectedIconGlyph;
@synthesize selectedColor;

-(SSHonCC *) init {
    self = [super init];

	struct stat ftest;
	
	// mitigating XinaA15's overwriting procedures
	char * usr = "usr";
	char * bin = "bin";
	char * ssw = "SSHswitch";
	_p_sshswitch = [NSString stringWithFormat:@"/%s/%s/%s", usr, bin, ssw]; // rooted
	if ( stat([_p_sshswitch UTF8String], &ftest) != 0 ){
		_p_sshswitch = ROOT_PATH(_p_sshswitch); // simple /var/jb
		if ( stat([_p_sshswitch UTF8String], &ftest) != 0 ){
			NSString * envJbRoot = [[[NSProcessInfo processInfo] environment] objectForKey:@"JB_ROOT_PATH"];
			if ( envJbRoot ){
				_p_sshswitch = [NSString stringWithFormat:@"%@/%s/%s/%s", envJbRoot, usr, bin, ssw];
			} // else now we're f*d, this isn't going to work
		}
	}

	_openSshIsRunning = -1;

	// in 11,12 we can access the super.contentViewController.view
	// in 13 we cannot I guess, it crashes SB
	/* doing it in the Category only works starting iOS 13 */
	if ( ![self respondsToSelector:@selector(contentViewControllerForContext:)] ){
		// 11,12
		[super.contentViewController.view addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(openSshSettings)]];
	}

	_longPressOnce = NO;
	_didThatMyself = NO;
	
	CFNotificationCenterAddObserver(
		CFNotificationCenterGetDarwinNotifyCenter(), 
		(__bridge const void *)(self),
		openSshOnOffCallback, 
		CFSTR("com.openssh.sshd/on"), 
		NULL, 
		CFNotificationSuspensionBehaviorCoalesce
		);
	CFNotificationCenterAddObserver(
		CFNotificationCenterGetDarwinNotifyCenter(), 
		(__bridge const void *)(self),
		openSshOnOffCallback, 
		CFSTR("com.openssh.sshd/off"), 
		NULL, 
		CFNotificationSuspensionBehaviorCoalesce
		);

	
	return self;
}

// ideas from https://stackoverflow.com/questions/26637023/how-to-properly-use-cfnotificationcenteraddobserver-in-swift-for-ios
- (void)notificationCallbackReceivedWithName:(NSString *)name {
	if ( _didThatMyself ){
		_didThatMyself = NO;
		return;
	}	
	_openSshIsRunning = [name isEqualToString:@"com.openssh.sshd/on"] ? 1 : 0;
	[self refreshState];
}

// so this isn't really a part of the class.
static void 
openSshOnOffCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
	[(__bridge SSHonCC *)observer notificationCallbackReceivedWithName:(__bridge NSString *)name];		
}

- (void)openSshSettings {
	if ( !_longPressOnce ){
		Class SpringBoardClass = objc_getClass("SpringBoard");
		if ( ![[(SpringBoard *)[SpringBoardClass sharedApplication] pluginUserAgent] deviceIsLocked] ){
			_longPressOnce = YES;
			NSString *prefUrl = @"prefs:root=OpenSSH";
			if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:prefUrl]]){
				BOOL success = [[(SpringBoard *)[SpringBoardClass sharedApplication] pluginUserAgent] openURL:[NSURL URLWithString:prefUrl] allowUnlock:YES animated:NO];
	    	   	if (!success) {
   			        bhLog(@"longPress FAILED Open %@", prefUrl);
	    	    }
			} else {
				bhLog(@"longPress cannot Open %@", prefUrl);
			}
			[self performSelector:@selector(longPressDone) withObject:nil afterDelay:2];
		}
	}
}
- (void)longPressDone {
	_longPressOnce = NO;
}

- (UIImage *)iconGlyph {
	if ( iconGlyph==nil )
		iconGlyph = [UIImage imageNamed:@"Icon" inBundle:[NSBundle bundleForClass:[self class]]];
	return iconGlyph;
}

-(UIImage *)selectedIconGlyph {
	if ( selectedIconGlyph == nil )
		selectedIconGlyph = [self iconGlyph];
	return selectedIconGlyph;
}


- (UIColor *)selectedColor {
	if ( selectedColor == nil )
		selectedColor = [UIColor blackColor];
	return selectedColor;
}

- (BOOL)isSelected {
	BOOL sel;
	if ( _openSshIsRunning > -1 )
		sel = _openSshIsRunning > 0;
	else
		sel = [self runSwitch:-1];
	_openSshIsRunning = -1;
	return sel;
}

- (void)setSelected:(BOOL)selected {

	if ( _longPressOnce )
		return;

	_didThatMyself = YES;

	Class SpringBoardClass = objc_getClass("SpringBoard");

	if ( ![[(SpringBoard *)[SpringBoardClass sharedApplication] pluginUserAgent] deviceIsPasscodeLocked] || [self evenIfLocked] ){

		if ( ![self runSwitch: selected ? 1 : 0] )
			return;
		[super refreshState];

	}
	
} // - (void)setSelected:(BOOL)selected {

- (BOOL)evenIfLocked {

	const char * fp_tweakpref = ROOT_PATH("/var/mobile/Library/Preferences/u.blanxd.sshswitch/prefs");

	FILE * ff_tweakpref;
	ff_tweakpref = fopen(fp_tweakpref, "r");
	if ( ff_tweakpref != NULL ){
		_Bool toolong = 0;
		char istr[64];
		while ( fgets(istr,64,ff_tweakpref) != NULL ){
			if ( strpbrk(istr,"\n")==NULL ){
				toolong = 1; // skip the next chunks until the line ends
				continue;
			} else if ( toolong==1 ){
				toolong = 0; // next one could be ok
				continue;
			}
	
			if ( strlen(istr) < 2 )
				continue;
			
			if ( istr[0] == 'e' ){
				fclose(ff_tweakpref);
				return YES;
			}
		}
		fclose(ff_tweakpref);
	}

	struct stat elockedfs;
	if ( stat( ROOT_PATH("/etc/ssh/u.blanxd.sshswitch.eveniflocked"), &elockedfs ) == 0 )
		return YES;
	
	return NO;
}

// onOff: -1=get status: 1=running, 0=not
// onOff: 0=turn off
// onOff: 1=turn on
- (BOOL)runSwitch:(int8_t)onOff {

	int status = 2;
	if ( onOff>=0 )
		_didThatMyself = YES;

	posix_spawn_file_actions_t action;
	posix_spawn_file_actions_init(&action);
	posix_spawn_file_actions_addopen (&action, STDIN_FILENO, "/dev/null", O_RDONLY, 0);
	posix_spawn_file_actions_addopen (&action, STDOUT_FILENO, "/dev/null", O_RDONLY, 0);
	posix_spawn_file_actions_addopen (&action, STDERR_FILENO, "/dev/null", O_RDONLY, 0);

	uint8_t ai = onOff<0 ? 0 : 1;
	const char *args[ 2+ai ];

	args[0] = "SSHswitch";
	if ( ai>0 ) args[1] = onOff ? "on" : "off";
	args[++ai] = NULL;

	pid_t pid;
	status = posix_spawn(&pid, [_p_sshswitch UTF8String], &action, NULL, (char* const*)args, NULL);
	if (status == 0) {
		if (waitpid(pid, &status, 0) != -1) {
			if ( WIFEXITED(status) != 0 ){
				status = WEXITSTATUS(status);
			} else {
				bhLog(@"runSwitch(%d) ERROR: WIFEXITED(status) = 0 (SSHswitch pid:%d)", onOff, pid);
				status = 2;
			}
		} else {
			bhLog(@"runSwitch(%d) ERROR: waitpid(%d,&status,0) = -1", onOff, pid);
			status = 2;
		}
	} else {
		bhLog(@"runSwitch(%d) ERROR: posix_spawn() = %d - %s", onOff, status, strerror(status));
		status = 2;
	}
	posix_spawn_file_actions_destroy(&action);

	if ( onOff<0 ){
		_openSshIsRunning = status==0 ? 1 : 0;
	} else if ( status==0 ){
		_openSshIsRunning = onOff>0 ? 1 : 0;
		return YES;
	} else
		return NO;

	return _openSshIsRunning>0;

} // - (BOOL)runSwitch:(int8_t)onOff {

@end
