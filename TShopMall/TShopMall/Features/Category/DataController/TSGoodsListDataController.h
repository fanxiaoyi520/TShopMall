//
//  TSGoodsListDataController.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/13.
//

#import "TSBaseDataController.h"
#import "TSGoodsListSection.h"


@interface TSGoodsListDataController : TSBaseDataController
@property (nonatomic, strong) id model;
+ (instancetype)fetchData:(void(^)(NSArray<TSGoodsListSection *> *, NSError *error))finished;

+ (NSArray<TSGoodsListSection *> *)sectionsWithModels:(id)models isGrid:(BOOL)isGrid;
@end


