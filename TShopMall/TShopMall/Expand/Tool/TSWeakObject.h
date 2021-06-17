//
//  TSWeakObject.h
//  TShopMall
//
//  Created by sway on 2021/6/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSWeakObject : NSObject
+ (instancetype)proxyWithWeakObject:(id)obj;
@end

NS_ASSUME_NONNULL_END
