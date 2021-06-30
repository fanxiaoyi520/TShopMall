//
//  TSMineWalletModel.h
//  TShopMall
//
//  Created by 林伟 on 2021/6/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSMineWalletModel : NSObject

@end

///收益
@interface TSMineWalletEarningModel : NSObject
@property (nonatomic ,copy) NSString *arrivalAmount;
@property (nonatomic ,copy) NSString *bankCardNo;
@property (nonatomic ,copy) NSString *noArrivalAmount;
@property (nonatomic ,copy) NSString *totalRevenue;
@property (nonatomic ,copy) NSString *bankCardId;
@property (nonatomic ,assign) BOOL eyeIsOn;
@end

NS_ASSUME_NONNULL_END
