//
//  TSPersonalSectionModel.h
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/13.
//

#import "TSUniversalSectionModel.h"
#import "TSUniversaItemModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    none = 0,
    male = 1,
    female = 2,
} Sex;

@class TSPersonalSectionItemModel;

@interface TSPersonalSectionModel : TSUniversalSectionModel
/// item
@property (nonatomic, strong) NSArray<TSPersonalSectionItemModel *> *items;

@end

@interface TSPersonalSectionItemModel : TSUniversaItemModel
/** 标题 */
@property(nonatomic, copy) NSString *title;
/** 详情 */
@property(nonatomic, copy) NSString *detail;
/** 头像 */
@property(nonatomic, copy) NSString *head;
/** 性别 */
@property(nonatomic, assign) Sex sex;
@end

NS_ASSUME_NONNULL_END
