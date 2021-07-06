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
@property (nonatomic, assign, readonly) BOOL isEmptyView;
@property (nonatomic, assign, readonly) BOOL hasMoreData;
@property (nonatomic, assign) NSInteger currentPage;//当前分页数
@property (nonatomic, assign) TSGoodsListSortType sortType;
@property (nonatomic, copy) NSString *keyword;//关键字
@property (nonatomic, assign) NSInteger sort;//排序   1-降序，2-升序
@property (nonatomic, assign) BOOL isGrid;

@property (nonatomic, strong) NSMutableArray<TSSearchList *> *allGoods;//所有商品
@property (nonatomic, strong) NSMutableArray<TSSearchSection *> *lists;

- (void)queryGoods:(void(^)(NSString *message))finished;
- (void)updateUIStyle:(BOOL)isGrid complete:(void(^)(void))complete;

- (void)defaultConfig;
@end

