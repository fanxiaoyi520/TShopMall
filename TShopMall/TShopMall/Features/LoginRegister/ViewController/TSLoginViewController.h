//
//  TSLoginViewController.h
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/10.
//

#import "TSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSLoginViewController : TSBaseViewController
@property (nonatomic, copy) void(^ _Nonnull loginBlock)(void);
@property (nonatomic, copy) void(^ _Nonnull bindBlock)(void);

@end

NS_ASSUME_NONNULL_END
