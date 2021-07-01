//
//  TSRankSectionModel.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/17.
//

#import "TSUniversalSectionModel.h"
#import "TSUniversaItemModel.h"
#import "TSRecomendGoodsProtocol.h"
@class TSRankSectionItemModel;

NS_ASSUME_NONNULL_BEGIN

@interface TSRankSectionModel : TSUniversalSectionModel

/// 头标题
@property (nonatomic, copy) NSString *headerName;
/// item
@property (nonatomic, strong) NSArray <TSRankSectionItemModel *> *items;

@end

@interface TSRankSectionItemModel : TSUniversaItemModel
/** 排名  */
@property(nonatomic, assign) int rank;
@property (nonatomic, assign) BOOL isLast;
@property(nonatomic, strong) NSArray *datas;

@end

NS_ASSUME_NONNULL_END
