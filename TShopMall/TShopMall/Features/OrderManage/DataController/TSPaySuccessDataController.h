//
//  TSPaySuccessDataController.h
//  TShopMall
//
//  Created by edy on 2021/6/24.
//

#import "TSBaseDataController.h"
#import "TSPaySuccessSectionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSPaySuccessDataController : TSBaseDataController
/** sections  */
@property(nonatomic, strong, readonly) NSMutableArray<TSPaySuccessSectionModel *> *sections;

- (void)fetchPaySuccessComplete:(void(^)(BOOL isSucess))complete;

@end

NS_ASSUME_NONNULL_END
