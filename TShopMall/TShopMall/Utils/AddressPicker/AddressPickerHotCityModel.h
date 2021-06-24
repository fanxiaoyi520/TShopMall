//
//  AddressPickerHotCityModel.h
//  TCLPlus
//
//  Created by kobe on 2020/11/9.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@interface HotCityAddressModel : NSObject
@property (nonatomic, copy, nullable) NSString *version;
@property (nonatomic, copy, nullable) NSString *errCode;
@property (nonatomic, copy, nullable) NSString *errMessage;
@property (nonatomic, strong, nullable) NSArray *list;

- (void)fetchHotCityAddress:(NSDictionary *)params
                    success:(void (^)(BOOL isSuc, HotCityAddressModel *response))success
                    failure:(void (^)(HotCityAddressModel *response))failure;

@end


@interface AddressPickerHotCityModel : NSObject <NSCoding>
@property (nonatomic, strong, nullable) NSString *version;
@property (nonatomic, strong, nullable) NSArray *data;

- (void)saveHotCityModel:(AddressPickerHotCityModel *)model;
- (AddressPickerHotCityModel *)fetchHotCityModel;
- (BOOL)deleteHotCityModel;

@end


@interface AddressPickerHotCityItemModel : NSObject
@property (nonatomic, copy, nullable) NSString *pinYin;
@property (nonatomic, copy, nullable) NSString *uuid;
@property (nonatomic, copy, nullable) NSString *provinceUuid;
@property (nonatomic, copy, nullable) NSString *cityName;
@property (nonatomic, copy, nullable) NSString *provinceName;
@end


NS_ASSUME_NONNULL_END
