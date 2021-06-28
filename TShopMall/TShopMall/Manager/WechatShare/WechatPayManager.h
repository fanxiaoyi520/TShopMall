//
//  WechatPayManager.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/28.
//

#import <Foundation/Foundation.h>


@interface WechatPayManager : NSObject

+ (instancetype)defaultWechatPayManager;

+ (void)payWithParamas:(NSDictionary *)params paySuccess:(void(^)(BOOL))paySuccess;

@end

