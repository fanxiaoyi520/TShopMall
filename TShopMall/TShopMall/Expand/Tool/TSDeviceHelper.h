//
//  TSDeviceHelper.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/3.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSDeviceHelper : NSObject

/// 机器是否越狱
+ (BOOL)isJailBreak;

/// 是否运行在模拟器上
+ (BOOL)isSimulator;

@end

NS_ASSUME_NONNULL_END
