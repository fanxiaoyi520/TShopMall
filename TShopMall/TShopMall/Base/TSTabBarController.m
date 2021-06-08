//
//  TSTabBarController.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/3.
//

#import "TSTabBarController.h"
#import "TSBaseNavigationController.h"
#import "TSHomeViewController.h"
#import "TSCategoryViewController.h"
#import "TSRankViewController.h"
#import "TSCartViewController.h"
#import "TSMineViewController.h"

@interface TSTabBarController ()

@end

@implementation TSTabBarController

-(instancetype)init{
    if (self = [super initWithViewControllers:[self viewControllersForTabBar]
                        tabBarItemsAttributes:[self tabBarItemsAttributesForTabBar]]){
        [self customizeTabBarAppearance];
        self.delegate = self;
        self.tabBar.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark - CYLTabBarControllerDelegate
-(void)tabBarController:(UITabBarController *)tabBarController
       didSelectControl:(UIControl *)control{
}

#pragma mark - Private
- (void)customizeTabBarAppearance {
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = KTextColor;
    normalAttrs[NSFontAttributeName] = KRegularFont(10);
    
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = KMainColor;
    normalAttrs[NSFontAttributeName] = KRegularFont(10);
    
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    
    self.tabBar.layer.shadowColor = [[UIColor grayColor] colorWithAlphaComponent:0.65].CGColor;
    self.tabBar.layer.shadowOpacity = 0.2;
    self.tabBar.layer.shadowOffset = CGSizeMake(0, 3);
    self.tabBar.layer.masksToBounds = NO;
    self.tabBar.clipsToBounds = NO;
}

- (NSArray *)viewControllersForTabBar{
    //首页
    TSHomeViewController *home = [[TSHomeViewController alloc] init];
    TSBaseNavigationController *homeController = [[TSBaseNavigationController alloc] initWithRootViewController:home];
                                                   
    //品类
    TSCategoryViewController *goods = [[TSCategoryViewController alloc] init];
    TSBaseNavigationController *goodsController = [[TSBaseNavigationController alloc] initWithRootViewController:goods];

    //排行
    TSRankViewController *rank = [[TSRankViewController alloc] init];
    TSBaseNavigationController *rankController = [[TSBaseNavigationController alloc] initWithRootViewController:rank];
    
    //购物车
    TSCartViewController *cart = [[TSCartViewController alloc] init];
    TSBaseNavigationController *cartController = [[TSBaseNavigationController alloc] initWithRootViewController:cart];

    //我的
    TSMineViewController *mine = [[TSMineViewController alloc] init];
    TSBaseNavigationController *mineController = [[TSBaseNavigationController alloc] initWithRootViewController:mine];
    
    return @[homeController,goodsController,rankController,cartController,mineController];
}

- (NSArray *)tabBarItemsAttributesForTabBar {
    NSDictionary *home = @{
        CYLTabBarItemTitle : @"首页",
        CYLTabBarItemImage : @"mall_home_normal",
        CYLTabBarItemSelectedImage : @"mall_home_selected",
    };
    NSDictionary *category = @{
        CYLTabBarItemTitle : @"分类",
        CYLTabBarItemImage : @"mall_category_normal",
        CYLTabBarItemSelectedImage : @"mall_category_selected",
    };
    NSDictionary *rank = @{
        CYLTabBarItemTitle : @"排行",
        CYLTabBarItemImage : @"mall_rank_normal",
        CYLTabBarItemSelectedImage : @"mall_rank_selected",
    };
    NSDictionary *cart = @{
        CYLTabBarItemTitle : @"购物车",
        CYLTabBarItemImage : @"mall_cart_normal",
        CYLTabBarItemSelectedImage : @"mall_cart_selected",
    };
    NSDictionary *mine = @{
        CYLTabBarItemTitle : @"我的",
        CYLTabBarItemImage : @"mall_mine_normal",
        CYLTabBarItemSelectedImage : @"mall_mine_selected",
    };
    
    return @[home,category,rank,cart,mine];
}

@end
