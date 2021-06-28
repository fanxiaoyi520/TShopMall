//
//  TSPaySuccessSectionModel.h
//  TShopMall
//
//  Created by edy on 2021/6/24.
//

#import "TSUniversalSectionModel.h"
#import "TSUniversaItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@class TSPaySuccessSectionItemModel;

@interface TSPaySuccessSectionModel : TSUniversalSectionModel
/** items  */
@property(nonatomic, strong) NSMutableArray<TSPaySuccessSectionItemModel *> *items;

@end

@interface TSPaySuccessSectionItemModel : TSUniversaItemModel

@end

NS_ASSUME_NONNULL_END
