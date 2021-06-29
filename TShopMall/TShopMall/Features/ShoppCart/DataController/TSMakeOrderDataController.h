//
//  TSMakeOrderDataController.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/16.
//

#import "TSBaseDataController.h"
#import "TSMakeOrderSection.h"
#import "TSBalanceModel.h"
#import "TSMakeOrderGoodsViewModel.h"
#import "TSMakeOrderPriceViewModel.h"
#import "TSMakeOrderInvoiceViewModel.h"
#import "TSInvoiceModel.h"

@interface TSMakeOrderDataController : TSBaseDataController
@property (nonatomic, strong) TSBalanceModel *balanceModel;
@property (nonatomic, assign) BOOL paramsISFromCart;//YES-从购物车过来的，NO-非购物车过来的
@property (nonatomic, strong) NSMutableArray<TSMakeOrderSection *> *sections;

- (void)checkBalance:(void(^)(BOOL))finished;

- (void)updateAddressSection:(TSAddressModel *)address;
- (void)updateInvoiceSectionWithInvoice:(TSInvoiceModel *)invoice;
- (void)updateMessage:(NSString *)messgae;
- (void)configEmptySection;
@end

