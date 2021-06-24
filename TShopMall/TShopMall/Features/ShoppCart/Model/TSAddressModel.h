//
//  TSAddressModel.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/17.
//

#import <Foundation/Foundation.h>


@interface TSAddressModel : NSObject
@property (nonatomic, copy) NSString *address;
@property (nonatomic, copy) NSString *alias;
@property (nonatomic, copy) NSString *area;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, copy) NSString *community;
@property (nonatomic, copy) NSString *consignee;
@property (nonatomic, copy) NSString *customerUuid;
@property (nonatomic, assign) BOOL delFlag;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, assign) BOOL isDefault;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *opeTime;
@property (nonatomic, copy) NSString *oper;
@property (nonatomic, copy) NSString *province;
@property (nonatomic, copy) NSString *provinceName;
@property (nonatomic, copy) NSString *region;
@property (nonatomic, copy) NSString *regionName;
@property (nonatomic, copy) NSString *street;
@property (nonatomic, copy) NSString *streetName;
@property (nonatomic, copy) NSString *tag;
@property (nonatomic, copy) NSString *telephone;
@property (nonatomic, copy) NSString *uuid;
@property (nonatomic, copy) NSString *zipcode;
@end

