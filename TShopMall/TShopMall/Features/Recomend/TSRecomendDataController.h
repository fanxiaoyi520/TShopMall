//
//  TSRecomendDataController.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/22.
//

#import "TSBaseDataController.h"
#import "TSRecomendModel.h"
#import "TSRecomendSection.h"

@interface TSRecomendDataController : TSBaseDataController
@property (nonatomic, strong) TSRecomendModel *recomend;
@property (nonatomic, strong) TSRecomendPageInfo *pageInfo;
@property (nonatomic, assign) CGSize rowSize;
@property (nonatomic, assign) NSInteger pageType;
- (void)fetchRecomentDatas:(void(^)(void))finished;


- (NSArray<TSRecomendSection *> *)congifSections;
@end

