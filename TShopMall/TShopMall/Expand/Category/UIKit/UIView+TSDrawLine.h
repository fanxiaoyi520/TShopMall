//
//  UIView+TSDrawLine.h
//  
//
//  Created by SJ on 2020/10/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (TSDrawLine)


- (UIView *)ts_addLineAt:(CGPoint)origin
           isVertical:(BOOL)isVertical
               length:(CGFloat)length;

- (CALayer *)ts_drawLineAt:(CGPoint)origin
             isVertical:(BOOL)isVertical
                 length:(CGFloat)length
                  color:(UIColor *)color;

- (CALayer *)ts_drawLineAt:(CGPoint)origin
              lineWidth:(CGFloat)width
             isVertical:(BOOL)isVertical
                 length:(CGFloat)length
                  color:(UIColor *)color;

@end

NS_ASSUME_NONNULL_END
