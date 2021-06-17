//
//  TSSettingSectionModel.h
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/12.
//

#import "TSUniversalSectionModel.h"
#import "TSUniversaItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@class TSSettingSectionItemModel, TSSettingCommonSectionItemModel, TSSettingExitSectionItemModel;

@interface TSSettingSectionModel : TSUniversalSectionModel
/// item
@property (nonatomic, strong) NSArray<TSSettingSectionItemModel *> *items;

@end

@interface TSSettingSectionItemModel : TSUniversaItemModel

@end

@interface TSSettingCommonSectionItemModel : TSSettingSectionItemModel
/** 标题 */
@property(nonatomic, copy) NSString *title;
/** 副标题 */
@property(nonatomic, copy) NSString *detail;
/** 是否显示分割线 */
@property(nonatomic, assign, getter=isShowLine) BOOL showLine;
/** 是否显示更新标识 */
@property(nonatomic, assign) BOOL updateFlag;
/** 开关是否打开 */
@property(nonatomic, assign) BOOL on;

@end

@interface TSSettingExitSectionItemModel : TSSettingSectionItemModel

@end

NS_ASSUME_NONNULL_END
