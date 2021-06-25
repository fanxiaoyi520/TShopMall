//
//  TSAddressModel.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/17.
//

#import "TSAddressModel.h"

@implementation TSAddressModel
- (BOOL)isValid{
    NSString *str = [NSString stringWithFormat:@"%@\n%@\n%@\n%@\n%@", _provinceName,_cityName, _regionName, _streetName,_address];
    str = [str stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    if (str.length == 0) {
        return NO;
    }
    return YES;
}
@end
