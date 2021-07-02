//
//  TSAccountCancelSectionModel.h
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/16.
//

#import "TSUniversalSectionModel.h"
#import "TSUniversaItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@class TSAccountCancelSectionItemModel;

@interface TSAccountCancelSectionModel : TSUniversalSectionModel

/** items */
@property (nonatomic, strong) NSMutableArray<TSAccountCancelSectionItemModel *> *items;

@end

@interface TSAccountCancelSectionItemModel : TSUniversaItemModel
/** 标题 */
@property(nonatomic, copy) NSString *title;
/** 内容 */
@property(nonatomic, copy) NSString *content;
/** 昵称 */
@property(nonatomic, copy) NSString *nickname;
/** 按钮标题 */
@property(nonatomic, copy) NSString *nextTitle;
/** 放弃的终点时间  */
@property(nonatomic, copy) NSString *dropTime;
/** 注销的时间  */
@property(nonatomic, copy) NSString *cancelTime;
@end

NS_ASSUME_NONNULL_END
