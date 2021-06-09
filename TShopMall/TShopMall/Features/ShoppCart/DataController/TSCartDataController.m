//
//  TSCartDataController.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/9.
//

#import "TSCartDataController.h"

@interface TSCartDataController ()

@end

@implementation TSCartDataController

+ (instancetype)getInfoFinished:(void (^)(TSCartModel *, NSError *))finished{
    TSCartDataController *dataCon = TSCartDataController.new;
    finished(nil, nil);
    return dataCon;
}

@end
