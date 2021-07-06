//
//  UITextField+General.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/12.
//

#import "UITextField+General.h"
#import <objc/runtime.h>

@implementation UITextField (General)

- (void)setTextColor:(UIColor *)textColor fontType:(FontType)fontType fontSize:(CGFloat)fontSize{
    self.textColor = textColor;
    self.font = [UIFont font:fontType size:fontSize];
}

- (void)setPlaceholder:(NSString *)placeholder{
    UIColor *color = self.placeholderColor==nil? KPlaceholderColor:self.placeholderColor;
    UIFont *font = self.placeholderFont==nil? KRegularFont(16.0):self.placeholderFont;
    if (!placeholder) return;
    NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:placeholder attributes:@{
        NSForegroundColorAttributeName : color,
        NSFontAttributeName : font
    }];
    self.attributedPlaceholder = attStr;
}

- (void)setPlaceholderColor:(UIColor *)color fontType:(FontType)fontType fontSize:(CGFloat)fontSize{
    self.placeholderColor = color;
    self.placeholderFont = [UIFont font:fontType size:fontSize];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    objc_setAssociatedObject(self, @"PlaceholderColorKey", placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)placeholderColor{
    return objc_getAssociatedObject(self, @"PlaceholderColorKey");
}

- (void)setPlaceholderFont:(UIFont *)placeholderFont{
    objc_setAssociatedObject(self, @"PlaceholderFontKey", placeholderFont, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIFont *)placeholderFont{
    return objc_getAssociatedObject(self, @"PlaceholderFontKey");
}
@end
