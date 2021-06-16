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
    
    [[UINavigationBar appearance] setBackIndicatorImage:[UIImage imageNamed:@"navi_back"]];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@"navi_back"]];
    [UINavigationBar appearance].tintColor = KHexColor(@"#030303");
    [[UINavigationBar appearance] setShadowImage:UIImage.new];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
   UIViewController* topVC = self.topViewController;
   return [topVC preferredStatusBarStyle];
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
