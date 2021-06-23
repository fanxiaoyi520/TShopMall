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

-(NSMutableArray <TSGoodDetailSectionModel *> *)fetchProductDetailWithUuid:(NSString *)uuid
                                                                  complete:(void(^)(BOOL isSucess))complete{
    
    NSMutableArray *sections = [NSMutableArray array];
    
    {
        TSGoodDetailItemBannerModel *item = [[TSGoodDetailItemBannerModel alloc] init];
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
        item.title = @"";
        item.content = @"";
        
        //默认45（标题二行的高）
        CGFloat titleH = 45;
        CGFloat contentH = 40;
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
        // 默认给图片的高度为500
        item.cellHeight = 500;
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
        
        NSDictionary *data = request.responseJSONObject[@"data"];
        NSDictionary *productModel = data[@"productModel"];
        NSDictionary *productDescription = productModel[@"productDescription"];
        NSString *descriptionJson = productDescription[@"descriptionJson"];
        
        
        
        
        [self detailImageModelsWithJsonString:descriptionJson];
        NSLog(@"-----");
        
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            
    }];
    
    return sections;
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
        

        
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            NSLog(@"-----");
    }];
}


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

@end
