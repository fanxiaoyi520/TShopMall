//
//  TSLocationManager.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/19.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface TSLocationManager : NSObject
+ (instancetype)defaultManager;
//+ (void)startLocation:(void(^)(TSLocation *location, NSError *error))finished;
@property (nonatomic, copy) void(^startLocation)(void(^)(CLPlacemark *location, NSError *error));
@end
