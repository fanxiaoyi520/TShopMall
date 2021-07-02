//
//  TSSecurityCenterDataController.h
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/13.
//

#import "TSBaseDataController.h"
#import "TSSettingSectionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSSecurityCenterDataController : TSBaseDataController

@property (nonatomic, strong, readonly) NSMutableArray <TSSettingSectionModel *> *sections;

- (void)fetchSecurityCenterContentsComplete:(void(^)(BOOL isSucess))complete;
@property (nonatomic, strong) NSArray <TSAgreementModel*> *agreementModels;
@end

NS_ASSUME_NONNULL_END
