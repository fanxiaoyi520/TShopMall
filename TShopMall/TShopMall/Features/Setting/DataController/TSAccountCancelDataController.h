//
//  TSAccountCancelController.h
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/16.
//

#import "TSBaseDataController.h"
#import "TSAccountCancelSectionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSAccountCancelDataController : TSBaseDataController

@property (nonatomic, strong, readonly) NSMutableArray <TSAccountCancelSectionModel *> *sections;

- (void)fetchContentsComplete:(void(^)(BOOL isSucess))complete;

- (void)fetchCancelNextContentsComplete:(void(^)(BOOL isSucess))complete;

- (void)fetchCancelLastConfirmContentsComplete:(void(^)(BOOL isSucess))complete;

- (void)fetchDropConfirmContentsWithDropTime:(NSString *)dropTime complete:(void(^)(BOOL isSucess))complete;

@end

NS_ASSUME_NONNULL_END
