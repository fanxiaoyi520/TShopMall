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

@interface TSRankUserModel : NSObject
@property (nonatomic, copy) NSString * rank;
@property (nonatomic, copy) NSString * imageUrl;
@property (nonatomic, copy) NSString * userName;
@property (nonatomic, copy) NSString * mobile;
@property (nonatomic, copy) NSString * money;
@end

@interface TSRankSectionItemModel : TSUniversaItemModel
/// 最后一名
@property (nonatomic, assign) BOOL isLast;
/// 用户数据
@property (nonatomic, strong) TSRankUserModel * userModel;
/// 前3名排行数据
@property(nonatomic, strong) NSArray<TSRankUserModel *> *rankList;
/// 热销数据
@property(nonatomic, strong) NSArray *datas;

@end

NS_ASSUME_NONNULL_END
