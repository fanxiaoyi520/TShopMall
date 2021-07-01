//
//  NSDictionary+Value.h
//  TShopMall
//
//  Created by 林伟 on 2021/6/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (Value)

-(NSString *)stringForkey:(NSString*)key;

-(NSDictionary *)dictionaryForkey:(NSString*)key;

-(NSArray *)arrayForkey:(NSString*)key;

-(BOOL)boolForkey:(NSString*)key;
//
-(double)doubleForkey:(NSString*)key;

-(NSInteger)integerForkey:(NSString*)key;

-(float)floatForkey:(NSString*)key;

-(long)longForkey:(NSString*)key;

-(long long)longlongForkey:(NSString*)key;
@end

NS_ASSUME_NONNULL_END
