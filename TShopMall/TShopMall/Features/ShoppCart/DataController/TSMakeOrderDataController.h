//
//  TSMakeOrderDataController.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/16.
//

#import <Foundation/Foundation.h>
#import "TSMakeOrderSection.h"

@interface TSMakeOrderDataController : NSObject
@property (nonatomic, strong) NSMutableArray<TSMakeOrderSection *> *sections;

- (void)initData:(void(^)(void))finished;
@end

