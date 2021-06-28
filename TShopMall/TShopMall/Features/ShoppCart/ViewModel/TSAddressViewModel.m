//
//  TSAddressViewModel.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/24.
//

#import "TSAddressViewModel.h"

@implementation TSAddressViewModel
- (instancetype)initWithAddress:(TSAddressModel *)address{
    if (self == [super init]) {
        self = [TSAddressViewModel yy_modelWithDictionary:address.yy_modelToJSONObject];
    }
    return self;
}

- (NSString *)address{
    [_address stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    [_address stringByReplacingOccurrencesOfString:@"null" withString:@""];
    if (_address.length == 0) {
        return @"";
    }
    return _address;
}

@end
