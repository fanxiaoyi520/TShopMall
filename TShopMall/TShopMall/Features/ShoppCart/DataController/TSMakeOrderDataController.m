//
//  TSMakeOrderDataController.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/16.
//

#import "TSMakeOrderDataController.h"
#import "TSAddressModel.h"

@interface TSMakeOrderDataController()
@property (nonatomic, copy) void(^finished)(BOOL);
@end

@implementation TSMakeOrderDataController

- (instancetype)init{
    if (self == [super init]) {
        self.sections = [NSMutableArray array];
    }
    return self;
}

- (void)checkBalance:(void(^)(BOOL))finished{
    self.finished = finished;
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kToBalance
                                                                requestMethod:YTKRequestMethodGET
                                                        requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                                requestHeader:NSMutableDictionary.dictionary
                                                                 requestBody:@{}
                                                               needErrorToast:YES];
    request.animatingView = self.context.view;
    [request startWithCompletionBlockWithSuccess:^(__kindof SSGenaralRequest * _Nonnull request) {
        if (request.responseModel.isSucceed == YES) {
            NSDictionary *data = request.responseObject[@"data"];
            NSLog(@"%@", request.responseJSONObject);
            self.balanceModel = [TSBalanceModel yy_modelWithDictionary:data];
            self.finished = finished;
            [self configSections];
        } else{
            finished(NO);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        finished(NO);
    }];
}


- (void)configSections{
    [self configAddressSection];
    [self configGoodsSection];
    [self configOperationSection];
    [self confitPriceSection];
    
    self.finished(YES);
}

- (void)updateAddressSection:(TSAddressModel *)address{
    TSMakeOrderSection *section = self.sections[0];
    TSMakeOrderRow *row = [section.rows lastObject];
    row.cellIdentifier = @"TSMakeOrderAddressCell";
    row.isAutoHeight = YES;
    row.obj = address;
}

- (void)updateMessage:(NSString *)messgae{
    TSMakeOrderSection *section = self.sections[2];
    TSMakeOrderRow *row = [section.rows lastObject];
    TSMakeOrderInvoiceViewModel *vm = (TSMakeOrderInvoiceViewModel *)row.obj;
    vm.message = messgae;
}

- (void)configAddressSection{
    TSAddressModel *address = nil;
    for(TSAddressModel *model in self.balanceModel.addressList){
        if(model.isDefault == YES){
            address = model;
            break;
        }
    }
    
    TSMakeOrderRow *row = [TSMakeOrderRow new];
    if (address != nil) {
        row.cellIdentifier = @"TSMakeOrderAddressCell";
        row.isAutoHeight = YES;
        row.obj = address;
    } else {
        row.cellIdentifier = @"TSMakeOrderAddressTipsCell";
        row.isAutoHeight = NO;
        row.rowHeight = KRateW(56.0);
    }
    
    TSMakeOrderSection *section = [TSMakeOrderSection new];
    section.heightForHeader = 0.1f;
    section.heightForFooter = KRateW(10.0);
    section.rows = @[row];
    
    [self.sections addObject:section];
}

- (void)configGoodsSection{
    
    NSMutableArray *rows = [NSMutableArray array];
    for (TSBalanceCartManagerDetailModel *detail in self.balanceModel.cartManager.detailModelList){
        TSMakeOrderGoodsViewModel *vm = [[TSMakeOrderGoodsViewModel alloc] initWithDetail:detail];
     
        TSMakeOrderRow *row = [TSMakeOrderRow new];
        row.cellIdentifier = @"TSMakeOrderGoodsCell";
        row.isAutoHeight = YES;
        row.obj = vm;
        [rows addObject:row];
    }

    TSMakeOrderSection *section = [TSMakeOrderSection new];
    section.heightForHeader = 0.1f;
    section.heightForFooter = KRateW(10.0);
    section.rows = rows;
    
    [self.sections addObject:section];
}

- (void)configOperationSection{
    TSMakeOrderInvoiceViewModel *vm = [TSMakeOrderInvoiceViewModel new];
    
    TSMakeOrderRow *row = [TSMakeOrderRow new];
    row.cellIdentifier = @"TSMakeOrderOperationCell";
    row.isAutoHeight = NO;
    row.rowHeight = KRateW(168.0);
    row.obj = vm;
    
    TSMakeOrderSection *section = [TSMakeOrderSection new];
    section.heightForHeader = 0.1f;
    section.heightForFooter = KRateW(10.0);
    section.rows = @[row];
    
    [self.sections addObject:section];
}

- (void)confitPriceSection{
    TSMakeOrderPriceViewModel *vm = [TSMakeOrderPriceViewModel new];
    vm.thPrice = self.balanceModel.orderTotalMoney;
    vm.deliveryPrice = self.balanceModel.allAffix;
    
    TSMakeOrderRow *row = [TSMakeOrderRow new];
    row.cellIdentifier = @"TSMakeOrderPriceCell";
    row.isAutoHeight = NO;
    row.rowHeight = KRateW(82.0);
    row.obj = vm;
    
    TSMakeOrderSection *section = [TSMakeOrderSection new];
    section.heightForHeader = 0.1f;
    section.heightForFooter = KRateW(10.0);
    section.rows = @[row];
    
    [self.sections addObject:section];
}

@end
