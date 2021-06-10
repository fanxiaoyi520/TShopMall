//
//  TSCategoryDataController.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/10.
//

#import "TSBaseDataController.h"
#import "TSCategoryKindModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSCategoryDataController : TSBaseDataController

@property (nonatomic, strong, readonly) NSMutableArray <TSCategoryKindModel *> *kinds;

-(void)fetchKindsComplete:(void(^)(BOOL isSucess))complete;

@end

NS_ASSUME_NONNULL_END
