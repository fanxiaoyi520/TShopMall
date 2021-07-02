//
//  TSBalanceModel.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/24.
//

#import "TSBalanceModel.h"

@implementation TSBalanceModel
- (void)setAddressList:(NSArray<TSAddressModel *> *)addressList{
    _addressList = [NSArray yy_modelArrayWithClass:TSAddressModel.class json:addressList];
}

@end

@implementation TSBalanceCartManager

- (void)setDetailModelList:(NSArray<TSBalanceCartManagerDetailModel *> *)detailModelList{
    _detailModelList = [NSArray yy_modelArrayWithClass:TSBalanceCartManagerDetailModel.class json:detailModelList];
}
@end

@implementation TSBalanceCartManagerDetailModel
- (void)setAttrValues:(NSArray<TSBalanceAttrValue *> *)attrValues{
    _attrValues = [NSArray yy_modelArrayWithClass:TSBalanceAttrValue.class json:attrValues];
}

- (NSString *)attrValueStr{
    NSString *str = @"";
    for (TSBalanceAttrValue *attr in _attrValues) {
        str = [NSString stringWithFormat:@"%@%@%@", str, attr.name, attr.value];
    }
    return str;
}

@end


@implementation TSBalanceAttrValue


@end

@implementation TSBalanceIntegralNow

+ (NSDictionary<NSString *, id> *)modelCustomPropertyMapper{
    return @{@"nowId":@"id"};
}

@end
