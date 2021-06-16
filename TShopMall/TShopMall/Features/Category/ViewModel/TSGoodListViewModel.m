//
//  TSGoodListViewModel.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/15.
//

#import "TSGoodListViewModel.h"

@implementation TSGoodListViewModel
- (instancetype)initWithList:(TSSearchList *)list{
    TSGoodListViewModel *vm = [TSGoodListViewModel new];
    vm.icon = list.pic;
    vm.name = list.name;
    vm.price = list.promotionPrice;
    vm.earnPrice = [NSString stringWithFormat:@"%.2f", list.promotionPrice.floatValue - list.baseRetailPrice.floatValue];
    vm.thPrice = list.baseRetailPrice;
    return vm;
}
@end
