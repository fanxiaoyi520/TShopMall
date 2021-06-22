//
//  TSRecomendDataController.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/22.
//

#import "TSRecomendDataController.h"
#import "TSRecomendViewModel.h"

@implementation TSRecomendDataController

- (void)fetchRecomentDatas:(void (^)(void))finished{
    
    [[self request] startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
            NSString *content = request.responseObject[@"data"][@"content"];
            if (content.length != 0) {
                NSDictionary *dic = [content jsonValueDecoded];
                NSDictionary *pageInfo = dic[@"pageInfo"];
                self.pageInfo = [TSRecomendPageInfo yy_modelWithDictionary:pageInfo];
                [self handleRes:dic[@"items"]];
                NSLog(@"%@", dic);
                finished();
            }
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        
    }];
}

- (SSGenaralRequest *)request{
    NSDictionary *params = @{
        @"pageType" : [self pageTypeStr],
        @"uiType" : @"APP",
    };
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kShopContentUrl
                                                               requestMethod:YTKRequestMethodPOST
                                                       requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:NSMutableDictionary.dictionary
                                                                 requestBody:params
                                                              needErrorToast:YES];
    
    return request;
}

- (NSString *)pageTypeStr{
    if (self.pageType == 0) {
        return @"searchResult_page";
    } else if (self.pageType == 1){
        return @"searchResult_page";
    } else if (self.pageType == 2) {
        return @"cart_page";
    }
    return @"";
}

- (void)handleRes:(NSArray *)items{
    NSArray *arr = [NSArray yy_modelArrayWithClass:TSRecomendModel.class json:items];
    for (TSRecomendModel *model in arr) {
        if ([model.type isEqualToString:@"Goods"]) {
            self.recomend = model;
            break;
        }
    }
}


- (NSArray<TSRecomendSection *> *)congifSections{
    NSMutableArray *rows = [NSMutableArray array];
    
   
    for (TSRecomendGoods *goods in self.recomend.goodsList) {
        TSRecomendViewModel *vm = [[TSRecomendViewModel alloc] iniWithGoods:goods];
        TSRecomendRow *row = [TSRecomendRow new];
//        row.size = self.rowSize;
        row.cellHeight = self.rowSize.height;
        row.identify = [self cellIden];
        row.obj = vm;
        
        [rows addObject:row];
    }
    
    TSRecomendSection *section = [TSRecomendSection new];
    section.rows = rows;
    section.interitemSpacing = KRateW(8.0);
    if (self.recomend.listStyle != 2) {
        section.column = 1;
        section.sectionInset = UIEdgeInsetsMake(0, KRateW(16.0), 0, KRateW(16.0));
    } else {
        section.column = 2;
        section.sectionInset = UIEdgeInsetsMake(0, KRateW(16.0), KRateW(16.0), KRateW(16.0));
    }
    
    return @[section];
}

- (CGSize)rowSize{
    if (self.recomend.listStyle == 2) {
        return CGSizeMake((kScreenWidth - KRateW(24.0)) / 2.0, KRateW(282.0));
    }
    return CGSizeMake(kScreenWidth, KRateW(120.0));
}

- (NSString *)cellIden{
    if (self.recomend.listStyle == 2) {//一行两个
        return @"TSRecomendSlimCell";
    }
    return @"TSRecomendCell";
}

@end
