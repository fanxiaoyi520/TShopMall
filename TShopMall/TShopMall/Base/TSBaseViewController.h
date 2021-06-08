//
//  TSBaseViewController.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSBaseViewController : UIViewController

/// 基本设置
-(void)setupBasic;
/// 隐藏导航栏
-(void)hiddenNavigationBar;
/// 设置导航栏
-(void)setupNavigationBar;

@end

NS_ASSUME_NONNULL_END
