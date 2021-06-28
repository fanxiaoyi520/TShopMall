//
//  TSAboutMeSectionModel.h
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/13.
//

#import "TSUniversalSectionModel.h"
#import "TSUniversaItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@class TSAboutMeSectionItemModel, TSAboutMeBottomSectionItemModel;

@interface TSAboutMeSectionModel : TSUniversalSectionModel
/// item
@property (nonatomic, strong) NSArray<TSAboutMeSectionItemModel *> *items;

@end

@interface TSAboutMeSectionItemModel : TSUniversaItemModel
/** 版本号 */
@property(nonatomic, copy) NSString *version;

@end

//@interface TSAboutMeBottomSectionModel : TSUniversalSectionModel
///// item
//@property (nonatomic, strong) NSArray<TSAboutMeBottomSectionItemModel *> *items;
//
//@end

@interface TSAboutMeBottomSectionItemModel : TSAboutMeSectionItemModel
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
/** 服务器地址  */
@property(nonatomic, copy) NSString *serverURL;

@end



NS_ASSUME_NONNULL_END
