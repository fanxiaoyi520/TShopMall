//
//  TSWithdrawalPswSetSectionModel.h
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/15.
//

#import "TSUniversalSectionModel.h"
#import "TSUniversaItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@class TSWithdrawalPswSetSectionItemModel;

@interface TSWithdrawalPswSetSectionModel : TSUniversalSectionModel
/// item
@property (nonatomic, strong) NSArray<TSWithdrawalPswSetSectionItemModel *> *items;

@end

@interface TSWithdrawalPswSetSectionItemModel : TSUniversaItemModel

@end

NS_ASSUME_NONNULL_END
