//
//  TSPhoneNumSectionModel.h
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/15.
//

#import "TSUniversalSectionModel.h"
#import "TSUniversaItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@class TSPhoneNumSectionItemModel;

@interface TSPhoneNumSectionModel : TSUniversalSectionModel
/// item
@property (nonatomic, strong) NSArray<TSPhoneNumSectionItemModel *> *items;

@end

@interface TSPhoneNumSectionItemModel : TSUniversaItemModel
/** 手机号 */
@property(nonatomic, copy) NSString *phoneNum;

@end

NS_ASSUME_NONNULL_END
