//
//  TSWithdrawalViewController.h
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/24.
//

#import "TSBaseViewController.h"
#import "TSMineDataController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol WithdrawalDelegate <NSObject>

- (void)withdrawalPasswordNotSet:(id _Nullable)sender;
- (void)withdrawalApplication:(id _Nullable)sender;
- (void)forgetThePassword:(id _Nullable)sender;
@end
@interface TSWithdrawalViewController : UIViewController

@property (nonatomic ,assign) id<WithdrawalDelegate> kDelegate;
@property (nonatomic ,strong) TSMineDataController *kDataController;
@end

NS_ASSUME_NONNULL_END
