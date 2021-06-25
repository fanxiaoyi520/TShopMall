//
//  TSBindMobileController.h
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/15.
//

#import "TSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSBindMobileController : TSBaseViewController
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) void(^ bindedBlock)(void);
@end

NS_ASSUME_NONNULL_END
