//
//  UIView+CMSDrawLine.h
//  CMSPaaS
//
//  Created by SJ on 2020/10/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (CMSDrawLine)


- (UIView *)cms_addLineAt:(CGPoint)origin
           isVertical:(BOOL)isVertical
               length:(CGFloat)length;

- (CALayer *)cms_drawLineAt:(CGPoint)origin
             isVertical:(BOOL)isVertical
                 length:(CGFloat)length
                  color:(UIColor *)color;

- (CALayer *)cms_drawLineAt:(CGPoint)origin
              lineWidth:(CGFloat)width
             isVertical:(BOOL)isVertical
                 length:(CGFloat)length
                  color:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
