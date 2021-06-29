//
//  TSJsonCacheData.m
//  TShopMall
//
//  Created by  on 2021/6/29.
//

#import "TSJsonCacheData.h"

//获取Cache目录路径
#define CACHEPATH       [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0]

@implementation TSJsonCacheData

//防止备份到iTunes和iCloud(上架审核必备)
+ (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    if ([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]) {
        NSError *error = nil;
        BOOL success = [URL setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:&error];
        if(!success){
            NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
        }
        return success;
    }
    return YES;
}

#pragma mark 缓存数据
+ (BOOL)writePlistWithData:(id)data saveKey:(NSString *)key
{
    BOOL success;
    NSString *path = [[CACHEPATH stringByAppendingPathComponent:key] stringByAppendingString:@"CacheData.plist"];//获取路径
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //判断是否存在，不存在则创建路径
    if (![fileManager fileExistsAtPath:path]) {
        [fileManager createFileAtPath:path contents:nil attributes:nil];
    }
    
    NSData *cacheData = [NSKeyedArchiver archivedDataWithRootObject:data];
    success = [cacheData writeToFile:path atomically:YES];
    [self addSkipBackupAttributeToItemAtURL:[NSURL fileURLWithPath:path]];
    NSLog(@"Key: %@ , 数据缓存 %@", key, success ? @"成功" : @"失败");
    return success;
}

#pragma mark 清除缓存
+ (BOOL)clearWithKey:(NSString *)key
{
    NSString *path = [[CACHEPATH stringByAppendingPathComponent:key] stringByAppendingString:@"CacheData.plist"];//获取路径
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //判断是否存在
    if (![fileManager fileExistsAtPath:path]) {
        return NO;
    }
    else {
        return [fileManager removeItemAtPath:path error:nil];
    }
}

#pragma mark 读取缓存
+ (id)readPlistWithKey:(NSString *)key
{
    NSString *path = [[CACHEPATH stringByAppendingPathComponent:key] stringByAppendingString:@"CacheData.plist"];//获取路径
    id object = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    return object;
}

@end
