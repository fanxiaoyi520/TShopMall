//
//  TSLocationInfoModel.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSLocationInfoModel : NSObject

@property(nonatomic, copy) NSString *provinceId;
@property(nonatomic, copy) NSString *cityId;
@property(nonatomic, copy) NSString *areaUuid;
@property(nonatomic, copy) NSString *region;
@property(nonatomic, copy) NSString *localaddress;

+(TSLocationInfoModel *)locationInfoModel;
-(void)saveLocationInfo;

@end

NS_ASSUME_NONNULL_END
