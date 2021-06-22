//
//  TSAreaSelectedController.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/18.
//

#import <UIKit/UIKit.h>

@class TSAreaModel;

@interface TSAreaSelectedController : UIViewController

+ (void)showAreaSelected:(void(^)(TSAreaModel *provice, TSAreaModel *city, TSAreaModel *eare, TSAreaModel *street, NSString *location))selected OnController:(UIViewController *)controller;

@end

