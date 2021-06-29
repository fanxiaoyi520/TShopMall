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

+ (NSArray<TSAreaModel *> *)hotCities{
    NSArray *arr = @[
        @{
            @"cityName" : @"北京市",
            @"uuid" : @"116",
            @"provinceName" : @"北京",
            @"provinceUuid" : @"02"
        },
        @{
            @"cityName" : @"上海市",
            @"uuid" : @"386",
            @"provinceName" : @"上海",
            @"provinceUuid" : @"24"
        },
        @{
            @"cityName" : @"广州市",
            @"uuid" : @"143",
            @"provinceName" : @"广东省",
            @"provinceUuid" : @"05"
        },
        @{
            @"cityName" : @"深圳市",
            @"uuid" : @"154",
            @"provinceName" : @"广东省",
            @"provinceUuid" : @"05"
        },
        @{
            @"cityName" : @"杭州市",
            @"uuid" : @"450",
            @"provinceName" : @"浙江省",
            @"provinceUuid" : @"30"
        },
        @{
            @"cityName" : @"南京市",
            @"uuid" : @"288",
            @"provinceName" : @"江苏省",
            @"provinceUuid" : @"15"
        },
        @{
            @"cityName" : @"苏州市",
            @"uuid" : @"290",
            @"provinceName" : @"江苏省",
            @"provinceUuid" : @"15"
        },
        @{
            @"cityName" : @"三亚市",
            @"uuid" : @"198",
            @"provinceName" : @"海南省",
            @"provinceUuid" : @"08"
        },
        @{
            @"cityName" : @"荆州市",
            @"uuid" : @"250",
            @"provinceName" : @"湖北省",
            @"provinceUuid" : @"12"
        },
        @{
            @"cityName" : @"长沙市",
            @"uuid" : @"274",
            @"provinceName" : @"湖南省",
            @"provinceUuid" : @"13"
        },
        @{
            @"cityName" : @"重庆市",
            @"uuid" : @"461",
            @"provinceName" : @"重庆",
            @"provinceUuid" : @"31"
        },
        @{
            @"cityName" : @"西宁市",
            @"uuid" : @"346",
            @"provinceName" : @"青海省",
            @"provinceUuid" : @"20"
        },
    ];
    
    return [NSArray yy_modelArrayWithClass:TSAreaModel.class json:arr];
}

@end
