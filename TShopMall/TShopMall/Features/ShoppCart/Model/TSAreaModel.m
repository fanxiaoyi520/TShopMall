//
//  TSAreaModel.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/18.
//

#import "TSAreaModel.h"

@implementation TSAreaModel
- (NSString *)currentShowName{
    if (self.cityName.length != 0) {
        return self.cityName;
    } else if (self.regionName != 0) {
        return self.regionName;
    } else if (self.streetName.length != 0) {
        return self.streetName;
    }
    
    return self.provinceName;
}

- (NSString *)currentUUid{
    if (self.cityName.length != 0) {
        return self.uuid;
    } else if (self.regionName != 0) {
        return self.uuid;
    } else if (self.streetName.length != 0) {
        return self.uuid;
    }
    
    return self.uuid;
}

- (NSString *)belongUuid{
    if (self.provinceUuid.length != 0) {
        return self.provinceUuid;
    } else if (self.cityUuid.length != 0) {
        return self.cityUuid;
    } else if (self.regionUuid.length != 0){
        return self.regionUuid;
    }
    return @"";
}
@end
