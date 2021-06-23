//
//  TSProductDetailDataController.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/15.
//

#import "TSProductDetailDataController.h"


@interface TSProductDetailDataController()

@property (nonatomic, strong) NSMutableArray <TSGoodDetailSectionModel *> *sections;

@end

@implementation TSProductDetailDataController

#pragma mark - private method
- (NSMutableArray *)detailImageModelsWithJsonString:(NSString *)oSrting {
    NSMutableArray *detailImageModels = [NSMutableArray array];
    if (oSrting.length == 0) {
        return nil;
    }
    NSMutableString *detailString = [NSMutableString stringWithString:oSrting];
    NSString *character = nil;
    // 去掉转义字符
    for (int i = 0; i < detailString.length; i++) {
        character = [detailString substringWithRange:NSMakeRange(i, 1)];
        if ([character isEqualToString:@"\\"]) [detailString deleteCharactersInRange:NSMakeRange(i, 1)];
    }

    NSData *JSONData = [detailString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:&error];
    if (jsonObject != nil && error == nil && [jsonObject isKindOfClass:[NSArray class]]) {

        NSString *regex = @"[a-zA-z]+://[^\\s]*";
        NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        for (NSDictionary *imgDict in jsonObject) {
            if ([imgDict isKindOfClass:[NSDictionary class]]) {
                
                NSLog(@"-----");
                
//                ProductBasicModel *model = [[ProductBasicModel alloc] init];
//                model.cellType = ProductDetailImage;
//                model.imgUrl = imgDict[@"url"];
//                model.imageWidth = [imgDict[@"width"] floatValue];
//                model.imageHeight = [imgDict[@"height"] floatValue];
//                if (model.imgUrl && [urlTest evaluateWithObject:model.imgUrl]) {
//                    [detailImageModels addObject:model];
//                }
            }
        }
    }
    return detailImageModels;
}


-(void)fetchProductDetailWithUuid:(NSString *)uuid
                         complete:(void(^)(BOOL isSucess))complete{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:uuid forKey:@"uuid"];
    
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kGoodDetailUrl
                                                               requestMethod:YTKRequestMethodGET
                                                       requestSerializerType:YTKRequestSerializerTypeJSON
                                                      responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:@{}
                                                                 requestBody:params
                                                              needErrorToast:NO];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        NSLog(@"-----");
        
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            
    }];
}

-(void)fetchProductDetailCartNumber:(void(^)(BOOL isSucess))complete{
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kGoodDetailCartNumberUrl
                                                               requestMethod:YTKRequestMethodPOST
                                                       requestSerializerType:YTKRequestSerializerTypeJSON
                                                      responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:@{}
                                                                 requestBody:@{}
                                                              needErrorToast:NO];
    [request startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
        
        NSDictionary *data = request.responseJSONObject[@"data"];
        NSDictionary *productModel = data[@"productModel"];
        
        NSLog(@"-----");
        
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            NSLog(@"-----");
    }];
}

-(void)fetchProductDetailComplete:(void(^)(BOOL isSucess))complete{
    
    NSMutableArray *sections = [NSMutableArray array];
    
    {
        TSGoodDetailItemBannerModel *item = [[TSGoodDetailItemBannerModel alloc] init];
        item.urls = @[@"http://f0.testpc.tclo2o.cn",@"http://f0.testpc.tclo2o.cn"];
        item.cellHeight = floor(kScreenWidth * 1.04);
        item.identify = @"TSGoodDetailBannerCell";

        TSGoodDetailSectionModel *section = [[TSGoodDetailSectionModel alloc] init];
        section.column = 1;
        section.items = @[item];
        
        [sections addObject:section];
    }
    
    {
        TSGoodDetailItemPriceModel *item = [[TSGoodDetailItemPriceModel alloc] init];
        item.cellHeight = 78;
        item.identify = @"TSGoodDetailPriceCell";

        TSGoodDetailSectionModel *section = [[TSGoodDetailSectionModel alloc] init];
        section.column = 1;
        section.items = @[item];

        [sections addObject:section];
    }

    {
        TSGoodDetailItemPriceModel *item = [[TSGoodDetailItemPriceModel alloc] init];
        item.identify = @"TSGoodDetailIntroduceCell";
        item.title = @"标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标";
        item.content = @"卖点提炼，卖点介绍卖点介绍卖点介绍卖点介绍卖点介绍卖点介绍卖点介绍卖点介绍卖点介绍卖点介绍卖点标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标题标";
        
       CGFloat titleH = [item.title sizeForFont:KRegularFont(16)
                                           size:CGSizeMake(kScreenWidth - 32, 1000)
                                           mode:NSLineBreakByWordWrapping].height;
        
        if (titleH > 45) {
            titleH = 45;
        }
        
       CGFloat contentH = [item.content sizeForFont:KRegularFont(14)
                                               size:CGSizeMake(kScreenWidth - 32, 1000)
                                               mode:NSLineBreakByWordWrapping].height;
        if (contentH > 40) {
            contentH = 40;
        }
        item.cellHeight = 8 + titleH + 4 + contentH + 16;

        TSGoodDetailSectionModel *section = [[TSGoodDetailSectionModel alloc] init];
        section.column = 1;
        section.items = @[item];

        [sections addObject:section];
    }

    {
        TSGoodDetailItemPriceModel *item = [[TSGoodDetailItemPriceModel alloc] init];
        item.cellHeight = 189;
        item.identify = @"TSGoodDetailImageCell";

        TSGoodDetailSectionModel *section = [[TSGoodDetailSectionModel alloc] init];
        section.column = 1;
        section.spacingWithLastSection = 12;
        section.items = @[item];

        [sections addObject:section];
    }

    {
        TSGoodDetailItemPriceModel *item = [[TSGoodDetailItemPriceModel alloc] init];
        item.cellHeight = 151;
        item.identify = @"TSGoodDetailCopyWriterCell";

        TSGoodDetailSectionModel *section = [[TSGoodDetailSectionModel alloc] init];
        section.column = 1;
        section.spacingWithLastSection = 12;
        section.items = @[item];

        [sections addObject:section];
    }

    {
        TSGoodDetailItemPriceModel *item = [[TSGoodDetailItemPriceModel alloc] init];
        item.cellHeight = 227;
        item.identify = @"TSProductDetailPurchaseCell";

        TSGoodDetailSectionModel *section = [[TSGoodDetailSectionModel alloc] init];
        section.column = 1;
        section.spacingWithLastSection = 12;
        section.items = @[item];

        [sections addObject:section];
    }

    {
        TSGoodDetailItemPriceModel *item = [[TSGoodDetailItemPriceModel alloc] init];
        item.cellHeight = 300;
        item.identify = @"TSProductDetailImageCell";

        TSGoodDetailSectionModel *section = [[TSGoodDetailSectionModel alloc] init];
        section.hasHeader = YES;
        section.headerSize = CGSizeMake(0, 46);
        section.headerIdentify = @"TSProductDetailHeaderView";
        section.spacingWithLastSection = 12;
        section.column = 1;
        section.items = @[item];

        [sections addObject:section];
    }
    
    self.sections = sections;
    
    if (complete) {
        complete(YES);
    }
}

@end
