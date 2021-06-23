//
//  TSSearchResultDataController.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/21.
//

#import "TSSearchResultDataController.h"

@implementation TSSearchResultDataController
- (instancetype)init{
    if (self == [super init]) {
        self.isGrid = YES;
        self.lists = [NSMutableArray array];
        self.sort = SortWeight;
        self.sort = 1;
        [self defaultConfig];
    }
    return self;
}

- (void)queryGoods:(void(^)(NSError *))finished{
    [self goodsListRequest].animatingView = self.context.view;
    [[self goodsListRequest] startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
//        NSLog(@"%@", request.responseObject);
        if (request.responseModel.isSucceed == YES) {
            [self handleRequestRes:request.responseJSONObject[@"data"]];
        } else {
            self.currentPage -- ;
        }
        finished(request.error);
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        self.currentPage --;
        finished(request.error);
    }];
}

- (void)defaultConfig{
    self.currentPage  = 1;
    self.currentNum = 0;
    self.totalNum = 10000;
    self.result = nil;
    [self.lists removeAllObjects];
}

- (SSGenaralRequest *)goodsListRequest{
    NSString *sortBy = @"";
    switch (self.sortType) {
        case SortWeight:
            sortBy = @"sortWeight";
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

- (void)handleRequestRes:(id)obj{
    TSSearchResult *result = [TSSearchResult yy_modelWithJSON:obj];
    self.totalNum = result.totalNum;
    if (self.result == nil) {
        self.result = result;
    } else {
        NSMutableArray *lists = [NSMutableArray array];
        [lists addObjectsFromArray:self.result.list==nil? @[]:self.result.list];
        [lists addObjectsFromArray:result.list==nil? @[]:result.list];
        self.result.list = [lists yy_modelToJSONObject];
    }
    
    self.isEmptyView = NO;
    TSSearchSection *section = [self defaultSection];
    NSArray<TSSearchRow *> *rows = [self rowsWithDatas:result.list];
    if (rows.count == 0) {
        self.isEmptyView = YES;
        self.lists = [NSMutableArray arrayWithArray:[self configEmptySection]];
        self.currentNum = 0;
        return;
    }
    NSMutableArray *row = [NSMutableArray arrayWithArray:section.rows];
    [row addObjectsFromArray:rows];
    section.rows = row;
    self.lists = [NSMutableArray arrayWithObject:section];
    self.currentNum = self.lists.count==0? 0:[self.lists lastObject].rows.count;
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
    if (self.lists.count != 0) {
        return [self.lists lastObject];
    }
    TSSearchSection *section = [TSSearchSection new];
    section.headerIdentifier = @"UICollectionReusableView";
    section.footerIdentifier = @"UICollectionReusableView";
    section.headerHeight = KRateW(10.0);
    section.footerHeight = 0;
    
    return section;
}

- (NSArray<TSSearchSection *> *)sectionsForUIWithDatas:(NSArray<TSSearchList *> *)lists{
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
    
    TSSearchSection *section = [TSSearchSection new];
    section.headerIdentifier = @"UICollectionReusableView";
    section.footerIdentifier = @"UICollectionReusableView";
    section.headerHeight = KRateW(10.0);
    section.footerHeight = 0;
    section.rows = rows;
    return @[section];
}


- (NSArray<TSSearchSection *> *)configEmptySection{
    TSSearchRow *row = [TSSearchRow new];
    row.cellIdentifier = @"TSSearchResultEmptyCell";
    row.rowSize = CGSizeMake(kScreenWidth, KRateW(320.0));
    
    TSSearchSection *section = [TSSearchSection new];
    section.headerIdentifier = @"UICollectionReusableView";
    section.footerIdentifier = @"UICollectionReusableView";
    section.headerHeight = KRateW(10.0);
    section.footerHeight = 0;
    section.rows = @[row];
    
    return @[section];
}
@end
