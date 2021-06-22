//
//  TSSearchResultDataController.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/21.
//

#import "TSBaseDataController.h"
#import "TSSearchSection.h"
#import "TSSearchResult.h"
#import "TSSearchResultViewModel.h"

typedef NS_ENUM(NSInteger, TSGoodsListSortType) {
    SortWeight    = 0,//综合
    YongJing            ,//佣金
    SalsNum             ,//销量
    Price                 ,//价格
};

@interface TSSearchResultDataController : TSBaseDataController
@property (nonatomic, assign) NSInteger totalNum;//总商品数量
@property (nonatomic, assign) NSInteger currentNum;
@property (nonatomic, assign) NSInteger currentPage;//当前分页数
@property (nonatomic, assign) TSGoodsListSortType sortType;
@property (nonatomic, copy) NSString *keyword;//关键字
@property (nonatomic, assign) NSInteger sort;//排序   1-降序，2-升序

@property (nonatomic, assign) BOOL isGrid;
@property (nonatomic, strong) TSSearchResult *result;
@property (nonatomic, strong) NSMutableArray<TSSearchSection *> *lists;
- (void)queryGoods:(void(^)(NSError *))finished;
- (NSArray<TSSearchSection *> *)sectionsForUIWithDatas:(NSArray<TSSearchList *> *)lists;

- (void)defaultConfig;
@end

