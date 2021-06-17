//
//  TSHomePageContainerGroup.m
//  TShopMall
//
//  Created by sway on 2021/6/14.
//

#import "TSHomePageContainerGroup.h"

@implementation TSHomePageContainerGroup
- (instancetype)init
{
    self = [super init];
    if (self) {
        _list = @[].mutableCopy;
    }
    return self;
}
@end
