//
//  TSSelectAddressViewController.h
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/7/1.
//

#import "TSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@class TSAreaIndexView;
@interface TSSelectAddressViewController : UIViewController

@property (nonatomic ,copy) void (^selectAddressBlock)(id _Nullable info);
@end

NS_ASSUME_NONNULL_END
