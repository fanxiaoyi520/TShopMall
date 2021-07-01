//
//  TSChangePictionActionSheet.h
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/17.
//

#import <UIKit/UIKit.h>
#import "TSUniversalCollectionViewCell.h"
#import "TSUniversalSectionModel.h"
#import "TSUniversaItemModel.h"
#import "TSBaseDataController.h"

NS_ASSUME_NONNULL_BEGIN

@class TSChangePictureActionSheetItemModel;

@interface TSChangePictureActionSheetSectionModel : TSUniversalSectionModel
/** item */
@property(nonatomic, copy) NSMutableArray<TSChangePictureActionSheetItemModel *> *items;

@end

@interface TSChangePictureActionSheetItemModel : TSUniversaItemModel
/** 标题 */
@property(nonatomic, copy) NSString *title;
/// 选中
@property (nonatomic, assign) BOOL isSelect;
@end

@interface TSActionSheetDataController : TSBaseDataController

/** item */
@property (nonatomic, strong, readonly) NSMutableArray<TSChangePictureActionSheetSectionModel *> *sections;

//- (void)fetchContentsComplete:(void (^)(BOOL))complete;
- (void)fetchContentsWithTitle:(NSArray *)titles Complete:(void (^)(BOOL))complete;

@end

@interface TSChangePictureActionSheetCell : TSUniversalCollectionViewCell

@end


@interface TSChangePictureActionSheet : UIView

- (instancetype)initWithTitles:(NSArray *)titles actionHandler:(void(^)(NSInteger index, NSString *title))actionHandler;

+ (instancetype)actionSheetWithTitles:(NSArray *)titles actionHandler:(void(^)(NSInteger index, NSString *title))actionHandler;

- (void)show;


/// 选择弹出框
/// @param titles 标题数组
/// @param index 默认选中下标
/// @param actionHandler 点击完成回调
- (instancetype)initWithTitles:(NSArray *)titles selectIndex:(NSInteger)index actionHandler:(void(^)(NSInteger index, NSString *title))actionHandler;

@end

NS_ASSUME_NONNULL_END
