//
//  NSObject+TSProperty.h
//  TShopMall
//
//  Created by sway on 2021/6/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (TSProperty)
- (NSArray<NSString *> *)ts_validProperties;

- (void)ts_setValue:(nullable id)value forKey:(NSString *)key;

- (nullable id)ts_valueForKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
