//
//  TSWKAppManager.h
//  TSale
//
//  Created by 陈洁 on 2020/12/28.
//  Copyright © 2020 TCL. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSWKAppManager : NSObject

+ (__kindof UINavigationController *)currentNavigationController;
+ (__kindof UIViewController *)currentController:(UIView *)currentView;

@end

NS_ASSUME_NONNULL_END
