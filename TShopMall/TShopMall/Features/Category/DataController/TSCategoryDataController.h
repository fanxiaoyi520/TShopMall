//
//  TSCategoryDataController.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/10.
//

#import "TSBaseDataController.h"
#import "TSCategoryKindModel.h"
#import "TSCategorySectionModel.h"
#import "TSCategoryHeaderReusableView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSCategoryDataController : TSBaseDataController

@property (nonatomic, strong, readonly) NSMutableArray <TSCategoryKindModel *> *kinds;
@property (nonatomic, strong, readonly) NSMutableArray <TSCategorySectionModel *> *sections;

-(void)fetchKindsComplete:(void(^)(BOOL isSucess))complete;
-(void)fetchContentsComplete:(void(^)(BOOL isSucess))complete;

@end

NS_ASSUME_NONNULL_END
