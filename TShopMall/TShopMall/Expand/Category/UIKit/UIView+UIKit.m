//
//  UIView+UIKit.m
//  TCLPlus
//
//  Created by OwenChen on 2021/1/28.
//  Copyright © 2021 TCL Electronics Holdings Ltd. All rights reserved.
//

#import "UIView+UIKit.h"


@implementation UIView (UIKit)

- (void)setCornerWithLeftTopCorner:(CGFloat)leftTop
                    rightTopCorner:(CGFloat)rightTop
                  bottomLeftCorner:(CGFloat)bottemLeft
                 bottomRightCorner:(CGFloat)bottemRight {
    if (leftTop == rightTop && rightTop == bottemLeft && bottemLeft == bottemRight) {
        self.layer.cornerRadius = leftTop;
        self.clipsToBounds = YES;
    } else {
        CGFloat width = self.bounds.size.width;
        CGFloat height = self.bounds.size.height;

        UIBezierPath *maskPath = [UIBezierPath bezierPath];
        maskPath.lineWidth = 1.0;
        maskPath.lineCapStyle = kCGLineCapRound;
        maskPath.lineJoinStyle = kCGLineJoinRound;
        [maskPath moveToPoint:CGPointMake(bottemRight, height)]; //左下角
        [maskPath addLineToPoint:CGPointMake(width - bottemRight, height)];

        [maskPath addQuadCurveToPoint:CGPointMake(width, height - bottemRight) controlPoint:CGPointMake(width, height)]; //右下角的圆弧
        [maskPath addLineToPoint:CGPointMake(width, rightTop)];                                                          //右边直线

        [maskPath addQuadCurveToPoint:CGPointMake(width - rightTop, 0) controlPoint:CGPointMake(width, 0)]; //右上角圆弧
        [maskPath addLineToPoint:CGPointMake(leftTop, 0)];                                                  //顶部直线

        [maskPath addQuadCurveToPoint:CGPointMake(0, leftTop) controlPoint:CGPointMake(0, 0)];              //左上角圆弧
        [maskPath addLineToPoint:CGPointMake(0, height - bottemLeft)];                                      //左边直线
        [maskPath addQuadCurveToPoint:CGPointMake(bottemLeft, height) controlPoint:CGPointMake(0, height)]; //左下角圆弧

        CAShapeLayer *maskLayer = [CAShapeLayer layer];
        maskLayer.frame = self.bounds;
        maskLayer.path = maskPath.CGPath;
        maskLayer.frame = self.bounds;
        maskLayer.path = maskPath.CGPath;
        self.layer.mask = maskLayer;
    }
}

- (void)setShadowWithOffset:(CGSize)offset
               shadowRadius:(CGFloat)radius
                shadowColor:(UIColor *)shadowColor
              shadowOpacity:(CGFloat)shadowOpacity
              leftTopCorner:(CGFloat)leftTop
             rightTopCorner:(CGFloat)rightTop
           bottomLeftCorner:(CGFloat)bottemLeft
          bottomRightCorner:(CGFloat)bottemRight {
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowOpacity = shadowOpacity;

    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;

    UIBezierPath *shadowPath = [UIBezierPath bezierPath];
    shadowPath.lineWidth = 1.0;
    shadowPath.lineCapStyle = kCGLineCapRound;
    shadowPath.lineJoinStyle = kCGLineJoinRound;
    [shadowPath moveToPoint:CGPointMake(bottemRight, height)]; //左下角
    [shadowPath addLineToPoint:CGPointMake(width - bottemRight, height)];

    [shadowPath addQuadCurveToPoint:CGPointMake(width, height - bottemRight) controlPoint:CGPointMake(width, height)]; //右下角的圆弧
    [shadowPath addLineToPoint:CGPointMake(width, rightTop)];                                                          //右边直线

    [shadowPath addQuadCurveToPoint:CGPointMake(width - rightTop, 0) controlPoint:CGPointMake(width, 0)]; //右上角圆弧
    [shadowPath addLineToPoint:CGPointMake(leftTop, 0)];                                                  //顶部直线

    [shadowPath addQuadCurveToPoint:CGPointMake(0, leftTop) controlPoint:CGPointMake(0, 0)];              //左上角圆弧
    [shadowPath addLineToPoint:CGPointMake(0, height - bottemLeft)];                                      //左边直线
    [shadowPath addQuadCurveToPoint:CGPointMake(bottemLeft, height) controlPoint:CGPointMake(0, height)]; //左下角圆弧

    self.layer.shadowPath = (__bridge CGPathRef _Nullable)(shadowPath);
}

@end
