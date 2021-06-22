//
//  TSRegiterViewController.h
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/10.
//

#import "TSBaseViewController.h"
#import "TSLoginRegisterDataController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSRegiterViewController : TSBaseViewController
@property(nonatomic, strong) TSLoginRegisterDataController *dataController;
@property (nonatomic, copy) void(^ _Nonnull regiterBlock)(void);

@end

NS_ASSUME_NONNULL_END
