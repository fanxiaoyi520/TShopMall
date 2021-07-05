//
//  TSHotSectionModel.h
//  TShopMall
//
//  Created by edy on 2021/6/21.
//

#import "TSUniversalSectionModel.h"
#import "TSUniversaItemModel.h"
#import "TSRecomendModel.h"

NS_ASSUME_NONNULL_BEGIN

@class TSHotSectionItemModel;

@interface TSHotSectionModel : TSUniversalSectionModel
/// item
@property (nonatomic, strong) NSArray <TSHotSectionItemModel *> *items;

@end

@interface TSHotSectionItemModel : TSUniversaItemModel
/// 商品数据
@property (nonatomic, strong) TSRecomendGoods * goodModel;
/// 前3名排行数据
@property(nonatomic, strong) NSArray<TSRecomendGoods *> *rankList;

@end

NS_ASSUME_NONNULL_END
