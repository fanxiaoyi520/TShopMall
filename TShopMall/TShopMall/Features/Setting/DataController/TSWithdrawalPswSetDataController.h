//
//  TSWithdrawalPswSetDataController.h
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/15.
//

#import "TSBaseDataController.h"
#import "TSWithdrawalPswSetSectionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSWithdrawalPswSetDataController : TSBaseDataController

@property (nonatomic, strong, readonly) NSMutableArray <TSWithdrawalPswSetSectionModel *> *sections;

- (void)fetchWithdrawalPswSetContentsWithHasSet:(BOOL)hasSet complete:(void(^)(BOOL isSucess))complete;

@end

NS_ASSUME_NONNULL_END
