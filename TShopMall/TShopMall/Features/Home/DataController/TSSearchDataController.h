//
//  TSSearchDataController.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/12.
//

#import "TSBaseDataController.h"
#import "TSSearchSection.h"
#import "TSSearchHotKeyModel.h"
#import "TSSearchKeyViewModel.h"
#import "TSRecomendModel.h"

@interface TSSearchDataController : TSBaseDataController
@property (nonatomic, strong) NSArray<TSSearchHotKeyModel *> *hotkeys;
@property (nonatomic, strong) NSMutableArray<TSSearchSection *> *sections;

- (void)fetchData:(void(^)(NSArray<TSSearchSection *> *sections,  NSError *error))finished;

+ (NSArray<TSSearchSection *> *)updateHistorySections:(NSArray<TSSearchSection *> *)sections;

- (void)configRecomendSection:(NSArray<TSRecomendGoods *> *)goods isGrid:(BOOL)isGrid;
@end


