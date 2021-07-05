//
//  TSRealNameAuthDataController.h
//  TShopMall
//
//  Created by edy on 2021/6/23.
//

#import "TSBaseDataController.h"
#import "TSRealNameAuthSectionModel.h"

NS_ASSUME_NONNULL_BEGIN


@interface TSRealNameAuthDataController : TSBaseDataController
/** sections  */
@property(nonatomic, strong, readonly) NSMutableArray<TSRealNameAuthSectionModel *> *sections;

- (void)fetchRealNameAuthContentsComplete:(void(^)(BOOL isSucess))complete;

- (void)checkRealAuthComplete:(void(^)(BOOL isSucess))complete;
@end

NS_ASSUME_NONNULL_END
