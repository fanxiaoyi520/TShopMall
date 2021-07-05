//
//  TSOneClickLoginViewController.h
//  TShopMall
//
//  Created by  on 2021/6/25.
//

#import "TSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSOneClickLoginViewController : TSBaseViewController
@property (nonatomic, copy) void(^ _Nonnull otherLoginBlock)(void);
@property (nonatomic, copy) void(^ _Nonnull loginBlock)(BOOL);
@property (nonatomic, copy) void(^ _Nonnull bindBlock)(NSString *token);

@end

NS_ASSUME_NONNULL_END
