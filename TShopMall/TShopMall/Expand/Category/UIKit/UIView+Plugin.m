//
//  UIView+Plugin.m
//  TCLSmartHome
//
//  Created by LeonDeng on 2019/5/24.
//  Copyright © 2019 TCLIOT. All rights reserved.
//

#import <Masonry/Masonry.h>

#import "UIColor+Plugin.h"
#import "UIView+Plugin.h"


@implementation UIView (Plugin)

- (UIEdgeInsets)eh_safeAreaInsets {
#if defined(__IPHONE_11_0)
    if (@available(iOS 11, *)) {
        return self.safeAreaInsets;
    }
#endif
    return UIEdgeInsetsZero;
}

- (CGFloat)frameCenterX {
    return self.frameX + self.frameWidth * 0.5;
}

- (CGFloat)frameCenterY {
    return self.frameY + self.frameHeight * 0.5;
}

- (CGPoint)frameCenter {
    return CGPointMake(self.frameCenterX, self.frameCenterY);
}

- (CGSize)frameSize {
    return self.frame.size;
}

- (void)setFrameSize:(CGSize)frameSize {
    CGRect fame = self.frame;
    fame.size = frameSize;
    self.frame = fame;
}

- (void)setFrameCenter:(CGPoint)frameCenter {
    self.frameCenterX = frameCenter.x;
    self.frameCenterY = frameCenter.y;
}

- (void)setFrameCenterY:(CGFloat)frameCenterY {
    CGRect frame = self.frame;
    self.frameY = frameCenterY - frame.size.height * 0.5;
}

- (void)setFrameCenterX:(CGFloat)frameCenterX {
    CGRect frame = self.frame;
    self.frameX = frameCenterX - frame.size.width * 0.5;
}

- (CGFloat)frameX {
    return CGRectGetMinX(self.frame);
}

- (void)setFrameX:(CGFloat)frameX {
    CGRect frame = self.frame;
    frame.origin.x = frameX;
    self.frame = frame;
}

- (CGFloat)frameY {
    return CGRectGetMinY(self.frame);
}

- (void)setFrameY:(CGFloat)frameY {
    CGRect frame = self.frame;
    frame.origin.y = frameY;
    self.frame = frame;
}

- (CGFloat)frameWidth {
    return CGRectGetWidth(self.frame);
}

- (void)setFrameWidth:(CGFloat)frameWidth {
    CGRect frame = self.frame;
    frame.size.width = frameWidth;
    self.frame = frame;
}

- (CGFloat)frameHeight {
    return CGRectGetHeight(self.frame);
}

- (void)setFrameHeight:(CGFloat)frameHeight {
    CGRect frame = self.frame;
    frame.size.height = frameHeight;
    self.frame = frame;
}

- (UIImage *)snapShotImage {
    CGSize size = self.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(size, YES, [UIScreen mainScreen].scale);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)setUnderLineWithColor:(UIColor *)color Height:(CGFloat)height {
    UIView *underLine = [[UIView alloc] initWithFrame:CGRectZero];
    underLine.backgroundColor = color;
    [self addSubview:underLine];
    [underLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.height.mas_equalTo(height);
        make.bottom.mas_equalTo(0);
    }];
}

- (void)shadowlizedWithCornerRadius:(CGFloat)radius {
    self.layer.cornerRadius = radius;
    self.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0, 0);
    self.layer.shadowOpacity = 0.3;
    self.layer.shadowRadius = 3;
}

- (void)setShadowPathWith:(UIColor *)shadowColor
            shadowOpacity:(CGFloat)shadowOpacity
             shadowRadius:(CGFloat)shadowRadius
               shadowSide:(ShadowPathSide)shadowPathSide
          shadowPathWidth:(CGFloat)shadowPathWidth {
    self.layer.masksToBounds = NO;
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowOpacity = shadowOpacity;
    self.layer.shadowRadius = shadowRadius;
    self.layer.shadowOffset = CGSizeZero;

    CGRect shadowRect;
    CGFloat originX = 0;
    CGFloat originY = 0;
    CGFloat originW = self.bounds.size.width;
    CGFloat originH = self.bounds.size.height;

    switch (shadowPathSide) {
        case ShadowPathSideTop:
            shadowRect = CGRectMake(originX, originY - shadowPathWidth / 2, originW, shadowPathWidth);
            break;
        case ShadowPathSideBottom:
            shadowRect = CGRectMake(originX, originH - shadowPathWidth / 2, originW, shadowPathWidth);
            break;
        case ShadowPathSideLeft:
            shadowRect = CGRectMake(originX - shadowPathWidth / 2, originY, shadowPathWidth, originH);
            break;
        case ShadowPathSideRight:
            shadowRect = CGRectMake(originW - shadowPathWidth / 2, originY, shadowPathWidth, originH);
            break;
        case ShadowPathSideAllSide:
            shadowRect = CGRectMake(originX - shadowPathWidth / 2, originY - shadowPathWidth / 2, originW + shadowPathWidth, originH + shadowPathWidth);
            break;
    }

    UIBezierPath *path = [UIBezierPath bezierPathWithRect:shadowRect];
    self.layer.shadowPath = path.CGPath;
}

- (void)setBorderWithCornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor type:(UIRectCorner)corners {
    CALayer *oldShaperLayer = nil;
    for (CALayer *layer in self.layer.sublayers) {
        if ([layer.name isEqualToString:@"cornerRadiusLayer"]) {
            oldShaperLayer = layer;
            break;
        }
    }
    if (oldShaperLayer) {
        [oldShaperLayer removeFromSuperlayer];
    }
    // 1. 加一个layer 显示形状
    CGRect rect = CGRectMake(borderWidth / 2.0, borderWidth / 2.0, CGRectGetWidth(self.frame) - borderWidth, CGRectGetHeight(self.frame) - borderWidth);
    CGSize radii = CGSizeMake(cornerRadius, borderWidth);

    // create path
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:corners cornerRadii:radii];

    // create shape layer
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.strokeColor = borderColor.CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;

    shapeLayer.lineWidth = borderWidth;
    shapeLayer.lineJoin = kCALineJoinRound;
    shapeLayer.lineCap = kCALineCapRound;
    shapeLayer.path = path.CGPath;
    shapeLayer.name = @"cornerRadiusLayer";

    [self.layer addSublayer:shapeLayer];
    // 2. 加一个layer 按形状 把外面的减去
    CGRect clipRect = CGRectMake(0, 0, CGRectGetWidth(self.frame) - 0, CGRectGetHeight(self.frame) - 0);
    CGSize clipRadii = CGSizeMake(cornerRadius, borderWidth);
    UIBezierPath *clipPath = [UIBezierPath bezierPathWithRoundedRect:clipRect byRoundingCorners:corners cornerRadii:clipRadii];

    CAShapeLayer *clipLayer = [CAShapeLayer layer];
    clipLayer.strokeColor = borderColor.CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;

    clipLayer.lineWidth = 0;
    clipLayer.lineJoin = kCALineJoinRound;
    clipLayer.lineCap = kCALineCapRound;
    clipLayer.path = clipPath.CGPath;

    self.layer.mask = clipLayer;
}

- (void)drawLineWithWidth:(CGFloat)width color:(UIColor *)borderCol starPiont:(CGPoint)startPiont endPoint:(CGPoint)endPoint {
    // 创建曲线
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 0;
    // 起点
    [path moveToPoint:startPiont];
    // 终点
    [path addLineToPoint:endPoint];

    // 创建layer
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.lineWidth = width;
    layer.strokeColor = borderCol.CGColor;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.path = path.CGPath;
    [self.layer addSublayer:layer];
}

@end
