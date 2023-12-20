#import <UIKit/UIKit.h>
#import <ControlCenterUIKit/CCUIButtonModuleView.h>
#import <ControlCenterUIKit/CCUIToggleModule.h>
#import <ControlCenterUIKit/CCUIToggleViewController.h>

@interface SSHonCC : CCUIToggleModule {
	BOOL _longPressOnce;
	NSString * _p_sshswitch;
	BOOL _didThatMyself;
	char _openSshIsRunning; // -1=undef, 0=off, 1=on
}
@property (nonatomic,copy,readonly) UIImage * iconGlyph; 
@property (nonatomic,copy,readonly) UIImage * selectedIconGlyph; 
@property (nonatomic,copy,readonly) UIColor * selectedColor; 
- (UIColor *)selectedColor;
- (UIImage *)iconGlyph;
- (UIImage *)selectedIconGlyph; // if the selected should be different from the non-selected;
- (void)setSelected:(BOOL)sel;
- (void)openSshSettings;
@end
