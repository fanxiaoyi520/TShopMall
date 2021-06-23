//
//  TSBaseViewController.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/3.
//

#import <GKNavigationBarViewController/GKNavigationBarViewController.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSBaseViewController : GKNavigationBarViewController

/// 基本设置
-(void)setupBasic;
/// 隐藏导航栏
-(void)hiddenNavigationBar;
/// 设置导航栏
-(void)setupNavigationBar;
/// 添加子控件
-(void)fillCustomView;

- (void)loginStateDidChanged:(NSNotification *)noti;
@end

NS_ASSUME_NONNULL_END
