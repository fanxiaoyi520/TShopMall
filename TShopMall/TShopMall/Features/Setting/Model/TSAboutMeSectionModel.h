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

@end



NS_ASSUME_NONNULL_END
