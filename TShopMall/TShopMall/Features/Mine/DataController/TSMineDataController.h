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
#import "TSWalletModel.h"
#import "TSMyIncomeModel.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, RequestMethod){
    Ordinary,
    Refresh,
    Load,
};
@interface TSMineDataController : TSBaseDataController
@property (nonatomic ,assign)NSInteger pageNo;
@property (nonatomic ,assign)NSInteger status;
@property (nonatomic ,assign)RequestMethod requestMethod;

@property (nonatomic, strong, readonly) NSMutableArray <TSMineSectionModel *> *sections;
@property (nonatomic, strong, readonly) TSMineMerchantUserInformationModel *merchantUserInformationModel;
@property (nonatomic, strong, readonly) TSPartnerCenterData *partnerCenterDataModel;
@property (nonatomic, strong, readonly) TSWalletModel *walletModel;
@property (nonatomic, strong, readonly) TSMyIncomeModel *myIncomeModel;
@property (nonatomic, strong, readonly) NSMutableArray <TSWithdrawalRecordModel *> *withdrawalRecordArray;

-(void)fetchMineContentsComplete:(void(^)(BOOL isSucess))complete;
-(void)fetchDataComplete:(void(^)(BOOL isSucess))complete;

//我的钱包
- (void)fetchMineWalletDataComplete:(void(^)(BOOL isSucess))complete;

//提现记录
- (void)fetchWithdrawalRecordDataComplete:(void(^)(BOOL isSucess))complete;
//我的收益
- (void)fetchMyIncomeDataComplete:(void(^)(BOOL isSucess))complete;
@end

NS_ASSUME_NONNULL_END
