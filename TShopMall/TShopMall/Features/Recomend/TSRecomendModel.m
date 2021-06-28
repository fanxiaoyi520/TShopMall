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
@end

@implementation TSRecomendPageInfo

@end
