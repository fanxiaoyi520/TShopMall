//
//  TSHotSectionModel.h
//  TShopMall
//
//  Created by edy on 2021/6/21.
//

#import "TSUniversalSectionModel.h"
#import "TSUniversaItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@class TSHotSectionItemModel;

@interface TSHotSectionModel : TSUniversalSectionModel
/// item
@property (nonatomic, strong) NSArray <TSHotSectionItemModel *> *items;

@end

@interface TSHotSectionItemModel : TSUniversaItemModel
/** 排名  */
@property(nonatomic, assign) int rank;

@end

NS_ASSUME_NONNULL_END
