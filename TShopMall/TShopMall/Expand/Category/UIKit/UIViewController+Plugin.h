//
//  UIViewController+Plugin.h
//  TCLSmartHome
//
//  Created by LeonDeng on 2019/7/24.
//  Copyright © 2019 TCLIOT. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface UIViewController (Plugin)


+ (UIViewController *)windowRootViewController;

+ (UIViewController *)windowCurrentViewController;

+ (UIViewController *)controllerForResponder:(UIResponder *)responder;

+ (UINavigationController *)navcControllerForResponder:(UIResponder *)responder;

+ (UIViewController *)visibleViewController;

+ (UINavigationController *)findNavigationController:(UIViewController *)fromVC;

@end

NS_ASSUME_NONNULL_END
