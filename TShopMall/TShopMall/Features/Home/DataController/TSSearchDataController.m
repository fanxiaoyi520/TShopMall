//
//  TSSearchDataController.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/12.
//

#import "TSSearchDataController.h"

@interface TSSearchDataController()

@end

@implementation TSSearchDataController

+ (void)queryKeyWords:(void(^)(NSArray *))complete{
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kQueryKeyWord
                                                               requestMethod:YTKRequestMethodGET
                                                       requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:NSMutableDictionary.dictionary
                                                                 requestBody:@{@"type":@"1"}
                                                              needErrorToast:YES];
    [request startWithCompletionBlockWithSuccess:^(__kindof SSGenaralRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
            
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

- (void)fetchData:(void (^)(void))finished{
    [self.sections removeAllObjects];
    __weak typeof(self) weakSelf = self;
    [[self hotKeyRequest] startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
            [weakSelf handleRequest:request];
            finished();
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        finished();
    }];
}

- (SSGenaralRequest *)hotKeyRequest{
    NSDictionary *params = @{
        @"type" : @(2),
        @"pageType" : @"searchResult_page",
        @"uiType" : @"APP"
    };
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kSearchHotKey
                                                               requestMethod:YTKRequestMethodGET
                                                       requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:NSMutableDictionary.dictionary
                                                                 requestBody:params
                                                              needErrorToast:YES];
    request.animatingView = self.context.view;
    
    return request;
}

- (void)handleRequest:(SSGenaralRequest *)request{
    NSArray *data = request.responseJSONObject[@"data"];
    self.hotkeys = [NSArray yy_modelArrayWithClass:TSSearchHotKeyModel.class json:data];
    if (self.hotkeys.count > 10) {
        self.hotkeys = [self.hotkeys subarrayWithRange:NSMakeRange(0, 10)];
    }
    [self configHotKeySection];
    [self configHistorySection];
    if (self.sections.count == 0) {
        [self configEmptySection];
    }
}

- (void)configHotKeySection{
    if (self.hotkeys.count == 0) return;
    NSMutableArray *rows = [NSMutableArray array];
    for (TSSearchHotKeyModel *keyModel in self.hotkeys) {
        TSSearchKeyViewModel *keyVM = [TSSearchKeyViewModel new];
        keyVM.keywords = keyModel.searchWord;
        
        TSSearchRow *row = [TSSearchRow new];
        row.cellIdentifier = @"TSSearchMarkCell";
        row.obj = keyVM;
        [rows addObject:row];
    }
    
    TSSearchSection *section = [TSSearchSection new];
    section.headerIdentifier = @"TSSearchHeaderView";
    section.footerIdentifier = @"UICollectionReusableView";
    section.headerTitle = @"热门搜索";
    section.headerHeight = KRateW(40.0);
    section.footerHeight = KRateW(22.0);
    section.rows = rows;
    
    [self.sections addObject:section];
}

- (void)configHistorySection{
    NSArray *historyKeys = [TSSearchKeyViewModel readHistoryKeys];
    if (historyKeys.count == 0) {
        return;
    }
    TSSearchSection *historySection ;
    for (TSSearchSection *section in self.sections) {
        if ([section.headerTitle isEqualToString:@"历史搜索"]) {
            historySection = section;
            break;
        }
    }
    
    NSMutableArray *rows = [NSMutableArray array];
    for (NSString *str in historyKeys) {
        TSSearchKeyViewModel *keyVM = [TSSearchKeyViewModel new];
        keyVM.keywords = str;
        
        TSSearchRow *row = [TSSearchRow new];
        row.cellIdentifier = @"TSSearchMarkCell";
        row.obj = keyVM;
        [rows addObject:row];
    }
    
    if (historySection == nil) {
        historySection = [TSSearchSection new];
        historySection.headerIdentifier = @"TSSearchHeaderView";
        historySection.footerIdentifier = @"UICollectionReusableView";
        historySection.headerTitle = @"历史搜索";
        historySection.headerHeight = KRateW(40.0);
        historySection.footerHeight = KRateW(22.0);
        
        historySection.rows = rows;
        [self.sections addObject:historySection];
    } else {
        historySection.rows = rows;
    }

    [self removeEmptySection];
}

- (void)configEmptySection{
    TSSearchRow *row = [TSSearchRow new];
    row.cellIdentifier = @"TSSearchEmptyCell";
    //    row.rowSize = CGSizeMake(kScreenWidth, KRateW(320.0));
    
    TSSearchSection *section = [TSSearchSection new];
    section.headerIdentifier = @"TSSearchHeaderView";
    section.footerIdentifier = @"TSSearchHeaderView";
    section.headerHeight = KRateW(10.0);
    section.footerHeight = 0;
    section.rows = @[row];
    
    [self.sections addObject:section];
}

- (void)removeEmptySection{
    BOOL contentIsEmpty = YES;
    for (TSSearchSection *section in self.sections) {
        if ([section.headerTitle isEqualToString:@"热门搜索"] ||
            [section.headerTitle isEqualToString:@"历史搜索"]) {
            contentIsEmpty = NO;
            break;
        }
    }
    if (contentIsEmpty == NO) {
        for (TSSearchSection *section in self.sections) {
            TSSearchRow *row = [section.rows lastObject];
            if ([row.cellIdentifier isEqualToString:@"TSSearchEmptyCell"]) {
                [self.sections removeObject:section];
                break;
            }
        }
    }
}


- (void)configRecomendSection:(NSArray<TSRecomendGoods *> *)goods isGrid:(BOOL)isGrid{
    
    NSMutableArray *rows = [NSMutableArray array];
    for (TSRecomendGoods *good in goods) {
        TSSearchRow *row = [TSSearchRow new];
        row.cellIdentifier = isGrid==NO? @"TSSearchRecomendCell":@"TSSearchRecomendSlimCell";
        row.obj = good;
        
        [rows addObject:row];
    }
    
    TSSearchSection *section = [TSSearchSection new];
    section.headerIdentifier = @"TSSearchHeaderView";
    section.footerIdentifier = @"TSSearchHeaderView";
    section.headerTitle = @"热门推荐";
    section.headerHeight = KRateW(56);
    section.footerHeight = 0.1f;
    section.rows = rows;
    
    [self.sections addObject:section];
}


- (NSMutableArray<TSSearchSection *> *)sections{
    if (_sections) {
        return _sections;
    }
    self.sections = [NSMutableArray array];
    
    return self.sections;
}
@end
