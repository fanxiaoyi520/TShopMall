//
//  TSInputPasswordViewController.h
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/7/2.
//

#import "TSBaseViewController.h"
#import "TSMineDataController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol TSInputPasswordDelegate <NSObject>
- (void)setPaymentPassword:(id _Nullable)info isFinished:(BOOL)isFinished;
- (void)forgetPassAction:(id _Nullable)sender;
@end

@interface TSInputPasswordViewController : UIViewController

@property (nonatomic ,strong) TSMineDataController *kDataController;
@property (nonatomic ,copy) NSString *inputAmount;
@property (nonatomic ,assign) id <TSInputPasswordDelegate> kDelegate;

@end

NS_ASSUME_NONNULL_END
