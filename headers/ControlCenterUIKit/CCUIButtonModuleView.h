/* This file is from "the internet", well I've combined 3 different versions over time.
 * Many things have been commented out since they're not needed for this project
 * and might need a bunch of other header files.
 * Blanxd.H
 */
 
/*
* This header is generated by classdump-dyld 1.0
* on Thursday, January 25, 2018 at 11:27:41 PM Eastern European Standard Time
* Operating System: Version 11.1.2 (Build 15B202)
* Image Source: /System/Library/PrivateFrameworks/ControlCenterUIKit.framework/ControlCenterUIKit
* classdump-dyld is licensed under GPLv3, Copyright © 2013-2016 by Elias Limneos.
*/

/*
* This header is generated by classdump-dyld 1.0
* on Friday, February 8, 2019 at 1:25:48 PM Eastern European Standard Time
* Operating System: Version 12.1 (Build 16B92)
* Image Source: /System/Library/PrivateFrameworks/ControlCenterUIKit.framework/ControlCenterUIKit
* classdump-dyld is licensed under GPLv3, Copyright © 2013-2016 by Elias Limneos.
*/

/*
* This header is generated by classdump-dyld 1.0
* on Sunday, November 10, 2019 at 11:16:35 PM Eastern European Standard Time
* Operating System: Version 13.1.3 (Build 17A878)
* Image Source: /System/Library/PrivateFrameworks/ControlCenterUIKit.framework/ControlCenterUIKit
* classdump-dyld is licensed under GPLv3, Copyright © 2013-2016 by Elias Limneos.
*/

//#import <ControlCenterUIKit/ControlCenterUIKit-Structs.h>
#import <UIKit/UIControl.h> // 11 // ?? 12,13 ??
//#import <UIKitCore/UIControl.h> // 12,13
//#import <UIKit/UIGestureRecognizerDelegate.h>

@class UIView, UIImageView, CCUICAPackageView, UIImage, UIColor, CCUICAPackageDescription, NSString;
// , MTVisualStylingProvider // 13

@interface CCUIButtonModuleView : UIControl <UIGestureRecognizerDelegate> {
	UIView* _highlightedBackgroundView;
	UIImageView* _glyphImageView;
//	CCUICAPackageView* _glyphPackageView;
//	MTVisualStylingProvider* _visualStylingProvider; // 13
	UIImage* _glyphImage;
	UIColor* _glyphColor;
	UIImage* _selectedGlyphImage;
	UIColor* _selectedGlyphColor;
	double _glyphAlpha; // 13
	double _glyphScale; // 13
//	CCUICAPackageDescription* _glyphPackageDescription;
	NSString* _glyphState;
//	NSDirectionalEdgeInsets _contentEdgeInsets;
}
@property (nonatomic,retain) UIImage * glyphImage;                                            //@synthesize glyphImage=_glyphImage - In the implementation block
@property (nonatomic,retain) UIColor * glyphColor;                                            //@synthesize glyphColor=_glyphColor - In the implementation block
@property (nonatomic,retain) UIImage * selectedGlyphImage;                                    //@synthesize selectedGlyphImage=_selectedGlyphImage - In the implementation block
@property (nonatomic,retain) UIColor * selectedGlyphColor;                                    //@synthesize selectedGlyphColor=_selectedGlyphColor - In the implementation block
@property (assign,nonatomic) double glyphAlpha; // 13                                              //@synthesize glyphAlpha=_glyphAlpha - In the implementation block
@property (assign,nonatomic) double glyphScale; // 13                                              //@synthesize glyphScale=_glyphScale - In the implementation block
//@property (nonatomic,retain) CCUICAPackageDescription * glyphPackageDescription;              //@synthesize glyphPackageDescription=_glyphPackageDescription - In the implementation block
@property (nonatomic,copy) NSString * glyphState;                                             //@synthesize glyphState=_glyphState - In the implementation block
//@property (assign,nonatomic) NSDirectionalEdgeInsets contentEdgeInsets;                       //@synthesize contentEdgeInsets=_contentEdgeInsets - In the implementation block
//@property (readonly) unsigned long long hash; 
//@property (readonly) Class superclass; 
//@property (copy,readonly) NSString * description; 
//@property (copy,readonly) NSString * debugDescription; 
-(void)setEnabled:(BOOL)arg1 ;
-(id)initWithFrame:(CGRect)arg1 ;
-(BOOL)gestureRecognizer:(id)arg1 shouldRecognizeSimultaneouslyWithGestureRecognizer:(id)arg2 ;
-(void)layoutSubviews;
-(void)setHighlighted:(BOOL)arg1 ;
-(void)didMoveToWindow; // 13
-(void)setSelected:(BOOL)arg1 ;
//-(void)setContentEdgeInsets:(NSDirectionalEdgeInsets)arg1 ;
//-(NSDirectionalEdgeInsets)contentEdgeInsets;
-(void)_handlePressGesture:(id)arg1 ;
-(UIColor *)selectedGlyphColor;
-(void)setSelectedGlyphColor:(UIColor *)arg1 ;
-(void)setGlyphColor:(UIColor *)arg1 ;
-(UIColor *)glyphColor;
-(UIImage *)glyphImage;
-(void)setGlyphImage:(UIImage *)arg1 ;
-(void)setSelectedGlyphImage:(UIImage *)arg1 ;
-(UIImage *)selectedGlyphImage;
-(void)_updateForStateChange;
//-(void)setGlyphPackageDescription:(CCUICAPackageDescription *)arg1 ;
-(void)setGlyphState:(NSString *)arg1 ;
//-(CCUICAPackageDescription *)glyphPackageDescription;
-(NSString *)glyphState;
-(void)setGlyphScale:(double)arg1 ; // 13
-(double)glyphScale; // 13
-(void)_setGlyphImage:(id)arg1 ;
-(void)_setGlyphPackageDescription:(id)arg1 ;
-(void)_setGlyphState:(id)arg1 ;
-(void)_setGlyphAlpha:(double)arg1 ; // 13
-(void)_setGlyphScale:(double)arg1 ; // 13
-(void)_updateGlyphImageViewVisualStyling; // 13
-(double)glyphAlpha; // 13
-(id)_tintColorForSelectedState:(BOOL)arg1 ; //13
-(void)setGlyphAlpha:(double)arg1 ; // 13
@end
