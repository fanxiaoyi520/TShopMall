//
//  AddressPickerHotCityModel.m
//  TCLPlus
//
//  Created by kobe on 2020/11/9.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import <MJExtension/MJExtension.h>

#import "AddressPickerHotCityModel.h"

#define kHotCityPath \
    [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:@"TCL_HOT_CITY.data"]


@implementation HotCityAddressModel

- (void)fetchHotCityAddress:(NSDictionary *)params
                    success:(void (^)(BOOL, HotCityAddressModel *_Nonnull))success
                    failure:(void (^)(HotCityAddressModel *_Nonnull))failure {
//    GatewayService *service = [GatewayService defaultService];
//    [service fileAddressDownloadWithFileName:@"hot_address.json" success:^(FileAddressDownloadResponse *_Nonnull response) {
//        if (success) {
//            if (response.isResponseSuccess) {
//                NSMutableArray *arrs = [NSMutableArray array];
//                HotCityAddressModel *model = [HotCityAddressModel new];
//                model.version = response.version;
//                for (FileAddressDetailData *item in response.list) {
//                    AddressPickerHotCityItemModel *model = [AddressPickerHotCityItemModel new];
//                    model.pinYin = item.pinYin;
//                    model.uuid = item.uuid;
//                    model.provinceUuid = item.provinceUuid;
//                    model.cityName = item.cityName;
//                    model.provinceName = item.provinceName;
//                    [arrs addObject:model];
//                }
//                model.list = [arrs copy];
//                success(YES, model);
//            } else {
//                HotCityAddressModel *model = [HotCityAddressModel new];
//                model.errCode = response.rspCode;
//                model.errMessage = response.mapMessage;
//                success(NO, model);
//            }
//        }
//    } failure:^(FileAddressDownloadResponse *_Nonnull response) {
//        if (failure) {
//            HotCityAddressModel *model = [HotCityAddressModel new];
//            model.errCode = response.rspCode;
//            model.errMessage = response.mapMessage;
//            failure(model);
//        }
//    }];
}

@end


@implementation AddressPickerHotCityModel

MJCodingImplementation

    + (NSDictionary *)mj_objectClassInArray {
    // 数组内部是字典,要转成模型
    return @{@"data": [AddressPickerHotCityItemModel class]};
}

- (void)saveHotCityModel:(AddressPickerHotCityModel *)model {
    [NSKeyedArchiver archiveRootObject:model toFile:kHotCityPath];
}

- (AddressPickerHotCityModel *)fetchHotCityModel {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:kHotCityPath];
}

- (BOOL)deleteHotCityModel {
    NSError *error;
    return [[NSFileManager defaultManager] removeItemAtPath:kHotCityPath error:&error];
}

@end


@implementation AddressPickerHotCityItemModel
MJCodingImplementation @end
