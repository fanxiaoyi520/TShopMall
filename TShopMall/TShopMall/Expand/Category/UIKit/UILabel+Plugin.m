//
//  UILabel+Plugin.m
//  TCLSmartHome
//
//  Created by LeonDeng on 2019/5/23.
//  Copyright © 2019 TCLIOT. All rights reserved.
//

#import <CoreText/CoreText.h>

#import "UIColor+Plugin.h"
#import "UILabel+Plugin.h"

CGFloat const tcl_standardLineSpace18 = 24;
CGFloat const tcl_standardLineSpace16 = 22;
CGFloat const tcl_standardLineSpace14 = 20;
CGFloat const tcl_standardLineSpace13 = 18;
CGFloat const tcl_standardLineSpace12 = 16;
CGFloat const tcl_standardLineSpace10 = 14;


@interface UILabel ()

@property (nonatomic, strong) UIView *redDotRunTime;

@end


@implementation UILabel (Plugin)

- (void)setText:(NSString *)text lineSpacing:(CGFloat)lineSpacing {
    if (!text || lineSpacing < 0.01) {
        self.text = text;
        return;
    }
    self.numberOfLines = 0;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:lineSpacing]; //设置行间距
    [paragraphStyle setLineBreakMode:self.lineBreakMode];
    [paragraphStyle setAlignment:self.textAlignment];

    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    self.attributedText = attributedString;
}


- (_Nonnull instancetype)initWithTCLStandard:(TCLFontType)fontType Frame:(CGRect)frame {
    self = [self initWithFrame:frame];
    if (self) {
        self.font = [UIFont TCLFont:fontType];
    }
    return self;
}

+ (NSArray *)linesArrayOfStringInLabel:(UILabel *)label {
    NSString *text = [label text];
    UIFont *font = [label font];
    CGRect rect = [label frame];

    NSString *fontName = font.fontName;
    if ([fontName isEqualToString:@".SFUI-Regular"]) {
        fontName = @"TimesNewRomanPSMT";
    }

    CTFontRef myFont = CTFontCreateWithName((CFStringRef)(fontName), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge id)myFont range:NSMakeRange(0, attStr.length)];
    CFRelease(myFont);
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attStr);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, rect.size.width, 100000));
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    NSArray *lines = (NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc] init];
    for (id line in lines) {
        CTLineRef lineRef = (__bridge CTLineRef)line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        NSString *lineString = [text substringWithRange:range];
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr, lineRange, kCTKernAttributeName, (CFTypeRef)([NSNumber numberWithFloat:0.0]));
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr, lineRange, kCTKernAttributeName, (CFTypeRef)([NSNumber numberWithInt:0.0]));

        [linesArray addObject:lineString];
    }

    CGPathRelease(path);
    CFRelease(frame);
    CFRelease(frameSetter);
    return (NSArray *)linesArray;
}

- (NSInteger)lines {
    // 总文字的高度
    CGFloat textH = [self.text boundingRectWithSize:self.frame.size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: self.font}
                                            context:nil]
                        .size.height;
    // 每行文字的高度
    CGFloat lineHeight = self.font.lineHeight;
    // 行数
    NSInteger lineCount = textH / lineHeight;
    return lineCount;
}


+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space {
    NSString *labelText = label.text;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:labelText attributes:@{NSKernAttributeName: @(space)}];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [labelText length])];
    label.attributedText = attributedString;
    [label sizeToFit];
}

@end
