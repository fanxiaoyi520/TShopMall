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
@property (nonatomic, strong) TSWithdrawalRecordModel *withdrawalRecordModel;
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
            item.cellHeight = 75;
            item.identify = @"TSMineImageTextCell";
            
            [items addObject:item];
        }

        TSMineSectionModel *section = [[TSMineSectionModel alloc] init];
        section.hasHeader = YES;
        section.headerName = @"订单";
        section.headerSize = CGSizeMake(0, 45);
        section.headerIdentify = @"TSMineOrderHeaderView";
        section.hasFooter = YES;
        section.footerSize = CGSizeMake(0, 24);
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
        
        NSArray *titles = @[@"在线客服",@"发票管理",@"地址管理",@"官方服务",@"去评分"];
        NSArray *images = @[@"mall_mine_service",@"mall_mine_invoice_manager",@"mall_mine_address_manager",@"mall_mine_official",@"mall_mine_evaluate"];
        
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

    dispatch_group_enter(group);
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self requestMethodWithGroup:group withIndex:1];
    });

    dispatch_group_enter(group);
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self requestMethodWithGroup:group withIndex:2];
    });

    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        if (complete) {
            complete(YES);
        }
    });
}

- (void)requestMethodWithGroup:(dispatch_group_t)thegroup withIndex:(NSInteger)aIndex
{
    NSString *request = [NSString stringWithFormat:@"request%ld",aIndex];
    SEL requestSel = NSSelectorFromString(request);
    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
     [(SSGenaralRequest *)[self performSelector:requestSel] startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
         if (request.responseModel.isSucceed) {
             NSDictionary *data = request.responseModel.data;
             if (aIndex == 1) {
                 TSMineMerchantUserInformationModel *model = [TSMineMerchantUserInformationModel yy_modelWithDictionary:data];
                 self.merchantUserInformationModel = model;
             } else {
                 TSPartnerCenterData *model = [TSPartnerCenterData yy_modelWithDictionary:data];
                 self.partnerCenterDataModel = model;
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
    if ([TSGlobalManager shareInstance].currentUserInfo) {
        [header setValue:[TSGlobalManager shareInstance].currentUserInfo.accessToken forKey:@"accessToken"];
    }
    
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kMinePartnerCenterData
                                                               requestMethod:YTKRequestMethodPOST
                                                       requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:header
                                                                 requestBody:NSMutableDictionary.dictionary
                                                              needErrorToast:YES];
    
    return request;
}

// MARK: 我的钱包
- (void)fetchMineWalletDataComplete:(void(^)(BOOL isSucess))complete {
    NSMutableDictionary *header = [NSMutableDictionary dictionary];
    if ([TSGlobalManager shareInstance].currentUserInfo) {
        [header setValue:[TSGlobalManager shareInstance].currentUserInfo.accessToken forKey:@"ihome-token"];
    }
    [header setValue:@"application/json" forKey:@"Content-Type"];
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
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kMineWalletData
                                                               requestMethod:YTKRequestMethodGET
                                                       requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:header
                                                                 requestBody:body
                                                              needErrorToast:YES];
    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
            NSDictionary *data = request.responseModel.data;
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (complete) {
            complete(YES);
        }
    }];
}

// MARK: 提现记录
- (void)fetchWithdrawalRecordDataComplete:(void(^)(BOOL isSucess))complete {
    NSMutableDictionary *header = [NSMutableDictionary dictionary];
//    if ([TSGlobalManager shareInstance].currentUserInfo) {
//        [header setValue:[TSGlobalManager shareInstance].currentUserInfo.accessToken forKey:@"ihome-token"];
//    }
    [header setValue:@"111" forKey:@"ihome-token"];
    NSMutableDictionary *body = [NSMutableDictionary dictionary];
    [body setValue:@(1) forKey:@"pageNo"];
    [body setValue:@(1) forKey:@"status"];
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kMineWithdrawalRecordListData
                                                               requestMethod:YTKRequestMethodGET
                                                       requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:header
                                                                 requestBody:body
                                                              needErrorToast:YES];
    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
            NSDictionary *data = request.responseModel.data;
        }
        if (complete) {
            complete(YES);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (complete) {
            complete(YES);
        }
    }];
}

@end
