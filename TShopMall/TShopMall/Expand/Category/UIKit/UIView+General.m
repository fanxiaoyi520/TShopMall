//
//  UIView+General.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/11.
//

#import "UIView+General.h"

@implementation UIView (General)
- (void)setCorners:(UIRectCorner)corners radius:(CGFloat)radius{
    [self layoutIfNeeded];
    if(@available(iOS 11.0, *)) {
        CACornerMask mask = kCALayerMinXMinYCorner;
        if (corners & UIRectCornerTopLeft) {
            mask |= kCALayerMinXMinYCorner;
        } else {
            mask ^= kCALayerMinXMinYCorner;
        }
        if (corners & UIRectCornerTopRight) {
            mask |= kCALayerMaxXMinYCorner;
        }
        if (corners & UIRectCornerBottomLeft) {
            mask |= kCALayerMinXMaxYCorner;
        }
        if (corners & UIRectCornerBottomRight) {
            mask |= kCALayerMaxXMaxYCorner;
        }
        
        self.layer.cornerRadius = radius;
        self.layer.maskedCorners = mask;
    } else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radius, radius)];
            CAShapeLayer *layer = [CAShapeLayer layer];
            layer.frame = self.bounds;
            layer.path = path.CGPath;
            self.layer.mask = layer;
 
        });
    }
}
@end
