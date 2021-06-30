//
//  TSOperationBankTipsViewController.h
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/25.
//

#import "TSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger ,KPopToWhere) {
    KMyIncome = 0,
    KBankCardList = 1,
};
@interface TSOperationBankTipsViewController : TSBaseViewController

@property (nonatomic ,copy) NSString *kNavTitle;
@property (nonatomic ,assign) KPopToWhere popToWhere;
@end

NS_ASSUME_NONNULL_END
