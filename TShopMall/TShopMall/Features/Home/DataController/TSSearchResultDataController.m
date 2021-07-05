//
//  TSSearchResultDataController.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/21.
//

#import "TSSearchResultDataController.h"
#import "TSRecomendModel.h"
#import "TSRecomendDataController.h"

@interface TSSearchResultDataController()
@property (nonatomic, assign) NSInteger currentNum;
@property (nonatomic, assign) NSInteger totalNum;//总商品数量
@property (nonatomic, copy) void(^requestFinished)(NSString *message);
@property (nonatomic, strong) NSArray<TSRecomendGoods *> *recomendGoods;
@end

@implementation TSSearchResultDataController
- (instancetype)init{
    if (self == [super init]) {
        self.isGrid = YES;
        self.allGoods = [NSMutableArray array];
        self.lists = [NSMutableArray array];
        self.sort = SortWeight;
        self.sort = 1;
        [self defaultConfig];
    }
    return self;
}

- (void)queryGoods:(void (^)(NSString *))finished{
    self.requestFinished = finished;
    SSGenaralRequest *request = [self goodsListRequest];
    request.animatingView = self.context.view;
    [request startWithCompletionBlockWithSuccess:^(__kindof SSGenaralRequest * _Nonnull request) {
        if (request.responseModel.isSucceed == YES) {
            [self handleRequestRes:request.responseJSONObject[@"data"]];
        } else {
            self.currentPage -- ;
            finished(request.responseModel.responseMsg);
        }
    } failure:^(__kindof SSGenaralRequest * _Nonnull request) {
        self.currentPage --;
        finished(request.responseModel.responseMsg);
    }];
}

- (void)defaultConfig{
    self.currentPage  = 1;
    self.currentNum = 0;
    self.totalNum = 10000;
    [self.lists removeAllObjects];
    [self.allGoods removeAllObjects];
}

- (SSGenaralRequest *)goodsListRequest{
    NSString *sortBy = @"";
    switch (self.sortType) {
        case SortWeight:
            sortBy = @"sortWeight";
            self.sort = 1;
            break;
        case YongJing:
            sortBy = @"commission";
            break;
        case SalsNum:
            sortBy = @"salsnum";
            break;
        case Price:
        default:
            sortBy = @"price";
            break;
    }
    NSDictionary *params = @{
        @"type" : @(2),
        @"pageType" : @"ProductGroup",
        @"uiType" : @"APP",
        @"nowPage" : @(self.currentPage),
        @"pageShow" : @(10),
        @"sortBy" : sortBy,
        @"sortType" : @(self.sort),
        @"keyword" : self.keyword.length==0? @"":self.keyword,
        @"totalNum" : @(self.totalNum)
    };
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kSearchResult
                                                               requestMethod:YTKRequestMethodGET
                                                       requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:NSMutableDictionary.dictionary
                                                                 requestBody:params
                                                              needErrorToast:YES];
    
    return request;
}

//处理数据
- (void)handleRequestRes:(id)obj{
    TSSearchResult *result = [TSSearchResult yy_modelWithJSON:obj];
    [self.allGoods addObjectsFromArray:result.list];
    self.totalNum = result.totalNum;
    self.currentNum = self.allGoods.count;
    if (self.allGoods.count == 0) {//需要配置 Empty 视图, 加载推荐数据
        [self.lists removeAllObjects];
        [self configEmptySection];
        [self fetchRecomendGoods];
    } else {
        NSArray<TSSearchRow *> *rows = [self rowsWithDatas:result.list];//创建新的row
        TSSearchSection *section = [self findoutGoodsSection];
        NSMutableArray *arr = [NSMutableArray arrayWithArray:section.rows];
        [arr addObjectsFromArray:rows];
        section.rows = arr;
        
        if (self.lists.count == 0) {
            [self.lists addObject:section];
        } else {
            [self.lists replaceObjectAtIndex:0 withObject:section];
        }
    }
    self.requestFinished(@"");
}

- (NSArray<TSSearchRow *> *)rowsWithDatas:(NSArray<TSSearchList *> *)lists{
    if (lists.count == 0) {
        return nil;
    }
    NSMutableArray *rows = [NSMutableArray array];
    for (TSSearchList *list in lists) {
        TSSearchResultViewModel *vm = [[TSSearchResultViewModel alloc] initWithList:list];
        
        TSSearchRow *row = [TSSearchRow new];
        row.cellIdentifier = self.isGrid==YES? @"TSSearchResultCell":@"TSSearchResultRailCell";
        row.rowSize = self.isGrid==YES? CGSizeMake((kScreenWidth - KRateW(40.0))/2.0, KRateW(282.0)):CGSizeMake(kScreenWidth-KRateW(32.0), KRateW(120.0));
        row.obj = vm;
        [rows addObject:row];
    }
    return rows;
}

- (TSSearchSection *)defaultSection{
    TSSearchSection *section = [TSSearchSection new];
    section.headerIdentifier = @"UICollectionReusableView";
    section.footerIdentifier = @"UICollectionReusableView";
    section.headerHeight = KRateW(10.0);
    section.footerHeight = 0;
    
    return section;
}

- (void)updateUIStyle:(BOOL)isGrid complete:(void(^)(void))complete{
    self.isGrid = isGrid;
    if (self.allGoods.count == 0) {
        for (TSSearchRow *row in [self findoutRecomendSection].rows) {
            if (self.isGrid == YES) {
                row.cellIdentifier = @"TSSearchResultRecomendCell";
                row.rowSize = CGSizeMake((kScreenWidth - KRateW(40.0))/2.0, KRateW(282.0));
            } else {
                row.cellIdentifier = @"TSSearchResultRecomendWidthCell";
                row.rowSize = CGSizeMake(kScreenWidth-KRateW(32.0), KRateW(120.0));
            }
        }
        return;
    }
    for (TSSearchRow *row in [self findoutGoodsSection].rows) {
        row.cellIdentifier = self.isGrid==YES? @"TSSearchResultCell":@"TSSearchResultRailCell";
        row.rowSize = self.isGrid==YES? CGSizeMake((kScreenWidth - KRateW(40.0))/2.0, KRateW(282.0)):CGSizeMake(kScreenWidth-KRateW(32.0), KRateW(120.0));
    }
    complete();
}

- (void)configEmptySection{
    TSSearchRow *row = [TSSearchRow new];
    row.cellIdentifier = @"TSSearchResultEmptyCell";
    row.rowSize = CGSizeMake(kScreenWidth, KRateW(320.0));
    
    TSSearchSection *section = [TSSearchSection new];
    section.headerIdentifier = @"UICollectionReusableView";
    section.footerIdentifier = @"UICollectionReusableView";
    section.headerHeight = KRateW(10.0);
    section.footerHeight = 0;
    section.rows = @[row];
    
    [self.lists addObject:section];
}

- (TSSearchSection *)findoutGoodsSection{
    for (TSSearchSection *section in self.lists) {
        TSSearchRow *row = [section.rows lastObject];
        if ([row.cellIdentifier isEqualToString:@"TSSearchResultCell"] ||
            [row.cellIdentifier isEqualToString:@"TSSearchResultRailCell"]) {
            return section;
        }
    }
    return [self defaultSection];
}

- (TSSearchSection *)findoutRecomendSection {
    for (TSSearchSection *section in self.lists) {
        TSSearchRow *row = [section.rows lastObject];
        if ([row.cellIdentifier isEqualToString:@"TSSearchResultRecomendCell"] ||
            [row.cellIdentifier isEqualToString:@"TSSearchResultRecomendWidthCell"]) {
            return section;
        }
    }
    return [self defaultSection];
}

- (void)fetchRecomendGoods{
    if (self.recomendGoods.count == 0) {
        [TSRecomendDataController checkCurrentRecomendPage:RecomendSearchResultPage finished:^(TSRecomendModel *recomendInfo, TSRecomendPageInfo *pageInfo) {
            [self configRecomendView:recomendInfo.goodsList];
        }];
    } else {
        [self configRecomendView:self.recomendGoods];
    }
}

- (void)configRecomendView:(NSArray<TSRecomendGoods *> *)recomendGoods{
    
    NSMutableArray *rows = [NSMutableArray array];
    for (TSRecomendGoods *good in recomendGoods) {
        TSSearchRow *row = [TSSearchRow new];
        if (self.isGrid == YES) {
            row.cellIdentifier = @"TSSearchResultRecomendCell";
            row.rowSize = CGSizeMake((kScreenWidth - KRateW(40.0))/2.0, KRateW(282.0));
        } else {
            row.cellIdentifier = @"TSSearchResultRecomendWidthCell";
            row.rowSize = CGSizeMake(kScreenWidth-KRateW(32.0), KRateW(120.0));
        }
        row.obj = good;
        
        [rows addObject:row];
    }
    
    TSSearchSection *section = [self defaultSection];
    section.headerTitle = @"热门推荐";
    section.headerIdentifier = @"TSRecomendHeaderTitleView";
    section.headerTextAlignment = self.isGrid==YES? NSTextAlignmentCenter:NSTextAlignmentLeft;
    section.headerHeight = KRateW(56);
    section.footerHeight = 0.1f;
    section.rows = rows;
    
    [self.lists addObject:section];
    
    self.requestFinished(@"");
}

- (NSInteger)currentNum{
    return self.allGoods.count;
}

- (BOOL)isEmptyView{
    return self.allGoods.count==0? YES:NO;
}

- (BOOL)hasMoreData{
    return self.currentNum == self.totalNum? NO:YES;
}

@end
