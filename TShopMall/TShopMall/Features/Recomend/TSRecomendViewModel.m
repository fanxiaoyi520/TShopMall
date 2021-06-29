//
//  TSRecomendViewModel.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/22.
//

#import "TSRecomendViewModel.h"

@implementation TSRecomendViewModel
- (instancetype)iniWithGoods:(TSRecomendGoods *)goods{
    if (self == [super init]) {
        self.img = goods.imageUrl;
        self.name = goods.productName;
        self.price = goods.price;
        self.earn = goods.earnMost;
        self.thPrice = goods.staffPrice;
        self.uuid = goods.goodsUuid;
    }
    return self;
}
@end
