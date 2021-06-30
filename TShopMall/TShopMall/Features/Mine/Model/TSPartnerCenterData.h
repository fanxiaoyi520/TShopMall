//
//  TSPartnerCenterData.h
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSPartnerCenterData : NSObject
//累计订单
@property (nonatomic ,copy) NSString *orderNum;
//累计金额
@property (nonatomic ,copy) NSString *orderMoney;
//自身贡献收入
@property (nonatomic ,copy) NSString *profitFromMyself;
//合伙人贡献收入
@property (nonatomic ,copy) NSString *profitFromPartner;
//
@property (nonatomic ,assign) BOOL eyeIsOn;
//分销等级
@property (nonatomic ,copy) NSString *rankLevel;
@end

NS_ASSUME_NONNULL_END
