//
//  TSBankCardViewController.h
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/24.
//

#import "TSBaseViewController.h"
#import "TSMineDataController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSBankCardViewController : TSBaseViewController

@property (nonatomic ,strong) TSMineDataController *kDataController;
@property (nonatomic ,copy) NSString *sourceStr;// == @"TSMineWalletViewController"区分
@property (nonatomic ,copy)void (^sourceBlock)(id _Nullable info);
@end

NS_ASSUME_NONNULL_END
