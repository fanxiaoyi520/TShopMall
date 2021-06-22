//
//  TSProductFooterView.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/21.
//

#import "TSProductFooterView.h"

@implementation TSProductFooterView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor orangeColor];
    }
    return self;
}

#pragma mark - Getter
//-(UIButton *)addButton{
//    if (!_addButton) {
//        _addButton =  [UIButton buttonWithType:UIButtonTypeCustom];
//        UIImage *image = [UIImage imageNamed:@"buy_left_bg"];
//        UIImage *stretchImage = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:0];
//        [_addButton setBackgroundImage:stretchImage forState:UIControlStateNormal];
//        [_addButton setBackgroundImage:stretchImage forState:UIControlStateHighlighted];
//        [_addButton setString:@"加入采购篮".localizationStr textColor:KWhiteColor font:KRegularFont(16.0) forState:UIControlStateNormal];
//        [_addButton addTarget:self action:@selector(addCartEvent:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _addButton;
//}
//
//-(UIButton *)buyButton{
//    if (!_buyButton) {
//        _buyButton =  [UIButton buttonWithType:UIButtonTypeCustom];
//        UIImage *image = [UIImage imageNamed:@"buy_bg"];
//        UIImage *stretchImage = [image stretchableImageWithLeftCapWidth:image.size.width * 0.5 topCapHeight:0];
//        [_buyButton setBackgroundImage:stretchImage forState:UIControlStateNormal];
//        [_buyButton setBackgroundImage:stretchImage forState:UIControlStateHighlighted];
//        [_buyButton setString:@"立即购买".localizationStr textColor:KWhiteColor font:KRegularFont(16.0) forState:UIControlStateNormal];
//        [_buyButton addTarget:self action:@selector(buyEvent:) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _buyButton;
//}

@end
