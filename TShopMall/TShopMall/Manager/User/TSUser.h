//
//  TSUser.h
//  TShopMall
//
//  Created by edy on 2021/6/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSUser : NSObject<NSCopying>
/** 账户id  */
@property(nonatomic, copy) NSString *accountId;
/** 地址  */
@property(nonatomic, copy) NSString *addressText;
/** appid  */
@property(nonatomic, copy) NSString *appId;
/** 应用名称appName  */
@property(nonatomic, copy) NSString *appName;
/** 地区  */
@property(nonatomic, copy) NSString *area;
/** 头像  */
@property(nonatomic, copy) NSString *avatar;
/** 生日  */
@property(nonatomic, copy) NSString *birthday;
/** 城市  */
@property(nonatomic, copy) NSString *city;
/** 省份  */
@property(nonatomic, copy) NSString *province;
/** 国家  */
@property(nonatomic, copy) NSString *country;
/** 邮箱 */
@property(nonatomic, copy) NSString *email;
/** 身份证  */
@property(nonatomic, copy) NSString *identity;
/** institutionUser  */
@property(nonatomic, copy) NSString *institutionUser;
/** 昵称  */
@property(nonatomic, copy) NSString *nickname;
/** permissionValue  */
@property(nonatomic, copy) NSString *permissionValue;
/** personalUser  */
@property(nonatomic, copy) NSString *personalUser;
/** 手机号  */
@property(nonatomic, copy) NSString *phone;
/** regRegion  */
@property(nonatomic, copy) NSString *regRegion;
/** region  */
@property(nonatomic, copy) NSString *region;
/** 性别1、男，2、女  */
@property(nonatomic, copy) NSString *sex;
/** 用户类型  */
@property(nonatomic, copy) NSString *userType;
/** 用户姓名  */
@property(nonatomic, copy) NSString *username;

@end

NS_ASSUME_NONNULL_END
