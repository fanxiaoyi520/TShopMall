//
//  TSAddCardViewController.h
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/25.
//

#import "TSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger ,PopToWhere) {
    MyIncome = 0,
    BankCardList = 1,
};
@interface TSAddCardViewController : TSBaseViewController

@property (nonatomic ,assign) PopToWhere popToWhere;
@end

NS_ASSUME_NONNULL_END
