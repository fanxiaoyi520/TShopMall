//
//  TSCartModel.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/9.
//

#import "TSCartModel.h"

@implementation TSCartModel

- (void)setCartStores:(NSArray<TSCartStore *> *)cartStores{
    _cartStores = [NSArray yy_modelArrayWithClass:TSCartStore.class json:cartStores];
}

- (void)setCarts:(NSArray<TSCart *> *)carts{
    _carts = [NSArray yy_modelArrayWithClass:TSCart.class json:carts];
}

@end

@implementation TSCartStore


@end

@implementation TSCart

- (void)setAttrValues:(NSArray<TSCartAttr *> *)attrValues{
    _attrValues = [NSArray yy_modelArrayWithClass:TSCartAttr.class json:attrValues];
}

- (void)setCouponList:(NSArray<TSCartCoupon *> *)couponList{
    _couponList = [NSArray yy_modelArrayWithClass:TSCartCoupon.class json:couponList];
}

- (BOOL)isEnough{
    if (_stockNo.integerValue != 0 &&
        _productWarning.length != 0 &&
        _productWarning.integerValue <= 2 ) {
        return NO;
    }
    return YES;
}

- (BOOL)isInvalid{
    if (!_onSell || !_suitOnSell || _stockNo == 0) {
        return YES;
    }
    return NO;
}

- (NSString *)invalidReson{
    if (!_onSell || !_suitOnSell) {
        return @"已经下架";
    }
    if (_onSell && _stockNo == 0) {
        return @"缺货";
    }
    if (_buyNum <= 0) {
        return @"购买数量少于一个";
    }
    return @"其他";
}

@end

@implementation TSCartAttr

@end


@implementation TSCartCoupon

@end
