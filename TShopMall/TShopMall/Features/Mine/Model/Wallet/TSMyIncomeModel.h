//
//  TSMyIncomeModel.h
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSMyIncomeModel : NSObject

@property (nonatomic ,copy) NSString *arrivalAmount;
@property (nonatomic ,copy) NSString *bankCardId;
@property (nonatomic ,copy) NSString *bankCardNo;
@property (nonatomic ,copy) NSString *noArrivalAmount;
@property (nonatomic ,copy) NSString *totalRevenue;
@property (nonatomic ,copy) NSString *withdrawalRate;//税率
@property (nonatomic ,copy) NSString *accumulatedAmount;//累计提现金额
@end

NS_ASSUME_NONNULL_END
