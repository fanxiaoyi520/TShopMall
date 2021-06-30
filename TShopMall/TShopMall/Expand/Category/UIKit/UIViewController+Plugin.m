//
//  UIViewController+Plugin.m
//  TCLSmartHome
//
//  Created by LeonDeng on 2019/7/24.
//  Copyright © 2019 TCLIOT. All rights reserved.
//

//#import "BasicViewController.h"
#import "UIViewController+Plugin.h"


@implementation UIViewController (Plugin)

+ (UIViewController *)windowRootViewController {
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    return window.rootViewController;
}

+ (UIViewController *)windowCurrentViewController {
    UIViewController *currentViewController = [self windowRootViewController];
    BOOL runLoopFind = YES;
    while (runLoopFind) {
        if (currentViewController.presentedViewController) {
            currentViewController = currentViewController.presentedViewController;
        } else if ([currentViewController isKindOfClass:[UINavigationController class]]) {
            UINavigationController *navigationController = (UINavigationController *)currentViewController;
            currentViewController = [navigationController.childViewControllers lastObject];
        } else if ([currentViewController isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tabBarController = (UITabBarController *)currentViewController;
            currentViewController = tabBarController.selectedViewController;
        } else {
            NSUInteger childViewControllerCount = currentViewController.childViewControllers.count;
            if (childViewControllerCount > 0) {
                currentViewController = currentViewController.childViewControllers.lastObject;
                return currentViewController;
            } else {
                return currentViewController;
            }
        }
    }
    return currentViewController;
}

+ (UIViewController *)controllerForResponder:(UIResponder *)responder {
    if (responder == nil) {
        return nil;
    } else if ([responder isKindOfClass:[UIViewController class]]) {
        return (UIViewController *)responder;
    } else {
        return [self controllerForResponder:responder.nextResponder];
    }
}

+ (UINavigationController *)navcControllerForResponder:(UIResponder *)responder {
    if (responder == nil) {
        return nil;
    } else if ([responder isKindOfClass:[UINavigationController class]]) {
        return (UINavigationController *)responder;
    } else {
        return [self navcControllerForResponder:responder.nextResponder];
    }
}

+ (UIViewController *)visibleViewController {
    UIViewController *rootViewController = [self windowRootViewController];
    return [self getVisibleViewControllerFrom:rootViewController];
}

+ (UIViewController *)getVisibleViewControllerFrom:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self getVisibleViewControllerFrom:[(UINavigationController *)vc visibleViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self getVisibleViewControllerFrom:[(UITabBarController *)vc selectedViewController]];
    } else {
        if (vc.presentedViewController) {
            return [self getVisibleViewControllerFrom:vc.presentedViewController];
        } else {
            return vc;
        }
    }
}

+ (UINavigationController *)findNavigationController:(UIViewController *)fromVC {
    if (fromVC.navigationController)
        return fromVC.navigationController;

    UIViewController *topController = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (topController.presentedViewController) {
        topController = topController.presentedViewController;
    }

    UINavigationController *navigationController = (UINavigationController *)topController;

    if ([navigationController isKindOfClass:[UINavigationController class]] == NO) {
        if ([navigationController isKindOfClass:[UITabBarController class]]) {
            UITabBarController *tabbarController = (UITabBarController *)navigationController;
            navigationController = tabbarController.selectedViewController;
            if ([navigationController isKindOfClass:[UINavigationController class]] == NO) {
                navigationController = tabbarController.selectedViewController.navigationController;
            }
        } else {
            navigationController = navigationController.navigationController;
        }
    }

    if ([navigationController isKindOfClass:[UINavigationController class]]) {
        return navigationController;
    }

    return nil;
}

@end
