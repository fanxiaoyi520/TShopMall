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


@end
