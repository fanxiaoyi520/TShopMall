//
//  TSMakeOrderDataController.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/16.
//

#import "TSMakeOrderDataController.h"
#import "TSAddressModel.h"

@interface TSMakeOrderDataController()
@end

@implementation TSMakeOrderDataController

- (instancetype)init{
    if (self == [super init]) {
        self.sections = [NSMutableArray array];
        [self configSections];
    }
    return self;
}

- (void)checkBalance:(void(^)(BOOL))finished{
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kToBalance
                                                                requestMethod:YTKRequestMethodGET
                                                        requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                                requestHeader:NSMutableDictionary.dictionary
                                                                 requestBody:@{@"noCart": @(!self.paramsISFromCart)}
                                                               needErrorToast:YES];
    request.animatingView = self.context.view;
    [request startWithCompletionBlockWithSuccess:^(__kindof SSGenaralRequest * _Nonnull request) {
        if (request.responseModel.isSucceed == YES) {
            NSDictionary *data = request.responseObject[@"data"];
            NSLog(@"%@", request.responseJSONObject);
            self.balanceModel = [TSBalanceModel yy_modelWithDictionary:data];
            if (self.balanceModel.cartManager.detailModelList.count == 0) {
                [self configEmptySection];
                return;
            }
            [self updateGoodsSection:self.balanceModel.cartManager.detailModelList];
            [self updatePriceSection];
            if ([self defaultAddress] != nil) {
                [self updateAddressSection:[self defaultAddress]];
            }
            finished(YES);
        } else{
            [self configEmptySection];
            finished(NO);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [self configEmptySection];
        finished(NO);
    }];
}


- (void)configSections{
    [self configAddressSection];
    [self configGoodsSection];
    [self configOperationSection];
    [self confitPriceSection];
}

- (void)updateAddressSection:(TSAddressModel *)address{
    TSMakeOrderSection *section = self.sections[0];
    TSMakeOrderRow *row = [section.rows lastObject];
    row.cellIdentifier = @"TSMakeOrderAddressCell";
    row.isAutoHeight = YES;
    row.obj = address;
}

- (void)updateGoodsSection:(NSArray<TSBalanceCartManagerDetailModel *> *)lists{
    TSMakeOrderSection *section = self.sections[1];
    NSMutableArray *rows = [NSMutableArray array];
    for (TSBalanceCartManagerDetailModel *detail in lists){
        TSMakeOrderGoodsViewModel *vm = [[TSMakeOrderGoodsViewModel alloc] initWithDetail:detail];
     
        TSMakeOrderRow *row = [TSMakeOrderRow new];
        row.cellIdentifier = @"TSMakeOrderGoodsCell";
        row.isAutoHeight = YES;
        row.obj = vm;
        [rows addObject:row];
    }
    
    section.rows = rows;
}

- (void)updateInvoiceSectionWithInvoice:(TSInvoiceModel *)invoice{
    TSMakeOrderSection *section = self.sections[2];
    TSMakeOrderRow *row = [section.rows lastObject];
    TSMakeOrderInvoiceViewModel *vm = (TSMakeOrderInvoiceViewModel *)row.obj;
    vm.invoice = invoice;
}

- (void)updateMessage:(NSString *)messgae{
    TSMakeOrderSection *section = self.sections[2];
    TSMakeOrderRow *row = [section.rows lastObject];
    TSMakeOrderInvoiceViewModel *vm = (TSMakeOrderInvoiceViewModel *)row.obj;
    vm.message = messgae;
}

- (void)updatePriceSection{
    TSMakeOrderSection *section = [self.sections lastObject];
    TSMakeOrderRow *row = [section.rows lastObject];
    TSMakeOrderPriceViewModel *vm = (TSMakeOrderPriceViewModel *)row.obj;
    vm.thPrice = self.balanceModel.orderTotalMoney;
    vm.deliveryPrice = self.balanceModel.allAffix;
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


- (void)configEmptySection{
    [self.sections removeAllObjects];
    
    TSMakeOrderRow *row = [TSMakeOrderRow new];
    row.cellIdentifier = @"TSMakeOrderEmptyCell";
    row.isAutoHeight = NO;
    row.rowHeight = KRateW(340.0);
    
    TSMakeOrderSection *section = [TSMakeOrderSection new];
    section.heightForHeader = 0.1f;
    section.heightForFooter = 0.1f;
    section.rows = @[row];
    
    [self.sections addObject:section];
}


- (TSAddressModel *)defaultAddress{
    TSAddressModel *address = nil;
    for(TSAddressModel *model in self.balanceModel.addressList){
        if(model.isDefault == YES){
            return model;
        }
    }
    return nil;
}
@end
