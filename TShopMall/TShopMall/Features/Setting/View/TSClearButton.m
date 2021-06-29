//
//  TSClearButton.m
//  TShopMall
//
//  Created by edy on 2021/6/29.
//

#import "TSClearButton.h"

@implementation TSClearButton

- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGFloat width = 16;
    CGFloat x = (contentRect.size.width - width) / 2.0;
    CGFloat y = (contentRect.size.height - width) / 2.0;
    return CGRectMake(x, y, width, width);
}

- (void)setHighlighted:(BOOL)highlighted {}

@end
