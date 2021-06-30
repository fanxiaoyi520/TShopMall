//
//  TSMainViewController.h
//  TShopMall
//
//  Created by  on 2021/6/28.
//

#import <UIKit/UIKit.h>
#import "TSBaseViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface TSMainViewController : TSBaseViewController
@property (nonatomic, copy) void(^ _Nonnull rootViewControllerBlock)(UIViewController *vc);

@end

NS_ASSUME_NONNULL_END
