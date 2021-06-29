//
//  TSJsonCacheData.h
//  TShopMall
//
//  Created by  on 2021/6/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSJsonCacheData : NSObject
/**
 *  防止备份到iTunes
 *
 *  @param URL 本地Path
 *
 *  @return 是否成功
 */
+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL;

/**
 *  保存数据到本地
 *
 *  @param data 字典或数组
 *  @param key  通过Key保存或读取
 *
 *  @return 是否成功
 */
+ (BOOL)writePlistWithData:(id)data saveKey:(NSString *)key;

/**
 *  清除数据
 *
 *  @param key  通过Key清除
 *
 *  @return 是否成功
 */
+ (BOOL)clearWithKey:(NSString *)key;

/**
 *  通过Key读取本地缓存
 *
 *  @param key Key
 *
 *  @return 字典或数组
 */
+ (id)readPlistWithKey:(NSString *)key;
@end

NS_ASSUME_NONNULL_END
