//
//  TSBaseNavigationController.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/3.
//

#import "TSBaseNavigationController.h"

@interface TSBaseNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation TSBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

    if (self.interactivePopGestureRecognizer) {
        self.interactivePopGestureRecognizer.delegate = self;
    }
}

-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (self.viewControllers.count <= 1) {
        return false;
    }
    return true;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    } else {
        viewController.hidesBottomBarWhenPushed = NO;
    }
    [super pushViewController:viewController animated:animated];
}

@end
