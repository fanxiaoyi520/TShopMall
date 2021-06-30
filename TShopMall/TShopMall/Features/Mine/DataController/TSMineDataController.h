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
#import "TSBankCardModel.h"
#import "TSAddBankCardModel.h"
#import "TSAddBankCardBackModel.h"
#import "TSBranchCardModel.h"
#import "TSMineWalletModel.h"
#import "TSMineOrderCountModel.h"
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger, RequestMethod){
    Ordinary,
    Refresh,
    Load,
};
@interface TSMineDataController : TSBaseDataController
//全局参数
@property (nonatomic ,assign)NSInteger pageNo;
/**
 * 提现记录参数
 */
@property (nonatomic ,assign)NSInteger status;
@property (nonatomic ,assign)RequestMethod requestMethod;
/**
 * 提现申请参数
 */
@property (nonatomic ,copy)NSString *withdrawalAmount;
@property (nonatomic ,copy)NSString *bankCardAccountId;
/**
 * 银行卡入参model
 */
@property (nonatomic ,strong)TSAddBankCardModel *addBankCardModel;
/**
 * 删除银行卡model
 */
@property (nonatomic ,strong)TSBankCardModel *bankCardModel;

@property (nonatomic, strong, readonly) NSMutableArray <TSMineSectionModel *> *sections;
@property (nonatomic, strong, readonly) TSMineMerchantUserInformationModel *merchantUserInformationModel;
@property (nonatomic, strong, readonly) TSPartnerCenterData *partnerCenterDataModel;
@property (nonatomic, strong, readonly) TSWalletModel *walletModel;
@property (nonatomic, strong, readonly) TSMyIncomeModel *myIncomeModel;
@property (nonatomic, strong, readonly) NSMutableArray <TSWithdrawalRecordModel *> *withdrawalRecordArray;
@property (nonatomic, strong, readonly) NSMutableArray <TSBankCardModel *> *bankCardArray;
@property (nonatomic, strong, readonly) TSAddBankCardBackModel *addBankCardBackModel;
@property (nonatomic,   copy, readonly) NSString *amount;//分
@property (nonatomic, strong, readonly) NSMutableArray <TSBranchCardModel *> *branchCardArray;
@property (nonatomic, strong, readonly) NSMutableArray <TSAddBankCardBackModel *> *addBankCardBackArray;
@property (nonatomic, strong, readonly) TSWithdrawalRecordModel *withdrawalRecordModel;
@property (nonatomic, strong, readonly) TSMineWalletEarningModel *earningModel;
//订单数
@property (nonatomic, strong, readonly) TSMineOrderCountModel *orderInfo;

-(void)fetchMineContentsComplete:(void(^)(BOOL isSucess))complete;
-(void)fetchDataComplete:(void(^)(BOOL isSucess))complete;

//我的钱包
- (void)fetchMineWalletDataComplete:(void(^)(BOOL isSucess))complete;
//提现记录
- (void)fetchWithdrawalRecordDataComplete:(void(^)(BOOL isSucess))complete;
//提现申请
- (void)fetchWithdrawalApplicationDataComplete:(void(^)(BOOL isSucess))complete;
//我的收益
- (void)fetchMyIncomeDataComplete:(void(^)(BOOL isSucess))complete;
//查询银行卡列表
- (void)fetchQueryBankCardListDataComplete:(void(^)(BOOL isSucess))complete;
//添加银行卡
- (void)fetchAddToBankCardDataComplete:(void(^)(BOOL isSucess))complete;
//校验银行卡
- (void)fetchCheckBankCardDataComplete:(void(^)(BOOL isSucess))complete;
//查询支行
- (void)fetchInquiryBranchDataComplete:(void(^)(BOOL isSucess))complete;
//删除银行卡
- (void)fetchDeleteBankCardDataComplete:(void(^)(BOOL isSucess))complete;
//查询我的余额
- (void)fetchCheckMyBalanceDataComplete:(void(^)(BOOL isSucess))complete;
//查询银行列表
- (void)fetchQueryBankDataComplete:(void(^)(BOOL isSucess))complete;
@end

NS_ASSUME_NONNULL_END
