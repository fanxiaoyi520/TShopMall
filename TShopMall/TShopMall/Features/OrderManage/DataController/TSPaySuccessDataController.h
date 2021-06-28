//
//  TSPaySuccessDataController.h
//  TShopMall
//
//  Created by edy on 2021/6/24.
//

#import "TSBaseDataController.h"
#import "TSPaySuccessSection.h"
#import "TSRecomendModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSPaySuccessDataController : TSBaseDataController

@property (nonatomic, strong) NSMutableArray<TSPaySuccessSection *> *sections;

- (void)configRecomendSection:(NSArray<TSRecomendGoods *> *)goods isGrid:(BOOL)isGrid;

@end

NS_ASSUME_NONNULL_END
