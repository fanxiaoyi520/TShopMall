//
//  AddressPickerMoel.m
//  TCLPlus
//
//  Created by kobe on 2020/8/24.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import <MJExtension/MJExtension.h>

#import "AddressPickerModel.h"


@implementation AddressPickerModel

@end


@implementation AddressPickerProvinceModel

- (void)fetchProvinceWithSuccess:(void (^)(BOOL, AddressPickerProvinceModel *_Nonnull))success failure:(void (^)(AddressPickerProvinceModel *_Nonnull))failure {
//    MallService *service = [MallService new];
//    [service addressProvinceSuccess:^(AddressProvinceResponse *_Nonnull response) {
//        if (success) {
//            if (response.isResponseSuccess) {
//                AddressPickerProvinceModel *provinceModel = [AddressPickerProvinceModel new];
//                NSMutableArray *arrs = [NSMutableArray array];
//                for (ProvinceAddressItem *item in response.list) {
//                    AddressPickerProvinceItemModel *model = [AddressPickerProvinceItemModel new];
//                    model.provinceName = item.provinceName;
//                    model.uuid = item.uuid;
//                    model.pinYin = item.pinYin;
//                    model.stationCode = item.stationCode;
//                    model.stationName = item.stationName;
//                    [arrs addObject:model];
//                }
//                [arrs sortUsingComparator:^NSComparisonResult(AddressPickerProvinceItemModel *obj1, AddressPickerProvinceItemModel *obj2) {
//                    return [obj1.pinYin compare:obj2.pinYin];
//                }];
//
//                // 排序数据处理
//                NSMutableDictionary *sortDict = [NSMutableDictionary dictionary];
//                NSMutableArray *sortArrs = [NSMutableArray array];
//                NSString *sortKey = nil;
//                NSInteger index = 0;
//
//                for (AddressPickerProvinceItemModel *model in arrs) {
//                    if (model.pinYin.length != 0) {
//                        NSString *key = [[model.pinYin substringToIndex:1] uppercaseString];
//                        if (sortKey.length == 0) {
//                            sortKey = key;
//                        }
//                        if ([sortKey isEqualToString:key]) {
//                            [sortArrs addObject:model];
//                            if (index == (arrs.count - 1)) {
//                                [sortDict setObject:[sortArrs copy] forKey:sortKey];
//                                [sortArrs removeAllObjects];
//                            }
//                        } else {
//                            [sortDict setObject:[sortArrs copy] forKey:sortKey];
//                            sortKey = key;
//                            [sortArrs removeAllObjects];
//                            [sortArrs addObject:model];
//                            if (index == (arrs.count - 1)) {
//                                [sortDict setObject:[sortArrs copy] forKey:sortKey];
//                                [sortArrs removeAllObjects];
//                            }
//                        }
//                        index++;
//                    }
//                }
//
//                provinceModel.sortDict = sortDict;
//                success(YES, provinceModel);
//
//            } else {
//                AddressPickerProvinceModel *provinceModel = [AddressPickerProvinceModel new];
//                provinceModel.errCode = response.code;
//                provinceModel.errMsg = response.mapMessage;
//                success(NO, provinceModel);
//            }
//        }
//    } failure:^(AddressProvinceResponse *_Nonnull response) {
//        if (failure) {
//            AddressPickerProvinceModel *provinceModel = [AddressPickerProvinceModel new];
//            provinceModel.errCode = response.code;
//            provinceModel.errMsg = response.mapMessage;
//            failure(provinceModel);
//        }
//    }];
}

@end


@implementation AddressPickerProvinceItemModel

@end


@implementation AddressPickerCityModel


- (void)fetchCityWithProvinceUUID:(NSString *)provinceUuid
                          success:(void (^)(BOOL, AddressPickerCityModel *_Nonnull))success
                          failure:(void (^)(AddressPickerCityModel *_Nonnull))failure {
//    MallService *service = [MallService new];
//    [service addressCityWithProvinceUUID:provinceUuid success:^(AddressCityResponse *_Nonnull response) {
//        if (success) {
//            if (response.isResponseSuccess) {
//                AddressPickerCityModel *cityModel = [AddressPickerCityModel new];
//                NSMutableArray *arrs = [NSMutableArray array];
//                for (CityAddressItem *item in response.list) {
//                    AddressPickerCityItemModel *model = [AddressPickerCityItemModel new];
//                    model.uuid = item.uuid;
//                    model.pinYin = item.pinYin;
//                    model.cityName = item.cityName;
//                    model.provinceUuid = item.provinceUuid;
//                    [arrs addObject:model];
//                }
//                [arrs sortUsingComparator:^NSComparisonResult(AddressPickerCityItemModel *obj1, AddressPickerCityItemModel *obj2) {
//                    return [obj1.pinYin compare:obj2.pinYin];
//                }];
//
//                // 数据处理
//                NSMutableDictionary *sortDict = [NSMutableDictionary dictionary];
//                NSMutableArray *sortArrs = [NSMutableArray array];
//                NSString *sortKey = nil;
//                NSInteger index = 0;
//
//                for (AddressPickerCityItemModel *model in arrs) {
//                    if (model.pinYin.length != 0) {
//                        NSString *key = [[model.pinYin substringToIndex:1] uppercaseString];
//                        if (sortKey.length == 0) {
//                            sortKey = key;
//                        }
//
//                        if ([sortKey isEqualToString:key]) {
//                            [sortArrs addObject:model];
//                            if (index == (arrs.count - 1)) {
//                                [sortDict setObject:[sortArrs copy] forKey:sortKey];
//                                [sortArrs removeAllObjects];
//                            }
//                        } else {
//                            [sortDict setObject:[sortArrs copy] forKey:sortKey];
//                            sortKey = key;
//                            [sortArrs removeAllObjects];
//                            [sortArrs addObject:model];
//                            if (index == (arrs.count - 1)) {
//                                [sortDict setObject:[sortArrs copy] forKey:sortKey];
//                                [sortArrs removeAllObjects];
//                            }
//                        }
//                        index++;
//                    }
//                }
//                cityModel.sortDict = sortDict;
//                success(YES, cityModel);
//            }
//        } else {
//            AddressPickerCityModel *cityModel = [AddressPickerCityModel new];
//            cityModel.errCode = response.code;
//            cityModel.errMsg = response.mapMessage;
//            success(NO, cityModel);
//        }
//    } failure:^(AddressCityResponse *_Nonnull response) {
//        if (failure) {
//            AddressPickerCityModel *cityModel = [AddressPickerCityModel new];
//            cityModel.errCode = response.code;
//            cityModel.errMsg = response.mapMessage;
//            failure(cityModel);
//        }
//    }];
}

@end


@implementation AddressPickerCityItemModel

@end


@implementation AddressPickerAreaModel

- (void)fetchAreaWithCityUUID:(NSString *)cityUuid
                      success:(void (^)(BOOL, AddressPickerAreaModel *_Nonnull))success
                      failure:(void (^)(AddressPickerAreaModel *_Nonnull))failure {
//    MallService *service = [MallService new];
//    [service addressDistrictWithCityUUID:cityUuid success:^(AddressDistrictResponse *_Nonnull response) {
//        if (success) {
//            if (response.isResponseSuccess) {
//                AddressPickerAreaModel *areaModel = [AddressPickerAreaModel new];
//                NSMutableArray *arrs = [NSMutableArray array];
//                for (DistrictAddressItem *item in response.list) {
//                    AddressPickerAreaItemModel *model = [AddressPickerAreaItemModel new];
//                    model.uuid = item.uuid;
//                    model.pinYin = item.pinYin;
//                    model.regionName = item.regionName;
//                    model.cityUuid = item.cityUuid;
//                    [arrs addObject:model];
//                }
//
//                [arrs sortUsingComparator:^NSComparisonResult(AddressPickerAreaItemModel *obj1, AddressPickerAreaItemModel *obj2) {
//                    return [obj1.pinYin compare:obj2.pinYin];
//                }];
//
//                // 数据处理
//                NSMutableDictionary *sortDict = [NSMutableDictionary dictionary];
//                NSMutableArray *sortArrs = [NSMutableArray array];
//                NSString *sortKey = nil;
//                NSInteger index = 0;
//
//                for (AddressPickerAreaItemModel *model in arrs) {
//                    if (model.pinYin.length != 0) {
//                        NSString *key = [[model.pinYin substringToIndex:1] uppercaseString];
//                        if (sortKey.length == 0) {
//                            sortKey = key;
//                        }
//
//                        if ([sortKey isEqualToString:key]) {
//                            [sortArrs addObject:model];
//                            if (index == (arrs.count - 1)) {
//                                [sortDict setObject:[sortArrs copy] forKey:sortKey];
//                                [sortArrs removeAllObjects];
//                            }
//                        } else {
//                            [sortDict setObject:[sortArrs copy] forKey:sortKey];
//                            sortKey = key;
//                            [sortArrs removeAllObjects];
//                            [sortArrs addObject:model];
//                            if (index == (arrs.count - 1)) {
//                                [sortDict setObject:[sortArrs copy] forKey:sortKey];
//                                [sortArrs removeAllObjects];
//                            }
//                        }
//                        index++;
//                    }
//                }
//                areaModel.sortDict = sortDict;
//                success(YES, areaModel);
//            } else {
//                AddressPickerAreaModel *areaModel = [AddressPickerAreaModel new];
//                areaModel.errCode = response.code;
//                areaModel.errMsg = response.mapMessage;
//                success(NO, areaModel);
//            }
//        }
//    } failure:^(AddressDistrictResponse *_Nonnull response) {
//        if (failure) {
//            AddressPickerAreaModel *areaModel = [AddressPickerAreaModel new];
//            areaModel.errCode = response.code;
//            areaModel.errMsg = response.mapMessage;
//            failure(areaModel);
//        }
//    }];
}

@end


@implementation AddressPickerAreaItemModel


@end


@implementation AddressPickerTownModel

- (void)fetchTownWithRegionUUID:(NSString *)regionUuid
                        success:(void (^)(BOOL, AddressPickerTownModel *_Nonnull))success
                        failure:(void (^)(AddressPickerTownModel *_Nonnull))failure {
//    MallService *service = [MallService new];
//    [service addressStreetWithRegionUUID:regionUuid success:^(AddressStreetResponse *_Nonnull response) {
//        if (success) {
//            if (response.isResponseSuccess) {
//                AddressPickerTownModel *townModel = [AddressPickerTownModel new];
//                NSMutableArray *arrs = [NSMutableArray array];
//                for (StreetAddressItem *item in response.list) {
//                    AddressPickerTownItemModel *model = [AddressPickerTownItemModel new];
//                    model.uuid = item.uuid;
//                    model.pinYin = item.pinYin;
//                    model.streetName = item.streetName;
//                    model.regionUuid = item.regionUuid;
//                    [arrs addObject:model];
//                }
//                [arrs sortUsingComparator:^NSComparisonResult(AddressPickerTownItemModel *obj1, AddressPickerTownItemModel *obj2) {
//                    return [obj1.pinYin compare:obj2.pinYin];
//                }];
//
//                // 数据处理
//                NSMutableDictionary *sortDict = [NSMutableDictionary dictionary];
//                NSMutableArray *sortArrs = [NSMutableArray array];
//                NSString *sortKey = nil;
//                NSInteger index = 0;
//
//                for (AddressPickerProvinceItemModel *model in arrs) {
//                    if (model.pinYin.length != 0) {
//                        NSString *key = [[model.pinYin substringToIndex:1] uppercaseString];
//                        if (sortKey.length == 0) {
//                            sortKey = key;
//                        }
//
//                        if ([sortKey isEqualToString:key]) {
//                            [sortArrs addObject:model];
//                            if (index == (arrs.count - 1)) {
//                                [sortDict setObject:[sortArrs copy] forKey:sortKey];
//                                [sortArrs removeAllObjects];
//                            }
//                        } else {
//                            [sortDict setObject:[sortArrs copy] forKey:sortKey];
//                            sortKey = key;
//                            [sortArrs removeAllObjects];
//                            [sortArrs addObject:model];
//                            if (index == (arrs.count - 1)) {
//                                [sortDict setObject:[sortArrs copy] forKey:sortKey];
//                                [sortArrs removeAllObjects];
//                            }
//                        }
//                        index++;
//                    }
//                }
//                townModel.sortDict = sortDict;
//                success(YES, townModel);
//
//            } else {
//                AddressPickerTownModel *townModel = [AddressPickerTownModel new];
//                townModel.errCode = response.code;
//                townModel.errMsg = response.mapMessage;
//                success(NO, townModel);
//            }
//        }
//    } failure:^(AddressStreetResponse *_Nonnull response) {
//        if (failure) {
//            AddressPickerTownModel *townModel = [AddressPickerTownModel new];
//            townModel.errCode = response.code;
//            townModel.errMsg = response.mapMessage;
//            failure(townModel);
//        }
//    }];
}

@end


@implementation AddressPickerTownItemModel

@end
