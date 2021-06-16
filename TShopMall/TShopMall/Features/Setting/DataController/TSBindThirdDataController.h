//
//  TSBindThirdDataController.h
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/15.
//

#import "TSBaseDataController.h"
#import "TSBindThirdSectionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSBindThirdDataController : TSBaseDataController

@property (nonatomic, strong, readonly) NSMutableArray <TSBindThirdSectionModel *> *sections;

- (void)fetchBindThirdContentsComplete:(void(^)(BOOL isSucess))complete;

@end

NS_ASSUME_NONNULL_END
