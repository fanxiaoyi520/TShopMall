//
//  TSRealNameAuthSectionModel.h
//  TShopMall
//
//  Created by edy on 2021/6/23.
//

#import "TSUniversalSectionModel.h"
#import "TSUniversaItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@class TSRealNameAuthSectionItemModel;

@interface TSRealNameAuthSectionModel : TSUniversalSectionModel
/** items  */
@property(nonatomic, strong) NSMutableArray<TSRealNameAuthSectionItemModel *> *items;

@end

@interface TSRealNameAuthSectionItemModel : TSUniversaItemModel

@end

NS_ASSUME_NONNULL_END
