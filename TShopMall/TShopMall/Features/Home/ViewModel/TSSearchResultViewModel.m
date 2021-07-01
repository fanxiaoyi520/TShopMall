//
//  TSSearchResultViewModel.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/21.
//

#import "TSSearchResultViewModel.h"

@implementation TSSearchResultViewModel
- (instancetype)initWithList:(TSSearchList *)list{
    TSSearchResultViewModel *vm = [TSSearchResultViewModel new];
    vm.icon = list.pic;
    vm.name = list.name;
    vm.price = list.promotionPrice;
    vm.earnPrice = list.earnMost;
    vm.thPrice = list.baseRetailPrice;
    vm.uuid = list.productUuid;
    return vm;
}
@end
