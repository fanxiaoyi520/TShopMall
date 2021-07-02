//
//  TSCityModel.h
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/7/1.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSCityListModel : NSObject


@property (nonatomic ,copy) NSString *uuid;
@property (nonatomic ,copy) NSString *delFlag;
@property (nonatomic ,copy) NSString *provinceUuid;
@property (nonatomic ,copy) NSString *cityName;
@end

NS_ASSUME_NONNULL_END
