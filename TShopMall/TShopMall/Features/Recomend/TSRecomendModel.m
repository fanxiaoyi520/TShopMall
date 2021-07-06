//
//  TSRecomendModel.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/22.
//

#import "TSRecomendModel.h"

@implementation TSRecomendModel
- (void)setData:(NSDictionary *)data{
    _listStyle = [data[@"listStyle"] integerValue];
    _padding = data[@"padding"];
    _goodsList = [NSArray yy_modelArrayWithClass:TSRecomendGoods.class json:data[@"goodsList"]];
    _sourceGoods = data[@"sourceGoods"];
    _goodsGroup = [NSArray yy_modelArrayWithClass:TSRecomendGoodsGroup.class json:data[@"goodsGroup"]];
}

@end


@implementation TSRecomendGoods
@synthesize name = _name;
- (NSString *)name{
    return self.productName;
}

@synthesize uuid;
- (NSString *)uuid{
    return self.goodsUuid;
}
@synthesize goodsPrice;
- (NSString *)goodsPrice{
    return self.price;
}
@synthesize goodsEarnMost;
- (NSString *)goodsEarnMost{
    return self.earnMost;
}
@synthesize goodsStaffPrice;
- (NSString *)goodsStaffPrice{
    return self.staffPrice;
}
@end

@implementation TSRecomendPageInfo

@end

@implementation TSRecomendGoodsGroup


@end
