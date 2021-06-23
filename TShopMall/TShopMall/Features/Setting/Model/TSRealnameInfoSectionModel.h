//
//  TSRealnameInfoSectionModel.h
//  TShopMall
//
//  Created by edy on 2021/6/23.
//

#import "TSUniversalSectionModel.h"
#import "TSUniversaItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@class TSRealnameInfoSectionItemModel;

@interface TSRealnameInfoSectionModel : TSUniversalSectionModel
/** items  */
@property(nonatomic, strong) NSMutableArray<TSRealnameInfoSectionItemModel *> *items;

@end

@interface TSRealnameInfoSectionItemModel : TSUniversaItemModel
/** 姓名  */
@property(nonatomic, copy) NSString *realname;
/** 身份证号  */
@property(nonatomic, copy) NSString *idcard;

@end

NS_ASSUME_NONNULL_END
