//
//  TSRankSectionModel.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/17.
//

#import "TSUniversalSectionModel.h"
#import "TSUniversaItemModel.h"

@class TSRankSectionItemModel;

NS_ASSUME_NONNULL_BEGIN

@interface TSRankSectionModel : TSUniversalSectionModel

/// 头标题
@property (nonatomic, copy) NSString *headerName;
/// item
@property (nonatomic, strong) NSArray <TSRankSectionItemModel *> *items;

@end

@interface TSRankSectionItemModel : TSUniversaItemModel

@end

NS_ASSUME_NONNULL_END
