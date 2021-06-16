//
//  TSBindMobileSectionModel.h
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/15.
//

#import "TSUniversalSectionModel.h"
#import "TSUniversaItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@class TSBindMobileSectionItemModel;

@interface TSBindMobileSectionModel : TSUniversalSectionModel
/// item
@property (nonatomic, strong) NSArray<TSBindMobileSectionItemModel *> *items;

@end

@interface TSBindMobileSectionItemModel : TSUniversaItemModel

@end

NS_ASSUME_NONNULL_END
