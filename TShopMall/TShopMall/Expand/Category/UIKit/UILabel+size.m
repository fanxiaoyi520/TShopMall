//
//  UILabel+size.m
//  TCLPlus
//
//  Created by OwenChen on 2020/7/17.
//  Copyright © 2020 TCL. All rights reserved.
//

#import "UILabel+size.h"


@implementation UILabel (size)

+ (CGFloat)labelHeightWithText:(NSString *)text width:(CGFloat)width font:(UIFont *)font {
    if (![text isKindOfClass:[NSString class]] && ![text isKindOfClass:[NSMutableString class]]) {
        return 0.0;
    }

    CGRect rect = [text boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font}
                                     context:nil];
    return rect.size.height + 5.0;
}

+ (CGFloat)labelWidthWithText:(NSString *)text height:(CGFloat)height font:(UIFont *)font {
    if (![text isKindOfClass:[NSString class]] && ![text isKindOfClass:[NSMutableString class]]) {
        return 0.0;
    }

    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: font}
                                     context:nil];
    return rect.size.width + 5.0;
}

+ (CGSize)labelSizehWithText:(NSString *)text font:(UIFont *)font {
    if (![text isKindOfClass:[NSString class]] && ![text isKindOfClass:[NSMutableString class]]) {
        return CGSizeZero;
    }

    CGRect rect = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName: font}
                                     context:nil];
    return rect.size;
}

+ (CGFloat)labelHeightWithAttributedString:(NSAttributedString *)attributedString width:(CGFloat)width {
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.attributedText = attributedString;
    CGSize fitSize = [label sizeThatFits:CGSizeMake(width, MAXFLOAT)];
    CGFloat height = fitSize.height + 10.0;
    return height;
}

+ (CGFloat)labelWidthWithAttributedString:(NSAttributedString *)attributedString height:(CGFloat)height {
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.attributedText = attributedString;
    CGSize fitSize = [label sizeThatFits:CGSizeMake(MAXFLOAT, height)];
    CGFloat width = fitSize.width + 2.0;
    return width;
}

@end
