//
//  TSRecomendDataController.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/22.
//

#import "TSBaseDataController.h"
#import "TSRecomendModel.h"

typedef NS_ENUM(NSInteger, RecomendPageType) {
    RecomendSearchPage     = 0,
    RecomendSearchResultPage   ,
    RecomendCartPage                ,
};

@interface TSRecomendDataController : TSBaseDataController

+ (void)checkCurrentRecomendPage:(RecomendPageType)pageType finished:(void(^)(TSRecomendModel *recomendInfo, TSRecomendPageInfo *pageInfo))finished;
@end

