//
//  UIView+CMSDrawLine.m
//  CMSPaaS
//
//  Created by SJ on 2020/10/15.
//

#import "UIView+CMSDrawLine.h"

#define HEXCOLOR(hexValue)              [UIColor colorWithRed : ((CGFloat)((hexValue & 0xFF0000) >> 16)) / 255.0 green : ((CGFloat)((hexValue & 0xFF00) >> 8)) / 255.0 blue : ((CGFloat)(hexValue & 0xFF)) / 255.0 alpha : 1.0]


@implementation UIView (CMSDrawLine)

- (UIView *)cms_addLineAt:(CGPoint)origin
           isVertical:(BOOL)isVertical
               length:(CGFloat)length {
    
    CGFloat h = 1.0/[UIScreen mainScreen].scale;
    
    CGRect frame = (isVertical == NO
                    ? CGRectMake(origin.x, MAX(origin.y-h, 0), length, h)       // 水平
                    : CGRectMake(origin.x, origin.y, h, length) );              // 铅直
    
    UIView * line = [[UIView alloc] initWithFrame:frame];
    line.backgroundColor = HEXCOLOR(0xeeeeee);
    [self addSubview:line];
    
    return line;
}

- (CALayer *)cms_drawLineAt:(CGPoint)origin
              isVertical:(BOOL)isVertical
                  length:(CGFloat)length
                   color:(UIColor *)color {
    
    CALayer * layerLine = [self cms_drawLineAt:origin
                                 lineWidth:1.0/[UIScreen mainScreen].scale      // 单像素
                                isVertical:isVertical
                                    length:length
                                     color:color];
    return layerLine;
}

- (CALayer *)cms_drawLineAt:(CGPoint)origin
               lineWidth:(CGFloat)width
              isVertical:(BOOL)isVertical
                  length:(CGFloat)length
                   color:(UIColor *)color {
    
    CGFloat h = width;
    
    CGRect frame = (isVertical == NO
                    ? CGRectMake(origin.x, MAX(origin.y-h, 0), length, h)       // 水平
                    : CGRectMake(origin.x, origin.y, h, length) );              // 铅直
    
    CALayer * layerLine = [CALayer layer];
    layerLine.frame = frame;
    layerLine.backgroundColor = color.CGColor;
    
    [self.layer addSublayer:layerLine];
    
    return layerLine;
}

@end
