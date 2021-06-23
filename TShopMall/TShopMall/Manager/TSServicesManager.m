//
//  TSServicesManager.m
//  TShopMall
//
//  Created by sway on 2021/6/23.
//

#import "TSServicesManager.h"

@implementation TSServicesManager
+ (instancetype)sharedInstance {
    static dispatch_once_t pred;
    static id instance = nil;
    dispatch_once(&pred, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

@end
