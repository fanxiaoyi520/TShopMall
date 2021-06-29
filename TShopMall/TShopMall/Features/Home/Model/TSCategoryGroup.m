//
//  TSCategoryGroup.m
//  TShopMall
//
//  Created by sway on 2021/6/14.
//

#import "TSCategoryGroup.h"

@implementation TSCategoryGroup
- (instancetype)init
{
    self = [super init];
    if (self) {
        _list = @[].mutableCopy;
    }
    return self;
}
@end
