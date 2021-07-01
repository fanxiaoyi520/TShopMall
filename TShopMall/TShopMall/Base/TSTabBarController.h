//
//  TSTabBarController.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/3.
//

#import "CYLTabBarController.h"

NS_ASSUME_NONNULL_BEGIN
@protocol TSTabBarControllerProtocol <NSObject>

- (void)refreshData;

@end
@interface TSTabBarController : CYLTabBarController

@end

NS_ASSUME_NONNULL_END
