//
//  SKMultilineLabel.m
//
//
//  Created on 14/10/2018.
//

#import "SKMultilineLabel.h"

@implementation SKMultilineLabelNode

@synthesize labelHeight;


#pragma mark - Main code

- (id) init {
	self = [super init];
	if (self) {
		_text=nil;
		_labelWidth = 0;
		self.position=CGPointZero;
		_fontName=nil;
		_fontSize = 0;
		_fontColor = nil;
		_leading = 0;
		_shouldShowBorder = NO;
		_alignment = SKLabelHorizontalAlignmentModeLeft;
		_dontUpdate=NO;
	}
	return self;
}


- (id) initWithText:(NSString*)theText
		 labelWidth:(CGFloat)lblWidth
				pos:(CGPoint)pos
		   fontName:(NSString*)fontName
		   fontSize:(CGFloat)fontSize
		  fontColor:(SKColor*)fontColor
			leading:(CGFloat)leading
		  alignment:(SKLabelHorizontalAlignmentMode) alignment
   shouldShowBorder:(BOOL)showBorder {
	
	self = [super init];
	if (self) {
		_text=theText;
		_labelWidth = lblWidth;
		self.position=pos;
		_fontName=fontName;
		_fontSize = fontSize;
		_fontColor = fontColor;
		_leading = leading;
		_shouldShowBorder = showBorder;
		_alignment = alignment;
		_dontUpdate=NO;
		[self update];
	}
	return self;
}


- (id) initWithText:(NSString*)theText
		 labelWidth:(CGFloat)lblWidth
				pos:(CGPoint)pos
		  alignment:(SKLabelHorizontalAlignmentMode) alignment {
	self = [super init];
	if (self) {
		_text=theText;
		_labelWidth = lblWidth;
		self.position=pos;
		_fontName=FONT_ODIN_ROUNDED_BOLD;
		_fontSize = FONT_SIZE;
		_fontColor = [SKColor whiteColor];
		_leading = _fontSize;
		_shouldShowBorder = NO;
		_alignment = alignment;
		_dontUpdate=NO;
		[self update];
	}
	return self;
}


- (void) update {
	if (self.dontUpdate || (_text==nil) || (_labelWidth==0) || (_fontName==nil) || (_fontSize==0) || (_fontColor==nil)) {
		return;
	}
	
	[self removeAllChildren];
	
	NSCharacterSet* separators = NSCharacterSet.whitespaceAndNewlineCharacterSet;
	NSCharacterSet* lineSeparators = NSCharacterSet.newlineCharacterSet;
	NSArray* paragraphs = [self.text componentsSeparatedByCharactersInSet:lineSeparators];
	int lineCount = 0;
	for (NSString* paragrah in paragraphs) {
		NSArray* words = [paragrah componentsSeparatedByCharactersInSet:separators];
		BOOL finalLine = NO;
		int wordCount = -1;
	
		while (!finalLine) {
			CGFloat lineLength = 0.0f;
			NSString* lineString = @"";
			NSString* lineStringBeforeAddingWord = @"";
			
			// creation of the SKLabelNode itself
			SKLabelNode* lineNode = [SKLabelNode labelNodeWithFontNamed:self.fontName];
			// name each label node for animation purposes, if needed (0 based)
			lineNode.name = [NSString stringWithFormat:@"line%u",lineCount];
			lineNode.horizontalAlignmentMode = _alignment;
			lineNode.verticalAlignmentMode=SKLabelVerticalAlignmentModeTop;
			lineNode.fontSize = _fontSize;
			lineNode.fontColor = _fontColor;
			lineNode.zPosition = self.zPosition+1;
			
			while (lineLength < self.labelWidth) {
				wordCount+=1;
				if (wordCount > words.count-1) {
					finalLine = YES;
					break;
				} else {
					lineStringBeforeAddingWord = lineString;
					lineString = [lineString stringByAppendingString:@" "];
					lineString = [lineString stringByAppendingString:(NSString*)[words objectAtIndex:wordCount]];
					lineNode.text = lineString;
					lineLength = lineNode.frame.size.width;
				}
			}
			if (lineLength > 0) {
				wordCount--;
				if (!finalLine) {
					if ([lineStringBeforeAddingWord isEqualToString:@""]) {
						// Words don't fit! Decrease the font size of increase the labelWidth (\"\(lineString)\")
						break;
					}
					lineString = lineStringBeforeAddingWord;
				}
				lineNode.text = lineString;
				switch (_alignment) {
					case SKLabelHorizontalAlignmentModeCenter:
						lineNode.position = CGPointMake(_labelWidth/2.0, -self.leading*lineCount);
						break;
					case SKLabelHorizontalAlignmentModeLeft:
						lineNode.position = CGPointMake(0, -self.leading*lineCount);
						break;
					case SKLabelHorizontalAlignmentModeRight:
						lineNode.position = CGPointMake(_labelWidth, -self.leading*lineCount);
						break;
				}
				[self addChild:lineNode];
			}
			lineCount++;
		}
	}
	self.labelHeight = lineCount * self.leading;
	[self showBorder];
}

- (void) showBorder{
	if (!_shouldShowBorder) {
		return;
	}
	[self removeChildrenInArray: [self.borderRect children]];
	self.borderRect = [SKShapeNode shapeNodeWithRectOfSize:CGSizeMake(self.labelWidth, self.labelHeight)];
	self.borderRect.zPosition = self.zPosition+1;
	self.borderRect.strokeColor = [SKColor whiteColor];
	self.borderRect.lineWidth = 1;
	self.borderRect.position = CGPointOffset(self.position, self.labelWidth/2.0, -self.labelHeight/2.0);
	[self addChild:self.borderRect];
}



#pragma mark - Getters and setters

- (void) setLabelWidth:(CGFloat)width {
	_labelWidth = width;
	[self update];
}

- (CGFloat) getLabelWidth {
	return _labelWidth;
}


- (void) setText:(NSString*)text {
	if (![_text isEqualToString:text]) {
		[_text release];
		_text = [text retain];
		[self update];
	}
}

- (NSString*) getText {
	return _text;
}


- (void) setFontName:(NSString*)newFontName {
	if (![_fontName isEqualToString:newFontName]) {
		[_fontName release];
		_fontName = [newFontName retain];
		[self update];
	}
}

- (NSString*) getFontName {
	return _fontName;
}


- (void) setFontSize:(CGFloat)newFontSize {
	_fontSize = newFontSize;
	if (_leading==0) {
		_leading=newFontSize;
	}
	[self update];
}

- (CGFloat) getFontSize {
	return _fontSize;
}


- (void) setFontColor:(SKColor*)color {
	[_fontColor release];
	_fontColor = [color retain];
	[self update];
}

- (SKColor*) getFontColor {
	return _fontColor;
}


- (void) setLeading:(CGFloat)leading {
	_leading = leading;
	[self update];
}

- (CGFloat) getLeading {
	return _leading;
}


- (void) setAlignment:(SKLabelHorizontalAlignmentMode)newAlignment {
	if (_alignment!=newAlignment) {
		_alignment = newAlignment;
		[self update];
	}
}

- (SKLabelHorizontalAlignmentMode) getAlignment {
	return _alignment;
}


- (void) setDontUpdate:(bool)dontUpdate {
	_dontUpdate = dontUpdate;
	if (!dontUpdate) {
		[self update];
	}
}

- (bool) getDontUpdate {
	return _dontUpdate;
}


- (void) setShouldShowBorder:(bool)show {
	_shouldShowBorder = show;
	[self update];
}

- (bool) getShouldShowBorder {
	return _shouldShowBorder;
}


@end
