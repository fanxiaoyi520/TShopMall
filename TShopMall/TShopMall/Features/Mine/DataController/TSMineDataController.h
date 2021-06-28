//
//  TSMineDataController.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/11.
//

#import "TSBaseDataController.h"
#import "TSMineSectionModel.h"
#import "TSMineMerchantUserInformationModel.h"
#import "TSPartnerCenterData.h"
#import "TSWithdrawalRecordModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSMineDataController : TSBaseDataController

@property (nonatomic, strong, readonly) NSMutableArray <TSMineSectionModel *> *sections;
@property (nonatomic, strong, readonly) TSMineMerchantUserInformationModel *merchantUserInformationModel;
@property (nonatomic, strong, readonly) TSPartnerCenterData *partnerCenterDataModel;
@property (nonatomic, strong, readonly) TSWithdrawalRecordModel *withdrawalRecordModel;

-(void)fetchMineContentsComplete:(void(^)(BOOL isSucess))complete;
-(void)fetchDataComplete:(void(^)(BOOL isSucess))complete;

//提现记录
- (void)fetchWithdrawalRecordDataComplete:(void(^)(BOOL isSucess))complete;
@end

NS_ASSUME_NONNULL_END
