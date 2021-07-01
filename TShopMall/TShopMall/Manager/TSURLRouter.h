//
//  TSURLRouter.h
//  TShopMall
//
//  Created by  on 2021/6/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSURLRouter : NSObject<TSUriHandler>
+ (instancetype)sharedInstance;

@end

NS_ASSUME_NONNULL_END
