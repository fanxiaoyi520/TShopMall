//
//  TSLoginController.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/8.
//

#import "TSBaseViewController.h"


@interface TSLoginController : TSBaseViewController
+ (void)loginFinished:(void (^)(BOOL))finished;
@end

