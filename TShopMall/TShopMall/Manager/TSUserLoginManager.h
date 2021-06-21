//
//  TSUserLoginManager.h
//  TShopMall
//
//  Created by sway on 2021/6/21.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSUserLoginManager : NSObject
+ (instancetype)shareInstance;

-(void)startLogin:(void(^)(BOOL success))callBack;

@end

NS_ASSUME_NONNULL_END
