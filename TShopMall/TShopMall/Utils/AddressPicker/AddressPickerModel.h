//
//  AddressPickerMoel.h
//  TCLPlus
//
//  Created by kobe on 2020/8/24.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface AddressPickerModel : NSObject

@end


@interface AddressPickerProvinceModel : NSObject
@property (nonatomic, strong, nullable) NSDictionary *sortDict;
@property (nonatomic, strong, nullable) NSString *errCode;
@property (nonatomic, strong, nullable) NSString *errMsg;

- (void)fetchProvinceWithSuccess:(void (^)(BOOL isSuc, AddressPickerProvinceModel *response))success
                         failure:(void (^)(AddressPickerProvinceModel *response))failure;
@end


@interface AddressPickerProvinceItemModel : NSObject
@property (nonatomic, copy, nullable) NSString *pinYin;
@property (nonatomic, copy, nullable) NSString *uuid;
@property (nonatomic, copy, nullable) NSString *provinceName;
@property (nonatomic, copy, nullable) NSString *stationCode;
@property (nonatomic, copy, nullable) NSString *stationName;
@property (nonatomic, assign) BOOL selectedLetter;
@end


@interface AddressPickerCityModel : NSObject
@property (nonatomic, strong, nullable) NSDictionary *sortDict;
@property (nonatomic, strong, nullable) NSString *errCode;
@property (nonatomic, strong, nullable) NSString *errMsg;

- (void)fetchCityWithProvinceUUID:(NSString *)provinceUuid
                          success:(void (^)(BOOL isSuc, AddressPickerCityModel *response))success
                          failure:(void (^)(AddressPickerCityModel *response))failure;
@end


@interface AddressPickerCityItemModel : NSObject
@property (nonatomic, copy, nullable) NSString *pinYin;
@property (nonatomic, copy, nullable) NSString *uuid;
@property (nonatomic, copy, nullable) NSString *provinceUuid;
@property (nonatomic, copy, nullable) NSString *cityName;
@property (nonatomic, assign) BOOL selectedLetter;
@end


@interface AddressPickerAreaModel : NSObject
@property (nonatomic, strong, nullable) NSDictionary *sortDict;
@property (nonatomic, strong, nullable) NSString *errCode;
@property (nonatomic, strong, nullable) NSString *errMsg;

- (void)fetchAreaWithCityUUID:(NSString *)cityUuid
                      success:(void (^)(BOOL isSuc, AddressPickerAreaModel *response))success
                      failure:(void (^)(AddressPickerAreaModel *response))failure;

@end


@interface AddressPickerAreaItemModel : NSObject
@property (nonatomic, copy, nullable) NSString *pinYin;
@property (nonatomic, copy, nullable) NSString *uuid;
@property (nonatomic, copy, nullable) NSString *cityUuid;
@property (nonatomic, copy, nullable) NSString *regionName;
@property (nonatomic, assign) BOOL selectedLetter;
@end


@interface AddressPickerTownModel : NSObject
@property (nonatomic, strong, nullable) NSDictionary *sortDict;
@property (nonatomic, strong, nullable) NSString *errCode;
@property (nonatomic, strong, nullable) NSString *errMsg;

- (void)fetchTownWithRegionUUID:(NSString *)regionUuid
                        success:(void (^)(BOOL isSuc, AddressPickerTownModel *response))success
                        failure:(void (^)(AddressPickerTownModel *response))failure;

@end


@interface AddressPickerTownItemModel : NSObject
@property (nonatomic, copy, nullable) NSString *pinYin;
@property (nonatomic, copy, nullable) NSString *uuid;
@property (nonatomic, copy, nullable) NSString *regionUuid;
@property (nonatomic, copy, nullable) NSString *streetName;
@property (nonatomic, assign) BOOL selectedLetter;
@end

NS_ASSUME_NONNULL_END
