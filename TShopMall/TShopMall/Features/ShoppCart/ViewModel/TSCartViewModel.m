//
//  TSCartViewModel.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/9.
//

#import "TSCartViewModel.h"

@implementation TSCartViewModel

- (instancetype)initWith:(TSCart *)goods{
    TSCartViewModel *vm = [TSCartViewModel new];
    vm.checked = goods.checked;
    vm.imgUrl = goods.productImgUrl;
    vm.name = goods.productName;
    vm.guige = goods.parentSkuNo;
    vm.buyNum = goods.buyNum;
    vm.thPrice = goods.singleMarketPrice;
    return vm;
}

@end
