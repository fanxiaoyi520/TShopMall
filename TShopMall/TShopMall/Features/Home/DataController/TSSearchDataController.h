//
//  TSSearchDataController.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/12.
//

#import "TSBaseDataController.h"
#import "TSSearchModel.h"
#import "TSSearchSection.h"

@interface TSSearchDataController : TSBaseDataController
+ (void)fetchData:(void(^)(NSArray<TSSearchSection *> *sections,  NSError *error))finished;
@end


