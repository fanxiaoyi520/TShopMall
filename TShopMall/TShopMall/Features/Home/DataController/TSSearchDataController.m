//
//  TSSearchDataController.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/12.
//

#import "TSSearchDataController.h"

@implementation TSSearchDataController

- (void)fetchData:(void (^)(NSArray<TSSearchSection *> *, NSError *))finished{
    [self.sections removeAllObjects];
    __weak typeof(self) weakSelf = self;
    [[self hotKeyRequest] startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
            NSArray *data = request.responseJSONObject[@"data"];
            NSArray<TSSearchHotKeyModel *> *keywords = [NSArray yy_modelArrayWithClass:TSSearchHotKeyModel.class json:data];
            NSArray *historyKeys = [TSSearchKeyViewModel readHistoryKeys];
            if (keywords.count != 0) {
                [self.sections addObject:[TSSearchDataController configHotSection:keywords]];
            }
            if (historyKeys.count != 0) {
                [self.sections addObject:[TSSearchDataController configHistorySection:historyKeys]];
            }
            weakSelf.hotkeys = keywords;
            if (self.sections.count == 0) {
                [self configEmptySection];
            }
            finished(self.sections, nil);
        }
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            finished(nil, request.error);
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
    
    return request;
}

- (void)handleRes:(id)obj{
    
}

+ (TSSearchSection *)configHotSection:(NSArray<TSSearchHotKeyModel *> *)keywords{
    if (keywords.count == 0) return nil;
    NSMutableArray *rows = [NSMutableArray array];
    for (TSSearchHotKeyModel *keyModel in keywords) {
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
    
    return section;
}

+ (TSSearchSection *)configHistorySection:(NSArray<NSString *> *)keys{
    
    NSMutableArray *rows = [NSMutableArray array];
    for (NSString *str in keys) {
        TSSearchKeyViewModel *keyVM = [TSSearchKeyViewModel new];
        keyVM.keywords = str;
        
        TSSearchRow *row = [TSSearchRow new];
        row.cellIdentifier = @"TSSearchMarkCell";
        row.obj = keyVM;
        [rows addObject:row];
    }
    
    TSSearchSection *section = [TSSearchSection new];
    section.headerIdentifier = @"TSSearchHeaderView";
    section.footerIdentifier = @"UICollectionReusableView";
    section.headerTitle = @"历史搜索";
    section.headerHeight = KRateW(40.0);
    section.footerHeight = KRateW(22.0);
    section.rows = rows;
    
    return section;
}

+ (NSArray<TSSearchSection *> *)updateHistorySections:(NSArray<TSSearchSection *> *)sections{
    BOOL isContainHistory = NO;
    for (TSSearchSection *section in sections) {
        if ([section.headerTitle isEqualToString:@"历史搜索"]) {
            isContainHistory = YES;
            break;
        }
    }
    
    NSArray *keys = [TSSearchKeyViewModel readHistoryKeys];
    TSSearchSection *historySection = [TSSearchDataController configHistorySection:keys];
    NSMutableArray *temSections = [NSMutableArray arrayWithArray:sections];
    if (sections.count == 0) {
        return @[historySection];
    }
    if (isContainHistory == YES) {
        [temSections replaceObjectAtIndex:0 withObject:historySection];
    } else {
        [temSections insertObject:historySection atIndex:0];
    }
    return temSections;
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

- (NSArray<TSSearchSection *> *)configRecomendSection:(UICollectionReusableView *)recomendView{
    TSSearchRow *row = [TSSearchRow new];
    row.cellIdentifier = @"TSSearchRecomendCell";
    row.rowSize = CGSizeMake(kScreenWidth, recomendView.frame.size.height);
    row.obj = recomendView;
    
    TSSearchSection *section = [TSSearchSection new];
    section.headerIdentifier = @"TSSearchHeaderView";
    section.footerIdentifier = @"TSRecomendView";
    section.viewForFooter = recomendView;
    section.headerTitle = @"";
    section.headerHeight = 0;
    section.footerHeight = 0.1f;
    section.rows = @[row];
    
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self.sections];
    [arr addObject:section];
    self.sections = arr;
    
    return self.sections;
}

    
    - (NSMutableArray<TSSearchSection *> *)sections{
        if (_sections) {
            return _sections;
        }
        self.sections = [NSMutableArray array];
        
        return self.sections;
    }
@end
