//
//  TSSelectorViewController.h
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/25.
//

#import "TSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSSelectorViewController : UIViewController

@property (nonatomic ,copy) void (^selectBankBlock)(id _Nullable info);
@end

NS_ASSUME_NONNULL_END
