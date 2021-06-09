//
//  TSHomePageDataController.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/8.
//

#import "TSBaseDataController.h"
#import "TSHomePageLayoutModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSHomePageDataController : TSBaseDataController

/// 首页布局对象
@property(nonatomic, strong) NSMutableArray <FMLayoutBaseSection *> *layouts;

-(NSMutableArray <FMLayoutBaseSection *> *)fetchPlaceholderLayouts;

@end

NS_ASSUME_NONNULL_END
