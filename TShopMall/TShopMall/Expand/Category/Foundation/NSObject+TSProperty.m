//
//  NSObject+TSProperty.m
//  TShopMall
//
//  Created by sway on 2021/6/23.
//

#import "NSObject+TSProperty.h"
#import <objc/runtime.h>

@implementation NSObject (TSProperty)
- (NSArray<NSString *> *)ts_validProperties {
    
    unsigned int outCount,index;
    objc_property_t* properties_t = class_copyPropertyList([self class], &outCount);
    NSMutableArray<NSString *> *properties = @[].mutableCopy;
    for(index = 0 ; index < outCount ; index ++){
        objc_property_t t_property = properties_t[index];
        NSString *propertyName = [NSString stringWithUTF8String:property_getName(t_property)];
        if (![propertyName isEqualToString:@"description"] &&
            ![propertyName isEqualToString:@"hash"] &&
            ![propertyName isEqualToString:@"superclass"] &&
            ![propertyName isEqualToString:@"debugDescription"]) {
            [properties addObject:propertyName];
        }
    }
    if (properties_t) {
        free(properties_t);
    }
    return properties;
}

- (void)ts_setValue:(nullable id)value forKey:(NSString *)key {
    objc_setAssociatedObject(self, (__bridge const void * _Nonnull)(key), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
 
- (nullable id)ts_valueForKey:(NSString *)key {
    return objc_getAssociatedObject(self, (__bridge const void * _Nonnull)(key));
}
@end
