//
//  UITextField+General.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (General)
@property (nonatomic, strong) UIColor *placeholderColor;
@property (nonatomic, strong) UIFont *placeholderFont;
- (void)setTextColor:(UIColor *)textColor fontType:(FontType)fontType fontSize:(CGFloat)fontSize;
- (void)setPlaceholderColor:(UIColor *)color fontType:(FontType)fontType fontSize:(CGFloat)fontSize;
@end

NS_ASSUME_NONNULL_END
