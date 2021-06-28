//
//  TSCartDataController.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/9.
//

#import "TSCartDataController.h"

@interface TSCartDataController ()

@end

@implementation TSCartDataController

+ (void)checkCartNumber:(void (^)(NSInteger))finished{
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kCartCount
                                                               requestMethod:YTKRequestMethodPOST
                                                       requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:NSMutableDictionary.dictionary
                                                                 requestBody:@{}
                                                              needErrorToast:NO];
    [request startWithCompletionBlockWithSuccess:^(__kindof SSGenaralRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
            NSInteger num = [request.responseObject[@"data"] integerValue];
            finished(num);
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
    }];
}

- (void)viewCart:(void(^)(void))finished{
    __weak typeof(self) weakSelf = self;
    [self.sections removeAllObjects];
    SSBaseRequest *res = [self cartShowRequest];
    res.animatingView = self.context.view;
    [res startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
            NSDictionary *data = request.responseJSONObject[@"data"];
            [weakSelf handleRes:data];
        } else {
            [weakSelf configEmptyView];
        }
        finished();
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        [weakSelf configEmptyView];
        finished();
    }];
}

- (SSGenaralRequest *)cartShowRequest{
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kCartShow
                                                               requestMethod:YTKRequestMethodGET
                                                       requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:NSMutableDictionary.dictionary
                                                                 requestBody:@{}
                                                              needErrorToast:NO];
    return request;
}

- (void)handleRes:(NSDictionary *)data{
    self.cartModel = [TSCartModel yy_modelWithDictionary:data];
    [self handleCarts];
    if (self.validCarts.count == 0) {
        [self configEmptyView];
    } else {
        [self configGoodsView:self.validCarts];
        [self configInvalidGoods:self.invalidCarts];
    }
}

- (void)handleCarts{
    NSMutableArray *validCarts = [NSMutableArray array];
    NSMutableArray *invalidCarts = [NSMutableArray array];
    for (TSCart *cart in self.cartModel.carts) {
        if (cart.isInvalid == NO) {
            [validCarts addObject:cart];
        } else {
            [invalidCarts addObject:cart];
        }
    }
    self.validCarts = validCarts;
    self.invalidCarts = invalidCarts;
}


- (void)configGoodsView:(NSArray<TSCart *> *)goods{
    if (goods.count == 0) {
        return;
    }
    NSMutableArray *sections = [NSMutableArray array];
    for (TSCart *good in goods) {
        TSCartGoodsRow *row = [TSCartGoodsRow new];
        row.cellIdentifier = @"TSCartCell";
        row.obj = good;
        row.canScrollEdit = YES;
        
        TSCartGoodsSection *section = [TSCartGoodsSection new];
        section.heightForFooter = KRateW(10.0);
        section.rows = @[row];
        [sections addObject:section];
    }
    
    self.sections = sections;
}

- (void)configEmptyView{
    TSCartGoodsRow *row = [TSCartGoodsRow new];
    row.cellIdentifier = @"TSCartEmptyCell";
    row.isAutoHeight = NO;
    row.rowHeight = KRateW(406.0);
    
    TSCartGoodsSection *section = [TSCartGoodsSection new];
    section.heightForHeader = 0.1f;
    section.heightForFooter = 0.1f;
    section.rows = @[row];
    
    [self.sections addObject:section];
}

- (void)configInvalidGoods:(NSArray<TSCart *> *)carts{
    if (carts.count == 0) {
        return;
    }
    NSMutableArray *invalidRow = [NSMutableArray array];
    for (TSCart *cart in carts) {
        TSCartGoodsRow *row = [TSCartGoodsRow new];
        row.cellIdentifier = cart.suitMain.length==0? @"TSCartInvalidCell":@"TSCartInvalidTaoCanCell";
        row.obj = cart;
        [invalidRow addObject:row];
    }
    TSCartGoodsSection *section = [TSCartGoodsSection new];
    section.heightForHeader = KRateW(54.0);
    section.headerIdentifier = @"TSCartInvalidHeader";
    //    section.heightForFooter = KRateW(10.0);
    section.rows = invalidRow;
    
    [self.sections addObject:section];
}

- (void)configRecomendSectons:(NSArray<TSRecomendGoods *> *)goods isGrid:(BOOL)isGrid{
    NSMutableArray *rows = [NSMutableArray array];
    NSInteger a = goods.count;
    if (isGrid) {
        a= goods.count/2 + goods.count%2;
    }
    for (NSInteger i=0; i<a; i++) {
        id obj;
        if (isGrid) {
            NSMutableArray *arr = [NSMutableArray array];
            [arr addObject:goods[2*i]];
            if (2*i+1 <= a - 1) {
                [arr addObject:goods[2*i+1]];
            }
            obj = arr;
        } else {
            obj = goods[i];
        }
        TSCartGoodsRow *row = [TSCartGoodsRow new];
        row.cellIdentifier = isGrid==NO? @"TSCartRecomendCell":@"TSCartRecomendGirdCell";
        row.obj = obj;
        row.isAutoHeight = NO;
        row.rowHeight = isGrid==NO? KRateW(120.0):KRateW(290.0);
        [rows addObject:row];
    }
    
    TSCartGoodsSection *section = [TSCartGoodsSection new];
    section.heightForHeader = KRateW(54.0);
    section.headerIdentifier = @"TSCartRecomendHeader";
    section.heightForFooter = KRateW(32.0);
    section.rows = rows;
    [self.sections addObject:section];
}

- (NSMutableArray<TSCartGoodsSection *> *)sections{
    if (_sections) {
        return _sections;
    }
    self.sections = [NSMutableArray array];
    
    return self.sections;
}

- (BOOL)isAllSelected{
    if (self.cartModel.carts.count == 0) {
        return NO;
    }
    NSString *isContainNo = @"0";
    for (TSCart *cart in self.cartModel.carts) {
        if (cart.checked == NO) {
            isContainNo = @"1";
            break;
        }
    }
    if ([isContainNo isEqualToString:@"1"]) {
        return NO;
    }
    return YES;
}

- (NSInteger)selectedCount{
    NSInteger count = 0;
    for (TSCart *cart in self.cartModel.carts) {
        if (cart.checked == YES) {
            count += cart.buyNum;
        }
    }
    return count;
}

- (NSArray<TSCart *> *)selectedGoods{
    NSMutableArray *arr = [NSMutableArray array];
    for (TSCart *cart in self.cartModel.carts) {
        if (cart.checked == YES) {
            [arr addObject:cart];
        }
    }
    return arr;
}

@end
