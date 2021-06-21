//
//  UIColor+General.h
//  T销客
//
//  Created by 橙子 on 2020/9/24.
//  Copyright © 2020 TCL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (General)
+ (UIColor *)RGB:(CGFloat)r andG:(CGFloat)g andB:(CGFloat)b alpha:(CGFloat) alp;
+ (UIColor *)colorWithHexString:(NSString *)hexString;
@end
