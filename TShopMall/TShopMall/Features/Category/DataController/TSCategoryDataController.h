//
//  TSCategoryDataController.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/10.
//

#import "TSBaseDataController.h"
#import "TSCategoryKindModel.h"
#import "TSCategoryContentModel.h"

/// 每个分类的 section 总数量
#define categoryContentCount 3

NS_ASSUME_NONNULL_BEGIN

@interface TSCategoryDataController : TSBaseDataController

@property (nonatomic, strong, readonly) NSMutableArray <TSCategoryKindModel *> *kinds;
@property (nonatomic, strong, readonly) NSMutableArray <TSCategoryContentModel *> *sections;

-(void)fetchKindsComplete:(void(^)(BOOL isSucess))complete;

@end

NS_ASSUME_NONNULL_END
