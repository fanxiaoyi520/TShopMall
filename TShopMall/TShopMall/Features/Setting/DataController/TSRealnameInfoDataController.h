//
//  TSRealnameInfoDataController.h
//  TShopMall
//
//  Created by edy on 2021/6/23.
//

#import "TSBaseDataController.h"
#import "TSRealnameInfoSectionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSRealnameInfoDataController : TSBaseDataController
/** sections  */
@property(nonatomic, strong, readonly) NSMutableArray<TSRealnameInfoSectionModel *> *sections;

- (void)fetchRealnameInfoContentsComplete;

- (void)checkRealAuthComplete:(void(^)(BOOL isSucess))complete;
@end

NS_ASSUME_NONNULL_END
