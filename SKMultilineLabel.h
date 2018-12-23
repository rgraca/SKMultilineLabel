//
//  SKMultilineLabel.h
//  
//
//  Created on 14/10/2018.
//  This component was converted and adapted from https://gist.github.com/krodak/0194179ac3142beff54c99bb52209b4a
//  after an online search for 'sklabelnode wrap' which showed this site: https://forums.developer.apple.com/thread/82994


#import <SpriteKit/SpriteKit.h>

@interface SKMultilineLabelNode : SKNode {

@private
	CGFloat _labelWidth;
	NSString* _text;
	NSString* _fontName;
	CGFloat _fontSize;
	SKColor* _fontColor;
	CGFloat _leading;
	SKLabelHorizontalAlignmentMode _alignment;
	bool _dontUpdate;
	bool _shouldShowBorder;
}

@property (assign, atomic, getter = getLabelWidth, setter = setLabelWidth:) CGFloat labelWidth;
@property (assign, atomic) CGFloat labelHeight;
@property (assign, atomic, getter = getText, setter = setText:) NSString* text;
@property (assign, atomic, getter = getFontName, setter = setFontName:) NSString* fontName;
@property (assign, atomic, getter = getFontSize, setter = setFontSize:) CGFloat fontSize;
@property (assign, atomic, getter = getFontColor, setter = setFontColor:) SKColor* fontColor;
@property (assign, atomic, getter = getLeading, setter = setLeading:) CGFloat leading;
@property (assign, atomic, getter = getAlignment, setter = setAlignment:) SKLabelHorizontalAlignmentMode alignment;
@property (assign, atomic, getter = getDontUpdate, setter = setDontUpdate:) bool dontUpdate;
@property (assign, atomic, getter = getShouldShowBorder, setter = setShouldShowBorder:) bool shouldShowBorder;
@property (retain, atomic) SKShapeNode *borderRect;


- (id) initWithText:(NSString*)theText
		 labelWidth:(CGFloat)lblWidth
				pos:(CGPoint)pos
		   fontName:(NSString*)fontName
		   fontSize:(CGFloat)size
		  fontColor:(SKColor*)color
			leading:(CGFloat)leading
		  alignment:(SKLabelHorizontalAlignmentMode) alignment
   shouldShowBorder:(BOOL)showBorder;

- (id) initWithText:(NSString*)theText
		 labelWidth:(CGFloat)lblWidth
				pos:(CGPoint)pos
		  alignment:(SKLabelHorizontalAlignmentMode) alignment;

- (void) update;

@end

