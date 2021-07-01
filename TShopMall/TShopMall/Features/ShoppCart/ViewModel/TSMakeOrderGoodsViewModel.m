//
//  TSMakeOrderGoodsViewModel.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/24.
//

#import "TSMakeOrderGoodsViewModel.h"

@implementation TSMakeOrderGoodsViewModel
- (instancetype)initWithDetail:(TSBalanceCartManagerDetailModel *)detail{
    if (self == [super init]) {
        self.productName = detail.productName;
        self.productImgUrl = detail.productImgUrl;
        self.attr = detail.attrValues.count==0? @"":[detail.attrValues lastObject].name;
        self.price = detail.basePrice;
        self.buyNum = detail.buyNum;
        self.productUuid = detail.uuid;
    }
    return self;
}
- (NSString *)price{
    return [NSString stringWithFormat:@"%d", _price.intValue];
}

@end
