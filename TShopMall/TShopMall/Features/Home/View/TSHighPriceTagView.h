//
//  TSHighPriceTagView.h
//  TShopMall
//
//  Created by sway on 2021/6/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSHighPriceTagView : UIView
- (instancetype)initWithFrame:(CGRect)frame leftText:(NSString *)leftText rightText:(NSString *)rightText;
@property (nonatomic, strong) UILabel *leftLabel;
@property (nonatomic, strong) UILabel *rightLabel;
@end

NS_ASSUME_NONNULL_END
