//
//  TSBindThirdSectionModel.h
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/15.
//

#import "TSUniversalSectionModel.h"
#import "TSUniversaItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@class TSBindThirdSectionItemModel;

@interface TSBindThirdSectionModel : TSUniversalSectionModel
/** items */
@property (nonatomic, strong) NSMutableArray<TSBindThirdSectionItemModel *> *items;

@end

@interface TSBindThirdSectionItemModel : TSUniversaItemModel
/** 是否是微信 */
@property(nonatomic, assign, getter=isWechat) BOOL wechat;
/** 账号 */
@property(nonatomic, copy) NSString *account;

@end

NS_ASSUME_NONNULL_END
