//
//  UIView+Frame.m
//  TSale
//
//  Created by Daisy  on 2020/12/7.
//  Copyright © 2020 TCL. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (CGFloat)tcl_top
{
    return self.frame.origin.y;
}

- (void)setTcl_top:(CGFloat)tcl_top
{
    CGRect  frame = self.frame;
    frame.origin.y = tcl_top;
    self.frame  = frame;
}

- (CGFloat)tcl_left
{
    return self.frame.origin.x;
}

- (void)setTcl_left:(CGFloat)tcl_left
{
    CGRect  frame = self.frame;
    frame.origin.x = tcl_left;
    self.frame  = frame;
}

- (CGFloat)tcl_right
{
    return  CGRectGetMaxX(self.frame);
}

- (void)setTcl_right:(CGFloat)tcl_right
{
    self.tcl_x = tcl_right -  self.tcl_width;
}

- (CGFloat)tcl_bottom
{
    return  CGRectGetMaxY(self.frame);
}

-(void)setTcl_bottom:(CGFloat)tcl_bottom
{
    self.tcl_y = tcl_bottom - self.tcl_height;
}

-(void)setTcl_x:(CGFloat)tcl_x
{
    CGRect frame = self.frame;
    frame.origin.x = tcl_x;
    self.frame = frame;
}

- (void)setTcl_y:(CGFloat)tcl_y
{
    CGRect frame = self.frame;
    frame.origin.y = tcl_y;
    self.frame = frame;
}

- (CGFloat)tcl_x
{
    return  self.frame.origin.x;
}

-(CGFloat)tcl_y
{
    return self.frame.origin.y;
}

- (void)setTcl_centerX:(CGFloat)tcl_centerX
{
    CGPoint center = self.center;
    center.x = tcl_centerX;
    self.center = center;
}

-(CGFloat)tcl_centerX
{
    return self.center.x;
}

-(void)setTcl_centerY:(CGFloat)tcl_centerY
{
    CGPoint center = self.center;
    center.y = tcl_centerY;
    self.center = center;
}
-(CGFloat)centerY
{
    return self.center.y;
}

- (void)setTcl_width:(CGFloat)tcl_width
{
    CGRect frame = self.frame;
    frame.size.width = tcl_width;
    self.frame = frame;
}

- (void)setTcl_height:(CGFloat)tcl_height
{
    CGRect frame = self.frame;
    frame.size.height = tcl_height;
    self.frame = frame;
}

- (CGFloat)tcl_height
{
    return self.frame.size.height;
}

- (CGFloat)tcl_width
{
    return self.frame.size.width;
}

-(void)setTcl_size:(CGSize)tcl_size
{
    CGRect frame = self.frame;
    frame.size = tcl_size;
    self.frame = frame;
}

-(CGSize)tcl_size
{
    return self.frame.size;
}

-(void)setTcl_origin:(CGPoint)tcl_origin
{
    CGRect frame = self.frame;
    frame.origin = tcl_origin;
    self.frame = frame;
}

-(CGPoint)tcl_origin
{
    return self.frame.origin;
}


-(BOOL)intersectWithView:(UIView *)view
{
    UIWindow *window = nil;
    
    if (@available(iOS 13.0, *)) {
        window  =  [[UIApplication sharedApplication].windows firstObject];
    } else
    {
        window  =  [UIApplication sharedApplication].keyWindow;
    }
  
    CGRect selfRect  = [self convertRect:self.bounds toView:window];
    CGRect viewRect = [view convertRect:view.bounds toView:window];
    return CGRectIntersectsRect(selfRect, viewRect);
}
-(UIViewController *)tcl_findViewContrlloer
{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}

-(instancetype)tcl_cornerAllCornersWithCornerRadius:(CGFloat)cornerRadius
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    shapeLayer.path = path.CGPath;
    self.layer.mask = shapeLayer;
    self.layer.contentsScale = [[UIScreen mainScreen] scale];
    return self;
}

-(instancetype)tcl_scornerByRoundCorners:(UIRectCorner)corners cornerRadius:(CGFloat)cornerRadius
{
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(cornerRadius, cornerRadius)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    self.layer.contentsScale = [[UIScreen mainScreen] scale];
    return self;
}
@end
