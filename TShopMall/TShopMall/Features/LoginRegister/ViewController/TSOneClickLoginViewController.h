//
//  TSOneClickLoginViewController.h
//  TShopMall
//
//  Created by  on 2021/6/25.
//

#import "TSBaseViewController.h"
typedef NS_ENUM(NSUInteger, TSServiceProvider) {
    TSServiceProviderYD,
    TSServiceProviderDX,
    TSServiceProviderLT
};
NS_ASSUME_NONNULL_BEGIN

@interface TSOneClickLoginViewController : TSBaseViewController
@property (nonatomic, copy) void(^ _Nonnull otherLoginBlock)(void);
@property (nonatomic, copy) void(^ _Nonnull loginBlock)(void);
@property (nonatomic, copy) void(^ _Nonnull bindBlock)(void);

@end

NS_ASSUME_NONNULL_END
