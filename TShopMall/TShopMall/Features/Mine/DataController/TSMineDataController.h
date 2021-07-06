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
#import "TSProvinceListModel.h"
#import "TSCityListModel.h"
#import "TSImageBaseModel.h"
#import "TSHomePageContentModel.h"

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
/**
 * 根据省份uuid获取它下面的城市参数
 */
@property (nonatomic ,strong)TSProvinceListModel *provinceListModel;
/**
 *用户提现密码校验参数
 */
@property (nonatomic ,copy)NSString *inputPassword;


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
@property (nonatomic, strong, readonly) NSMutableArray <TSProvinceListModel *> *provinceListArray;
@property (nonatomic, strong, readonly) NSMutableArray <TSCityListModel *> *cityListArray;
@property (nonatomic,   copy, readonly) NSString *isSetWithdrawalPassword;//是否设置提现密码
@property (nonatomic,   copy, readonly) NSString *withdrawalPasswordPublicKey;//提现密码公钥

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
////我的收益
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
//获取全部省和直辖市
- (void)fetchGetAllProvinceDataComplete:(void(^)(BOOL isSucess))complete;
//根据省份uuid获取它下面的城市
- (void)fetchGetAllCityByProvinceUuidDataComplete:(void(^)(BOOL isSucess))complete;
//获取公钥密钥
- (void)fetchGetPublicKeyDataComplete:(void(^)(BOOL isSucess))complete;
//校验该用户是否设置过提现密码
- (void)fetchCheckWhetherSetWithdrawalPwdDataComplete:(void(^)(BOOL isSucess))complete;
//校验提现密码是否正确
- (void)fetchCheckWithdrawalPwdDataComplete:(void(^)(BOOL isSucess))complete;

/**
 * 提现密码业务-----------多个网络请求
 */
-(void)fetchWithdrawalPasswordDataComplete:(void(^)(BOOL isSucess))complete;
@end

NS_ASSUME_NONNULL_END
