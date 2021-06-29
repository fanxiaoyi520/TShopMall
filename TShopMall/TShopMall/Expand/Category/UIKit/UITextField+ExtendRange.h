//
//  UITextField+ExtendRange.h
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextField (ExtendRange)

- (NSRange)selectedRange;

- (void)setSelectedRange:(NSRange)range;
@end

NS_ASSUME_NONNULL_END
