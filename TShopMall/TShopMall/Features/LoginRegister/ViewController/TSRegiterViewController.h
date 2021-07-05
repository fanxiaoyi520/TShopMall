//
//  TSRegiterViewController.h
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/10.
//

#import "TSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSRegiterViewController : TSBaseViewController
@property (nonatomic, copy) void(^ _Nonnull loginBlock)(void);
@end

NS_ASSUME_NONNULL_END
