//
//  TSSearchDataController.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/12.
//

#import "TSSearchDataController.h"

@implementation TSSearchDataController

- (void)fetchData:(void (^)(NSArray<TSSearchSection *> *, NSError *))finished{
    __weak typeof(self) weakSelf = self;
    [[self hotKeyRequest] startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
            NSArray *data = request.responseJSONObject[@"data"];
            NSArray<TSSearchHotKeyModel *> *keywords = [NSArray yy_modelArrayWithClass:TSSearchHotKeyModel.class json:data];
            NSMutableArray *sections = [NSMutableArray array];
            NSArray *historyKeys = [TSSearchKeyViewModel readHistoryKeys];
            if (historyKeys.count != 0) {
                [sections addObject:[TSSearchDataController configHistorySection:historyKeys]];
            }
            if (keywords.count != 0) {
                [sections addObject:[TSSearchDataController configHotSection:keywords]];
            }
            weakSelf.hotkeys = keywords;
            weakSelf.sections = sections;
            
            finished(sections, nil);
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


+ (TSSearchSection *)configRecomendSection:(id)obj{
    TSSearchRow *row = [TSSearchRow new];
    row.cellIdentifier = @"TSSearchRecomendCell";
    
    TSSearchSection *section = [TSSearchSection new];
    section.headerIdentifier = @"TSSearchHeaderView";
    section.footerIdentifier = @"UICollectionReusableView";
    section.headerTitle = @"热门推荐";
    section.headerHeight = KRateW(40.0);
    section.footerHeight = (CGFloat)GK_SAFEAREA_BTM;
    section.rows = @[row, row, row];
    
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

@end
