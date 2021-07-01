//
//  NSDictionary+Value.m
//  TShopMall
//
//  Created by 林伟 on 2021/6/26.
//

#import "NSDictionary+Value.h"

@implementation NSDictionary (Value)
- (NSString *)stringForkey:(NSString *)key{
    id value = [self valueForKey:key];
    if ([value isKindOfClass:NSNull.class]) {
        return  nil;
    }
    
    if ([value isKindOfClass:NSString.class]) {
        return  value;
    }
    
    if ([value isKindOfClass:NSNumber.class]) {
        return  [value string];
    }
    
    return nil;
   
}
 
- (NSDictionary *)dictionaryForkey:(NSString *)key {
    
    id value = [self valueForKey:key];
    if ([value isKindOfClass:NSDictionary.class]) {
        return  value;
    }
    
    return  nil;
}

-(NSArray *)arrayForkey:(NSString*)key {
    id value = [self valueForKey:key];
    if ([value isKindOfClass:NSArray.class]) {
        return  value;
    }
    
    return  nil;
    
}


-(BOOL)boolForkey:(NSString*)key{
    id value = [self valueForKey:key];
    if ([value isKindOfClass:NSNumber.class]) {
        return  ((NSNumber *)value).boolValue;
    }
    return  [[NSNumber alloc] init].boolValue;
}

-(double)doubleForkey:(NSString*)key {

    id value = [self valueForKey:key];
    if ([value isKindOfClass:NSNumber.class]) {
        return  ((NSNumber *)value).doubleValue;
    }

    if ([value isKindOfClass:NSString.class]) {
        return  ((NSString *)value).doubleValue;
    }

    return  [[NSNumber alloc] init].doubleValue;
}

-(NSInteger)integerForkey:(NSString*)key {
    id value = [self valueForKey:key];
    if ([value isKindOfClass:NSNumber.class]) {
        return  ((NSNumber *)value).integerValue;
    }

    if ([value isKindOfClass:NSString.class]) {
        return  ((NSString *)value).integerValue;
    }

    return  [[NSNumber alloc] init].intValue;

}

-(float)floatForkey:(NSString*)key {
    
    id value = [self valueForKey:key];
    if ([value isKindOfClass:NSNumber.class]) {
        return  ((NSNumber *)value).integerValue;
    }

    if ([value isKindOfClass:NSString.class]) {
        return  ((NSString *)value).integerValue;
    }

    return  [[NSNumber alloc] init].intValue;
    
}

-(long long)longlongForkey:(NSString*)key {
    id value = [self valueForKey:key];
    if ([value isKindOfClass:NSNumber.class]) {
        return  ((NSNumber *)value).longLongValue;
    }

    if ([value isKindOfClass:NSString.class]) {
        return  ((NSString *)value).longLongValue;
    }

    return  [[NSNumber alloc] init].longLongValue;

}

-(long)longForkey:(NSString*)key {
    id value = [self valueForKey:key];
    if ([value isKindOfClass:NSNumber.class]) {
        return  ((NSNumber *)value).longValue;
    }

    if ([value isKindOfClass:NSString.class]) {
        return  ((NSString *)value).longValue;
    }

    return  [[NSNumber alloc] init].longValue;

}
@end
