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
    NSString *path = [[NSBundle mainBundle] pathForResource:@"cart" ofType:@"json"];
    NSError *error;
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&error];
    TSCartModel *cartModel = [TSCartModel  yy_modelWithJSON:dic];
    
    TSCartDataController *dataCon = TSCartDataController.new;
    finished(cartModel, nil);
    return dataCon;
}

@end
