//
//  TSChangePictureSectionModel.h
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/16.
//

#import "TSUniversalSectionModel.h"
#import "TSUniversaItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@class TSChangePictureSectionItemModel;

@interface TSChangePictureSectionModel : TSUniversalSectionModel
/** items */
@property (nonatomic, strong) NSMutableArray<TSChangePictureSectionItemModel *> *items;

@end

@interface TSChangePictureSectionItemModel : TSUniversaItemModel
/** 图片 */
@property(nonatomic, copy) NSString *icon;
/** 标题 */
@property(nonatomic, copy) NSString *title;
/** 是否被选中  */
@property(nonatomic, assign, getter=isSelected) BOOL selected;

@end

NS_ASSUME_NONNULL_END
