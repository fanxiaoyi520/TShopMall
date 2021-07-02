//
//  TSMineDataController.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/11.
//

#import "TSMineDataController.h"

@interface TSMineDataController()

@property (nonatomic, strong) NSMutableArray <TSMineSectionModel *> *sections;
@property (nonatomic, strong) TSMineMerchantUserInformationModel *merchantUserInformationModel;
@property (nonatomic, strong) TSPartnerCenterData *partnerCenterDataModel;
@property (nonatomic, strong) NSMutableArray <TSWithdrawalRecordModel *> *withdrawalRecordArray;
@property (nonatomic, strong) TSWalletModel *walletModel;
@property (nonatomic, strong) TSMyIncomeModel *myIncomeModel;
@property (nonatomic, strong) NSMutableArray <TSBankCardModel *> *bankCardArray;
@property (nonatomic, strong) TSAddBankCardBackModel *addBankCardBackModel;
@property (nonatomic, copy) NSString *amount;
@property (nonatomic, strong) NSMutableArray <TSBranchCardModel *> *branchCardArray;
@property (nonatomic, strong) NSMutableArray <TSAddBankCardBackModel *> *addBankCardBackArray;
@property (nonatomic, strong) TSWithdrawalRecordModel *withdrawalRecordModel;
@property (nonatomic, strong) TSMineWalletEarningModel *earningModel;
@property (nonatomic, strong) TSMineOrderCountModel *orderInfo;
@property (nonatomic, strong) NSMutableArray <TSProvinceListModel *> *provinceListArray;
@property (nonatomic, strong) NSMutableArray <TSCityListModel *> *cityListArray;
@property (nonatomic,copy) NSString* content;
@end

@implementation TSMineDataController


// MARK: fetch
-(void)fetchMineContentsComplete:(void(^)(BOOL isSucess))complete{
    
    NSMutableArray *sections = [NSMutableArray array];
    
    {
        NSMutableArray *items = [NSMutableArray array];
        
        NSArray *titles = @[@"待付款",@"待发货",@"待收货",@"已完成",@"退款/退货"];
        NSArray *images = @[@"mall_mine_ payment",@"mall_mine_deliver",@"mall_mine_takedelivery",@"mall_mine_complete",@"mall_mine_refund"];
        
        for (int i = 0; i < titles.count; i++) {
            NSString *title = titles[i];
            NSString *image = images[i];
            
            TSMineSectionOrderItemModel *item = [[TSMineSectionOrderItemModel alloc] init];
            item.title = title;
            item.imageName = image;
            item.cellHeight = 80;
            item.identify = @"TSMineImageTextCell";
            switch (i) {
                case 0:
                    item.orderCount = self.orderInfo.waitpay;
                    break;
                case 1:
                    item.orderCount = self.orderInfo.waitship;
                    break;

                case 2:
                    item.orderCount = self.orderInfo.shipping;
                    break;

                case 3:
                    item.orderCount = self.orderInfo.succeedorder;
                    break;

                case 4:
                    item.orderCount = self.orderInfo.waitpay;
                    break;
                case 5:
                    item.orderCount = self.orderInfo.afterorder;
                    break;
                default:
                    break;
            }
            [items addObject:item];
        }

        TSMineSectionModel *section = [[TSMineSectionModel alloc] init];
        section.hasHeader = YES;
        section.headerName = @"订单";
        section.headerSize = CGSizeMake(0, 45);
        section.headerIdentify = @"TSMineOrderHeaderView";
        section.hasFooter = YES;
        section.footerSize = CGSizeMake(0, 14);
        section.footerIdentify = @"TSUniversalBottomFooterView";
        section.sectionInset = UIEdgeInsetsMake(0, 16, 0, 16);
        section.spacingWithLastSection = 130;
        section.column = 5;
        section.items = items;
        
        [sections addObject:section];
    }
    
    {
        NSMutableArray *items = [NSMutableArray array];
        
        TSMineSectionEarnItemModel *item = [[TSMineSectionEarnItemModel alloc] init];
        item.cellHeight = 66;
        item.identify = @"TSMineEarningsCell";
        
        [items addObject:item];
        
        TSMineSectionModel *section = [[TSMineSectionModel alloc] init];
        section.sectionInset = UIEdgeInsetsMake(0, 16, 0, 16);
        section.column = 1;
        section.hasDecorate = YES;
        section.docorateIdentify = @"TSUniversalAllCornersDecorationView";
        section.decorateInset = UIEdgeInsetsMake(0, 16, 0, 16);
        section.spacingWithLastSection = 12;
        section.items = items;
        
        [sections addObject:section];
    }
    
    {
        TSMineSectionAdsItemModel *item = [[TSMineSectionAdsItemModel alloc] init];
        item.cellHeight = 58;
        item.identify = @"TSMineAdsCell";

        TSMineSectionModel *section = [[TSMineSectionModel alloc] init];
        section.spacingWithLastSection = 12;
        section.sectionInset = UIEdgeInsetsMake(0, 16, 0, 16);
        section.items = @[item];

        [sections addObject:section];
    }
    
    {
        NSMutableArray *items = [NSMutableArray array];
        
        TSMineSectionParterItemModel *item = [[TSMineSectionParterItemModel alloc] init];
        item.cellHeight = 182;
        item.identify = @"TSMinePartnerCenterCell";
        
        [items addObject:item];
        
        TSMineSectionModel *section = [[TSMineSectionModel alloc] init];
        section.sectionInset = UIEdgeInsetsMake(0, 16, 0, 16);
        section.column = 1;
        section.hasDecorate = YES;
        section.docorateIdentify = @"TSUniversalAllCornersDecorationView";
        section.decorateInset = UIEdgeInsetsMake(0, 16, 0, 16);
        section.spacingWithLastSection = 12;
        section.items = items;
        
        [sections addObject:section];
    }

    {
        NSMutableArray *items = [NSMutableArray array];
        
        NSArray *titles = @[@"官方服务",@"在线客服",@"发票管理",@"地址管理",@"去评分"];
        NSArray *images = @[@"mall_mine_official",@"mall_mine_service",@"mall_mine_invoice_manager",@"mall_mine_address_manager",@"mall_mine_evaluate"];
        
        for (int i = 0; i < titles.count; i++) {
            NSString *title = titles[i];
            NSString *image = images[i];
            
            TSMineSectionOrderItemModel *item = [[TSMineSectionOrderItemModel alloc] init];
            item.title = title;
            item.imageName = image;
            item.cellHeight = 75;
            item.identify = @"TSMineImageTextCell";
            
            [items addObject:item];
        }
    if ([self.merchantUserInformationModel.salesmanRankLevel isEqualToString:@"1"]) {
            TSMineSectionOrderItemModel *item = [[TSMineSectionOrderItemModel alloc] init];
            item.title = @"合伙人中心";
            item.imageName = @"mall_mine_partner_center";
            item.cellHeight = 75;
            item.identify = @"TSMineImageTextCell";
            [items insertObject:item atIndex:0];
        }
        
#if DEBUG
        TSMineSectionOrderItemModel *item = [[TSMineSectionOrderItemModel alloc] init];
        item.title = @"站点设置";
        item.imageName = @"mall_mine_evaluate";
        item.cellHeight = 75;
        item.identify = @"TSMineImageTextCell";
        
        [items addObject:item];
#endif
        
        TSMineSectionModel *section = [[TSMineSectionModel alloc] init];
        section.hasHeader = YES;
        section.headerName = @"更多服务";
        section.headerSize = CGSizeMake(0, 45);
        section.headerIdentify = @"TSMineTitleHeaderView";
        section.hasFooter = YES;
        section.footerSize = CGSizeMake(0, 24);
        section.footerIdentify = @"TSUniversalBottomFooterView";
        section.sectionInset = UIEdgeInsetsMake(0, 16, 0, 16);
        section.column = 4;
        section.hasDecorate = YES;
        section.docorateIdentify = @"TSUniversalNoneCornersDecorationView";
        section.decorateInset = UIEdgeInsetsMake(0, 16, 0, 16);
        section.spacingWithLastSection = 12;
        section.items = items;
        
        [sections addObject:section];
    }
    
    {
        TSMineSectionParterItemModel *item = [[TSMineSectionParterItemModel alloc] init];
        item.cellHeight = 62;
        item.identify = @"TSMinePlaceholderCell";
        
        TSMineSectionModel *section = [[TSMineSectionModel alloc] init];
        section.sectionInset = UIEdgeInsetsMake(0, 16, 0, 16);
        section.column = 1;
        section.spacingWithLastSection = 0;
        section.items = @[item];
        
        [sections addObject:section];
    }
    
    self.sections = sections;
    
    if (complete) {
        complete(YES);
    }
}

// MARK: 个人中心
-(void)fetchDataComplete:(void(^)(BOOL isSucess))complete {
    dispatch_group_t group = dispatch_group_create();

   
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
      dispatch_group_enter(group);
        [self requestMethodWithGroup:group withIndex:1];
    });

    dispatch_group_enter(group);
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self requestMethodWithGroup:group withIndex:2];
    });

    dispatch_group_enter(group);
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self requestMethodWithGroup:group withIndex:3];
    });
    
    dispatch_group_enter(group);
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self requestMethodWithGroup:group withIndex:4];
    });
    
    dispatch_group_enter(group);
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self requestMethodWithGroup:group withIndex:5];
    });
    
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if (complete) {
        self.partnerCenterDataModel.salesmanRankLevel = self.merchantUserInformationModel.salesmanRankLevel;
        [self fetchMineContentsComplete:^(BOOL isSucess) {
                
            }];
            complete(YES);
        }
    });
}

- (void)requestMethodWithGroup:(dispatch_group_t)thegroup withIndex:(NSInteger)aIndex
{
    NSString *request = [NSString stringWithFormat:@"request%ld",(long)aIndex];
    SEL requestSel = NSSelectorFromString(request);
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
     [(SSGenaralRequest *)[self performSelector:requestSel] startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
         if (request.responseModel.isSucceed) {
             NSDictionary *data = request.responseModel.data;
             if (aIndex == 1) {
                 TSMineMerchantUserInformationModel *model = [TSMineMerchantUserInformationModel yy_modelWithDictionary:data];
                 self.merchantUserInformationModel = model;
             } else if (aIndex == 2) {
                 TSPartnerCenterData *model = [TSPartnerCenterData yy_modelWithDictionary:data];
                 self.partnerCenterDataModel = model;
                 self.partnerCenterDataModel.eyeIsOn = YES;
             } else if (aIndex == 3){
               self.earningModel = [TSMineWalletEarningModel yy_modelWithDictionary:data];
                 self.earningModel.eyeIsOn = YES;
             } else if (aIndex == 4) {
                 NSLog(@"%@",data);
                 self.content = [data stringForkey:@"content"];
             } else if (aIndex == 5){
                 self.orderInfo =  [TSMineOrderCountModel yy_modelWithDictionary:data];
             }
         }
         
         dispatch_group_leave(thegroup);
     } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
         dispatch_group_leave(thegroup);
     }];
#pragma clang diagnostic pop
}

- (SSGenaralRequest *)request1{
    
    NSMutableDictionary *header = [NSMutableDictionary dictionary];
    if ([TSGlobalManager shareInstance].currentUserInfo) {
        [header setValue:[TSGlobalManager shareInstance].currentUserInfo.accessToken forKey:@"accessToken"];
    }
   
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kMineMerchantUserInformation
                                                               requestMethod:YTKRequestMethodGET
                                                       requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:header
                                                                 requestBody:NSMutableDictionary.dictionary
                                                              needErrorToast:YES];
    
    return request;
}

- (SSGenaralRequest *)request2{
    NSMutableDictionary *header = [NSMutableDictionary dictionary];
 
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kMinePartnerCenterData
                                                               requestMethod:YTKRequestMethodGET
                                                       requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:header
                                                                 requestBody:NSMutableDictionary.dictionary
                                                              needErrorToast:YES];
    
    return request;
}

//收益
- (SSGenaralRequest *)request3{
    
    NSMutableDictionary *header = [NSMutableDictionary dictionary];
    if ([TSGlobalManager shareInstance].currentUserInfo) {
        [header setValue:[TSGlobalManager shareInstance].currentUserInfo.accessToken forKey:@"accessToken"];
    }
//    [header setValue:@"application/json" forKey:@"Content-Type"];
    NSMutableDictionary *body = [NSMutableDictionary dictionary];
    [body setValue:@"6226097804210467" forKey:@"bankCardNo"];
    [body setValue:@"招商银行" forKey:@"accountBank"];
    [body setValue:@"CMD" forKey:@"accountBankCode"];
    [body setValue:@"招商银行北京支行" forKey:@"bankName"];
    [body setValue:@"308551024051" forKey:@"bankBranchId"];
    [body setValue:@"北京市" forKey:@"bankAddressProvince"];
    [body setValue:@"110000" forKey:@"bankAddressProvinceCode"];
    [body setValue:@"北京市" forKey:@"bankAddressCity"];
    [body setValue:@"110000" forKey:@"bankAddressCityCode"];
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kMineQueryProfit
                                                               requestMethod:YTKRequestMethodGET
                                                       requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:header
                                                                 requestBody:body
                                                              needErrorToast:YES];
    
    return request;
}

//广告图
- (SSGenaralRequest *)request4{
    
    NSMutableDictionary *body = [NSMutableDictionary dictionary];
     
    body[@"uiType"] = @"APP";
    body[@"pageType"] = @"userCenter_page";
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kMineShopContentUrl
                                                               requestMethod:YTKRequestMethodPOST
                                                       requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:NSDictionary.dictionary
                                                                 requestBody:body
                                                              needErrorToast:YES];
    
    return request;
}
//查询订单各状态下的订单数
- (SSGenaralRequest *)request5{
    NSMutableDictionary *header = [NSMutableDictionary dictionary];
 
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kMineOrderCount
                                                               requestMethod:YTKRequestMethodPOST
                                                       requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:header
                                                                 requestBody:NSMutableDictionary.dictionary
                                                              needErrorToast:YES];
    
    return request;
}

// MARK: 我的钱包
- (void)fetchMineWalletDataComplete:(void(^)(BOOL isSucess))complete {
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kMineWalletData
                                                               requestMethod:YTKRequestMethodGET
                                                       requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:NSDictionary.dictionary
                                                                 requestBody:NSDictionary.dictionary
                                                              needErrorToast:YES];
    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
            NSDictionary *data = request.responseModel.data;
            TSWalletModel *model = [TSWalletModel yy_modelWithDictionary:data];
            self.walletModel = model;
            complete(YES);
        } else {
            [Popover popToastOnWindowWithText:request.responseModel.responseMsg];
            complete(NO);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            complete(NO);
    }];
}

// MARK: 我的收益
- (void)fetchMyIncomeDataComplete:(void(^)(BOOL isSucess))complete {
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kMineQueryProfit
                                                               requestMethod:YTKRequestMethodGET
                                                       requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:NSDictionary.dictionary
                                                                 requestBody:NSDictionary.dictionary
                                                              needErrorToast:YES];
    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
            NSDictionary *data = request.responseModel.data;
            TSMyIncomeModel *model = [TSMyIncomeModel yy_modelWithDictionary:data];
            self.myIncomeModel = model;
            complete(YES);
        } else {
            [Popover popToastOnWindowWithText:request.responseModel.responseMsg];
            complete(NO);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            complete(NO);
    }];
}

// MARK: 提现申请
- (void)fetchWithdrawalApplicationDataComplete:(void(^)(BOOL isSucess))complete {
    NSMutableDictionary *body = [NSMutableDictionary dictionary];
    
    [body setValue:@([self.withdrawalAmount integerValue]) forKey:@"withdrawalAmount"];
    [body setValue:self.bankCardAccountId forKey:@"bankCardAccountId"];
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kMineWithdrawalApply
                                                               requestMethod:YTKRequestMethodPOST
                                                       requestSerializerType:YTKRequestSerializerTypeJSON responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:NSDictionary.dictionary
                                                                 requestBody:body
                                                              needErrorToast:YES];
    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
            NSDictionary *data = request.responseModel.data;
            TSMyIncomeModel *model = [TSMyIncomeModel yy_modelWithDictionary:data];
            self.myIncomeModel = model;
            complete(YES);
        } else {
            [Popover popToastOnWindowWithText:request.responseModel.responseMsg];
            complete(NO);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            complete(NO);
    }];
}

// MARK: 提现记录
- (void)fetchWithdrawalRecordDataComplete:(void(^)(BOOL isSucess))complete {
    NSMutableDictionary *body = [NSMutableDictionary dictionary];
    [body setValue:@(self.pageNo) forKey:@"pageNo"];
    if (self.status!=0)
        [body setValue:@(self.status) forKey:@"status"];
    if (self.requestMethod == Ordinary)
        [self.withdrawalRecordArray removeAllObjects];
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kMineWithdrawalRecordListData
                                                               requestMethod:YTKRequestMethodGET
                                                       requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:NSDictionary.dictionary
                                                                 requestBody:body
                                                              needErrorToast:YES];
    NSMutableArray *array = [NSMutableArray array];
    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
            NSArray *data = request.responseModel.data;
            [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                TSWithdrawalRecordModel *model = [TSWithdrawalRecordModel yy_modelWithDictionary:(NSDictionary *)obj];
                [array addObject:model];
            }];
            if (self.requestMethod == Refresh || self.requestMethod == Ordinary) {
                self.withdrawalRecordArray = array;
                
            } else {
                [self.withdrawalRecordArray addObjectsFromArray:array];
                if (array.count<10) self.pageNo = 1;
            }
            complete(YES);
        } else {
            [Popover popToastOnWindowWithText:request.responseModel.responseMsg];
            complete(NO);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        complete(NO);
    }];
}

// MARK: 查询银行卡列表
- (void)fetchQueryBankCardListDataComplete:(void(^)(BOOL isSucess))complete {
    NSMutableDictionary *header = [NSMutableDictionary dictionary];
    if ([TSGlobalManager shareInstance].currentUserInfo.accessToken.length > 0) {
        [header setValue:[TSGlobalManager shareInstance].currentUserInfo.refreshToken forKey:@"ec-token"];
    }else{
        [header setValue:@"" forKey:@"ec-token"];
    }
    NSMutableDictionary *body = [NSMutableDictionary dictionary];
    [body setValue:@(1) forKey:@"pageNo"];
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kMineQueryAppBankCardAccountList
                                                               requestMethod:YTKRequestMethodGET
                                                       requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:header
                                                                 requestBody:body
                                                              needErrorToast:YES];
    NSMutableArray *array = [NSMutableArray array];
    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
            NSArray *data = request.responseModel.data;
            [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                TSBankCardModel *model = [TSBankCardModel yy_modelWithDictionary:(NSDictionary *)obj];
                [array addObject:model];
            }];
            self.bankCardArray = array;
            complete(YES);
        } else {
            [Popover popToastOnWindowWithText:request.responseModel.responseMsg];
            complete(NO);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        complete(NO);
    }];
}

// MARK: 添加银行卡
- (void)fetchAddToBankCardDataComplete:(void(^)(BOOL isSucess))complete {
    NSMutableDictionary *body = [NSMutableDictionary dictionary];
    [body setValue:self.addBankCardModel.bankCardNo forKey:@"bankCardNo"];
    [body setValue:self.addBankCardModel.accountBank forKey:@"accountBank"];
    [body setValue:self.addBankCardModel.accountBankCode forKey:@"accountBankCode"];
    [body setValue:self.addBankCardModel.userName forKey:@"userName"];
    [body setValue:self.addBankCardModel.bankName forKey:@"bankName"];
    [body setValue:self.addBankCardModel.bankBranchId forKey:@"bankBranchId"];
    [body setValue:self.addBankCardModel.bankAddressProvince forKey:@"bankAddressProvince"];
    [body setValue:self.addBankCardModel.bankAddressProvinceCode forKey:@"bankAddressProvinceCode"];
    [body setValue:self.addBankCardModel.bankAddressCity forKey:@"bankAddressCity"];
    [body setValue:self.addBankCardModel.bankAddressCityCode forKey:@"bankAddressCityCode"];
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kMineAddBankCardAccount
                                                               requestMethod:YTKRequestMethodPOST
                                                       requestSerializerType:YTKRequestSerializerTypeJSON responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:NSDictionary.dictionary
                                                                 requestBody:body
                                                              needErrorToast:YES];
    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {

        if (request.responseModel.isSucceed) {
            NSDictionary *data = request.responseModel.data;
            complete(YES);
        } else {
            [Popover popToastOnWindowWithText:request.responseModel.responseMsg];
            complete(NO);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        complete(NO);
    }];
}

// MARK: 校验银行卡
- (void)fetchCheckBankCardDataComplete:(void(^)(BOOL isSucess))complete {
    NSMutableDictionary *body = [NSMutableDictionary dictionary];
    [body setValue:self.addBankCardModel.bankCardNo forKey:@"bankNo"];
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kMineBankNoCheck
                                                               requestMethod:YTKRequestMethodGET
                                                       requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:NSDictionary.dictionary
                                                                 requestBody:body
                                                              needErrorToast:YES];
    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
            NSDictionary *data = request.responseModel.data;
            TSAddBankCardBackModel *model = [TSAddBankCardBackModel yy_modelWithDictionary:data];
            self.addBankCardBackModel = model;
            complete(YES);
        } else {
            [Popover popToastOnWindowWithText:request.responseModel.responseMsg];
            complete(NO);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        complete(NO);
    }];
}

// MARK: 查询支行
- (void)fetchInquiryBranchDataComplete:(void(^)(BOOL isSucess))complete {
    NSMutableDictionary *body = [NSMutableDictionary dictionary];
    [body setValue:self.addBankCardModel.bankName forKey:@"bankFullName"];
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kMineGetBankInfo
                                                               requestMethod:YTKRequestMethodGET
                                                       requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:NSDictionary.dictionary
                                                                 requestBody:body
                                                              needErrorToast:YES];
    NSMutableArray *array = [NSMutableArray array];
    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
            NSArray *data = request.responseModel.data[@"bankInfo"][@"list"];
            [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                TSBranchCardModel *model = [TSBranchCardModel yy_modelWithDictionary:obj];
                [array addObject:model];
            }];
            self.branchCardArray = array;
            complete(YES);
        } else {
            [Popover popToastOnWindowWithText:request.responseModel.responseMsg];
            complete(NO);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        complete(NO);
    }];
}

// MARK: 删除银行卡
- (void)fetchDeleteBankCardDataComplete:(void(^)(BOOL isSucess))complete {
    NSMutableDictionary *body = [NSMutableDictionary dictionary];
    [body setValue:self.bankCardModel.bank_id forKey:@"id"];//银行卡id
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kMineDelBankCardAccount
                                                               requestMethod:YTKRequestMethodGET
                                                       requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:NSDictionary.dictionary
                                                                 requestBody:body
                                                              needErrorToast:YES];
    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
            NSDictionary *data = request.responseModel.data;
            TSAddBankCardBackModel *model = [TSAddBankCardBackModel yy_modelWithDictionary:data];
            self.addBankCardBackModel = model;
            complete(YES);
        } else {
            [Popover popToastOnWindowWithText:request.responseModel.responseMsg];
            complete(NO);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        complete(NO);
    }];
}

// MARK: 查询我的余额
- (void)fetchCheckMyBalanceDataComplete:(void(^)(BOOL isSucess))complete {
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kMineQueryAmount
                                                               requestMethod:YTKRequestMethodGET
                                                       requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:NSDictionary.dictionary
                                                                 requestBody:NSDictionary.dictionary
                                                              needErrorToast:YES];
    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
            NSString *data = request.responseModel.data;
            self.amount = data;
            complete(YES);
        } else {
            [Popover popToastOnWindowWithText:request.responseModel.responseMsg];
            complete(NO);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        complete(NO);
    }];
}

 // MARK: 查询银行列表
 - (void)fetchQueryBankDataComplete:(void(^)(BOOL isSucess))complete {
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kMineGetBankNames
                                                                requestMethod:YTKRequestMethodGET
                                                        requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                                requestHeader:NSDictionary.dictionary
                                                                  requestBody:NSDictionary.dictionary
                                                               needErrorToast:YES];
    NSMutableArray *array = [NSMutableArray array];
    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
             NSArray *data = request.responseModel.data;
             [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                 TSAddBankCardBackModel *model = [TSAddBankCardBackModel yy_modelWithDictionary:obj];
                 self.addBankCardBackModel = model;
                 [array addObject:model];
             }];
             self.addBankCardBackArray = array;
             complete(YES);
         } else {
             [Popover popToastOnWindowWithText:request.responseModel.responseMsg];
             complete(NO);
         }
     } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
         complete(NO);
     }];
}

// MARK: 获取全部省和直辖市
- (void)fetchGetAllProvinceDataComplete:(void(^)(BOOL isSucess))complete {
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kMineGetAllProvince
                                                                requestMethod:YTKRequestMethodGET
                                                        requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                                requestHeader:NSDictionary.dictionary
                                                                  requestBody:NSDictionary.dictionary
                                                               needErrorToast:YES];
    NSMutableArray *array = [NSMutableArray array];
    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
             NSArray *data = request.responseModel.data[@"provinceList"];
             [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                 TSProvinceListModel *model = [TSProvinceListModel yy_modelWithDictionary:obj];
                 [array addObject:model];
             }];
            NSArray<TSProvinceListModel *> *array1 = [self getOrderArraywithArray:array];
            self.provinceListArray = [array1 mutableCopy];
             complete(YES);
         } else {
             [Popover popToastOnWindowWithText:request.responseModel.responseMsg];
             complete(NO);
         }
     } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
         complete(NO);
     }];
}

// MARK: 根据省份uuid获取它下面的城市
- (void)fetchGetAllCityByProvinceUuidDataComplete:(void(^)(BOOL isSucess))complete {
    NSDictionary *body = [NSMutableDictionary dictionary];
    [body setValue:self.provinceListModel.uuid forKey:@"provinceUuid"];
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kMineGetAllCityByProvinceUuid
                                                                requestMethod:YTKRequestMethodGET
                                                        requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                                requestHeader:NSDictionary.dictionary
                                                                  requestBody:body
                                                               needErrorToast:YES];
    NSMutableArray *array = [NSMutableArray array];
    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
             NSArray *data = request.responseModel.data[@"cityList"];
             [data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                 TSProvinceListModel *model = [TSProvinceListModel yy_modelWithDictionary:obj];
                 [array addObject:model];
             }];
            NSArray<TSProvinceListModel *> *array1 = [self getOrderArraywithArray:array];
            self.provinceListArray = [array1 mutableCopy];
            complete(YES);
         } else {
             [Popover popToastOnWindowWithText:request.responseModel.responseMsg];
             complete(NO);
         }
     } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
         complete(NO);
     }];
}

- (NSArray<TSProvinceListModel *> *)getOrderArraywithArray:(NSArray<TSProvinceListModel*> *)array{
    NSArray<TSProvinceListModel *> *result = [array sortedArrayUsingComparator:^NSComparisonResult(TSProvinceListModel *  _Nonnull obj1, TSProvinceListModel *  _Nonnull obj2) {
        return [obj1.provinceName compare:obj2.provinceName]; //升序
    }];
    return result;
}

@end
