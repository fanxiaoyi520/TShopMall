//
//  TSProductDetailDataController.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/15.
//

#import "TSProductDetailDataController.h"
#import "NSString+Plugin.h"
#import "TSMaterialImageCell.h"

@interface TSProductDetailDataController()<YTKChainRequestDelegate>

@property(nonatomic, copy) void (^customBuyBlock) (BOOL isScuess);

@property (nonatomic, strong) NSMutableArray <TSGoodDetailSectionModel *> *sections;

@end

@implementation TSProductDetailDataController

-(NSMutableArray <TSGoodDetailSectionModel *> *)fetchProductDetailWithUuid:(NSString *)uuid
                                                                  complete:(void(^)(BOOL isSucess))complete{
    
    NSMutableArray *sections = [NSMutableArray array];
    
    {   //banner 0
        TSGoodDetailItemBannerModel *item = [[TSGoodDetailItemBannerModel alloc] init];
        item.cellHeight = floor(kScreenWidth * 1.04);
        item.identify = @"TSGoodDetailBannerCell";

        TSGoodDetailSectionModel *section = [[TSGoodDetailSectionModel alloc] init];
        section.column = 1;
        section.items = @[item];
        [sections addObject:section];
    }
    
    {   //价格 1
        TSGoodDetailItemPriceModel *item = [[TSGoodDetailItemPriceModel alloc] init];
        item.cellHeight = 78;
        item.identify = @"TSGoodDetailPriceCell";

        TSGoodDetailSectionModel *section = [[TSGoodDetailSectionModel alloc] init];
        section.column = 1;
        section.items = @[item];
        [sections addObject:section];
    }

    {   //介绍 2
        TSGoodDetailItemHotModel *item = [[TSGoodDetailItemHotModel alloc] init];
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

    {   //下载图片 3
        TSGoodDetailItemDownloadImageModel *item = [[TSGoodDetailItemDownloadImageModel alloc] init];
        item.cellHeight = 189;
        item.identify = @"TSGoodDetailImageCell";

        TSGoodDetailSectionModel *section = [[TSGoodDetailSectionModel alloc] init];
        section.column = 1;
        section.spacingWithLastSection = 12;
        section.items = @[item];
        [sections addObject:section];
    }

    {   //复制文案 4
        TSGoodDetailItemCopyModel *item = [[TSGoodDetailItemCopyModel alloc] init];
        item.cellHeight = 151;
        item.identify = @"TSGoodDetailCopyWriterCell";

        TSGoodDetailSectionModel *section = [[TSGoodDetailSectionModel alloc] init];
        section.column = 1;
        section.spacingWithLastSection = 12;
        section.items = @[item];
        [sections addObject:section];
    }

    {   //所选商品规格参数等 5
        TSGoodDetailItemPurchaseModel *item = [[TSGoodDetailItemPurchaseModel alloc] init];
        item.cellHeight = 172;
        item.identify = @"TSProductDetailPurchaseCell";

        TSGoodDetailSectionModel *section = [[TSGoodDetailSectionModel alloc] init];
        section.column = 1;
        section.spacingWithLastSection = 12;
        section.items = @[item];
        [sections addObject:section];
    }

    {   //图文 6
        TSGoodDetailItemPriceModel *item = [[TSGoodDetailItemPriceModel alloc] init];
        item.identify = @"TSProductDetailImageCell";

        TSGoodDetailSectionModel *section = [[TSGoodDetailSectionModel alloc] init];
        section.hasHeader = YES;
        section.headerSize = CGSizeMake(0, 46);
        section.headerIdentify = @"TSProductDetailHeaderView";
        section.spacingWithLastSection = 12;
        section.column = 1;
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
        
        NSMutableArray *urls = [NSMutableArray array];
        
        NSDictionary *data = request.responseJSONObject[@"data"];
        NSDictionary *productModel = data[@"productModel"];
        NSDictionary *productSku = data[@"productSku"];
        self.skuNo = productSku[@"skuNo"];
        self.parentSkuNo = productSku[@"parentSkuNo"];
        self.productUuid = productSku[@"productUuid"];
        

        {   //banner
            NSDictionary *productImage = productModel[@"productImage"];
            NSArray *productMultiImage = productModel[@"productMultiImage"];
            
            [urls addObject:productImage[@"bigImageUrl"]];
            
            for (NSDictionary *dic in productMultiImage) {
                NSString *basicImageUrl = dic[@"basicImageUrl"];
                [urls addObject:basicImageUrl];
            }
            TSGoodDetailSectionModel *section = self.sections[0];
            TSGoodDetailItemBannerModel *item = (TSGoodDetailItemBannerModel *)[section.items firstObject];
            item.urls = urls;
        }
        
        {   //价格
            NSDictionary *font = data[@"front"];
            NSDictionary *priceAndPromotion = font[@"priceAndPromotion"];
            NSDictionary *promotionInteactiveModel = priceAndPromotion[@"promotionInteactiveModel"];
            NSArray *productSku = productModel[@"productSku"];
            NSDictionary *productSkuDic = [productSku firstObject];
            
            self.attrId = font[@"skuNo"];
            TSGoodDetailSectionModel *section = self.sections[1];
            TSGoodDetailItemPriceModel *item = (TSGoodDetailItemPriceModel *)[section.items firstObject];
            item.marketPrice = promotionInteactiveModel[@"marketPrice"];
            item.staffPrice = promotionInteactiveModel[@"staffPrice"];
            item.earnMost = productSkuDic[@"earnMost"];
        }
        
        {   //卖点
            
            NSDictionary *productMain = productModel[@"productMain"];
            NSString *productName = productMain[@"productName"];
            NSString *adviceNote = productMain[@"adviceNote"];
            
            CGFloat titleH = [productName sizeForFont:KRegularFont(16)
                                                 size:CGSizeMake(kScreenWidth - 32, 1000)
                                                 mode:NSLineBreakByWordWrapping].height;

           CGFloat contentH = [adviceNote sizeForFont:KRegularFont(14)
                                                 size:CGSizeMake(kScreenWidth - 32, 1000)
                                                 mode:NSLineBreakByWordWrapping].height;
            if (titleH > 45) {
                titleH = 45;
            }
            
            if (contentH > 40) {
                contentH = 40;
            }
            
            TSGoodDetailSectionModel *section = self.sections[2];
            TSGoodDetailItemHotModel *item = (TSGoodDetailItemHotModel *)[section.items firstObject];
            item.title = productName;
            item.content = adviceNote;
            item.cellHeight = 8 + titleH + 4 + contentH + 16;

        }
        
        {   //素材下载
            TSGoodDetailSectionModel *section = self.sections[3];
            TSGoodDetailItemDownloadImageModel *item = (TSGoodDetailItemDownloadImageModel *)[section.items firstObject];
            
            NSMutableArray *models = [NSMutableArray array];
            for (NSString *url in urls) {
                
                TSMaterialImageModel *model = [[TSMaterialImageModel alloc] init];
                model.url = url;
                model.selected = NO;
                
                [models addObject:model];
            }
            
            item.materialModels = models;
        }
        
        {   //商品文案
            
            NSDictionary *productInfo = productModel[@"productInfo"];
            
            TSGoodDetailSectionModel *section = self.sections[4];
            TSGoodDetailItemCopyModel *item = (TSGoodDetailItemCopyModel *)[section.items firstObject];
            item.writeStr = productInfo[@"productShareContent"];
        }
        
        {   //已选等
            NSDictionary *productImage = productModel[@"productImage"];
            NSDictionary *front = data[@"front"];
            NSDictionary *priceAndPromotion = front[@"priceAndPromotion"];
            NSDictionary *promotionInteactiveModel = priceAndPromotion[@"promotionInteactiveModel"];
            NSArray *productSku = productModel[@"productSku"];
            NSDictionary *productSkuDic = [productSku firstObject];
            
            NSArray *selectNameArr = front[@"selectName"];
            NSString *selected = [selectNameArr componentsJoinedByString:@","];

            TSGoodDetailSectionModel *section = self.sections[5];
            TSGoodDetailItemPurchaseModel *item = (TSGoodDetailItemPurchaseModel *)[section.items firstObject];
            item.selectedStr = selected;
            item.localaddress = @"广东省 深圳市 南山区 西丽街道";
            item.provinceId = @"05";
            item.cityId = @"154";
            item.areaUuid = @"15845";
            item.regionUuid = @"1385";
            item.iconUrl = productImage[@"bigImageUrl"];
            item.price = promotionInteactiveModel[@"marketPrice"];
        }
        
        {   //详情
            TSGoodDetailSectionModel *section = [self.sections lastObject];
            NSDictionary *productDescription = productModel[@"productDescription"];
            NSString *descriptionJson = productDescription[@"descriptionJson"];
            NSMutableArray *items = [self detailImageModelsWithJsonString:descriptionJson];
            section.items = items;
        }
        
        if (complete) {
            complete(YES);
        }
        
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            
    }];
    
    return sections;
}

///加购
-(void)fetchProductDetailAddProductToCart:(NSString *)productUuid
                                   buyNum:(NSString *)buyNum
                                   attrId:(NSString *)attrId
                                 complete:(void(^)(BOOL isSucess))complete{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:productUuid forKey:@"productUuid"];
    [params setValue:buyNum forKey:@"buyNum"];
    [params setValue:attrId forKey:@"attrId"];
    
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kGoodDetailAddProductToCartUrl
                                                               requestMethod:YTKRequestMethodGET
                                                       requestSerializerType:YTKRequestSerializerTypeJSON
                                                      responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:@{}
                                                                 requestBody:params
                                                              needErrorToast:NO];
    request.animatingView = self.context.view;
    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        
        if (request.responseModel.isSucceed) {
            [Popover popToastOnWindowWithText:@"加入购物车成功"];
        }
        
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            NSLog(@"-----");
    }];
}

///购物车角标
-(void)fetchProductDetailCartNumber:(void(^)(BOOL isSucess))complete{
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kGoodDetailCartNumberUrl
                                                               requestMethod:YTKRequestMethodPOST
                                                       requestSerializerType:YTKRequestSerializerTypeJSON
                                                      responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:@{}
                                                                 requestBody:@{}
                                                              needErrorToast:NO];
    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
            self.cartNumber = [NSString stringWithFormat:@"%@",request.responseModel.originalData[@"data"]];
            complete(YES);
        }
        
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            complete(NO);
    }];
}
///判断库存
-(void)fetchProductDetailHasProduct:(NSString *)skuNo
                           areaUuid:(NSString *)areaUuid
                        parentSkuNo:(NSString *)parentSkuNo
                             buyNum:(NSString *)buyNum
                             region:(NSString *)region
                           complete:(void(^)(BOOL isSucess))complete{
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:skuNo forKey:@"skuNo"];
    [params setValue:areaUuid forKey:@"areaUuid"];
    [params setValue:parentSkuNo forKey:@"parentSkuNo"];
    [params setValue:buyNum forKey:@"buyNum"];
    [params setValue:region forKey:@"region"];
    
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kGoodDetailHasProductUrl
                                                               requestMethod:YTKRequestMethodGET
                                                       requestSerializerType:YTKRequestSerializerTypeJSON
                                                      responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:@{}
                                                                 requestBody:params
                                                              needErrorToast:NO];
    request.animatingView = self.context.view;
    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        
        if (request.responseModel.isSucceed) {

            TSGoodDetailSectionModel *section = self.sections[5];
            TSGoodDetailItemPurchaseModel *item = (TSGoodDetailItemPurchaseModel *)[section.items firstObject];
            NSDictionary *data = request.responseJSONObject[@"data"];
            
            item.canBuy = [data[@"canBuy"] boolValue];
            item.hasProduct = [data[@"hasProduct"] boolValue];
            item.totalNum = [data[@"totalNum"] integerValue];
            
            if (![data[@"limitBuyNum"] isKindOfClass:[NSNull class]]) {
                item.limitBuyNum = [data[@"limitBuyNum"] integerValue];
            }
            
            if (complete) {
                complete(YES);
            }
        }
        
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            
    }];
    
}

-(void)fetchProductDetailCustomBuy:(NSString *)suitUuid
                          complete:(void(^)(BOOL isSucess))complete{
    
    NSMutableDictionary *fast = [NSMutableDictionary dictionary];
    [fast setValue:self.productUuid forKey:@"productUuid"];
    [fast setValue:self.skuNo forKey:@"attrId"];
    [fast setValue:@"true" forKey:@"noCart"];
    
    SSGenaralRequest *fastBuy = [[SSGenaralRequest alloc] initWithRequestUrl:kGoodDetailFastBuyUrl
                                                               requestMethod:YTKRequestMethodGET
                                                       requestSerializerType:YTKRequestSerializerTypeJSON
                                                      responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:@{}
                                                                 requestBody:fast
                                                              needErrorToast:YES];
    [fastBuy startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
            complete(YES);
        }
        
        NSLog(@"---");
        
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            
    }];
    
    
//    self.customBuyBlock = complete;
//
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    [params setValue:@"allRecords" forKey:@"productIdAndAttrId"];
//    [params setValue:@"false" forKey:@"chooseState"];
//
//    SSGenaralRequest *update = [[SSGenaralRequest alloc] initWithRequestUrl:kGoodDetailChangeChooseUrl
//                                                              requestMethod:YTKRequestMethodPOST
//                                                      requestSerializerType:YTKRequestSerializerTypeHTTP
//                                                     responseSerializerType:YTKResponseSerializerTypeJSON
//                                                              requestHeader:@{}
//                                                                requestBody:params
//                                                             needErrorToast:YES];
//
//    NSMutableDictionary *fast = [NSMutableDictionary dictionary];
//    [fast setValue:self.productUuid forKey:@"productUuid"];
//    [fast setValue:self.skuNo forKey:@"attrId"];
//    [fast setValue:@"true" forKey:@"noCart"];
//
//    SSGenaralRequest *fastBuy = [[SSGenaralRequest alloc] initWithRequestUrl:kGoodDetailFastBuyUrl
//                                                               requestMethod:YTKRequestMethodGET
//                                                       requestSerializerType:YTKRequestSerializerTypeJSON
//                                                      responseSerializerType:YTKResponseSerializerTypeJSON
//                                                               requestHeader:@{}
//                                                                 requestBody:fast
//                                                              needErrorToast:YES];
//
//
//    YTKChainRequest *chainReq = [[YTKChainRequest alloc] init];
//    [chainReq addRequest:update callback:^(YTKChainRequest * _Nonnull chainRequest, YTKBaseRequest * _Nonnull baseRequest) {
//
//        SSGenaralRequest *update = (SSGenaralRequest *)baseRequest;
//
//        [chainRequest addRequest:fastBuy callback:nil];
//    }];
//
//    chainReq.delegate = self;
//    [chainReq start];
    
}

#pragma mark - YTKChainRequestDelegate
- (void)chainRequestFinished:(YTKChainRequest *)chainRequest{
    NSArray *chain = chainRequest.requestArray;
    SSGenaralRequest *update = [chain firstObject];
    SSGenaralRequest *fast = [chain lastObject];
    
    self.customBuyBlock(YES);
}

- (void)chainRequestFailed:(YTKChainRequest *)chainRequest failedBaseRequest:(YTKBaseRequest*)request{
    NSLog(@"---");
}

#pragma mark - private method
- (NSMutableArray *)detailImageModelsWithJsonString:(NSString *)oSrting{
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
                
                CGFloat imageW = [imgDict[@"width"] floatValue];
                CGFloat imageH = [imgDict[@"height"] floatValue];
                CGFloat adjustHeight = 500.0;
                if (imageW > 0) {
                    adjustHeight = floor(kScreenWidth * imageH / imageW);
                }
                
                TSGoodDetailItemImageModel *item = [[TSGoodDetailItemImageModel alloc] init];
                item.identify = @"TSProductDetailImageCell";
                item.imgUrl = imgDict[@"url"];
                item.imageWidth = imageW;
                item.imageHeight = adjustHeight;
                item.cellHeight = adjustHeight;
                if (item.imgUrl && [urlTest evaluateWithObject:item.imgUrl]) {
                    [detailImageModels addObject:item];
                    
                    [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:[item.imgUrl urlEncode]] options:0 progress:NULL completed:^(UIImage *_Nullable image, NSData *_Nullable data, NSError *_Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL *_Nullable imageURL){}];
                    
                }
            }
        }
    }
    return detailImageModels;
}



@end
