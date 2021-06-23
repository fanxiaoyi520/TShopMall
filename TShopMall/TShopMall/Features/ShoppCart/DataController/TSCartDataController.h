//
//  TSCartDataController.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/9.
//

#import "TSBaseDataController.h"
#import "TSCartModel.h"

#import "TSCartViewModel.h"
#import "TSCartGoodsSection.h"

@interface TSCartDataController : TSBaseDataController
@property (nonatomic, strong) TSCartModel *cartModel;
@property (nonatomic, assign, readonly) BOOL isAllSelected;//是否是全选中状态
@property (nonatomic, assign, readonly) NSInteger selectedCount;
@property (nonatomic, strong) NSMutableArray<TSCartGoodsSection *> *sections;

@property (nonatomic, strong) NSArray<TSCart *> *validCarts;
@property (nonatomic, strong) NSArray<TSCart *> *invalidCarts;

- (void)viewCart:(void(^)(void))finished;

- (NSArray<TSCart *> *)selectedGoods;


+ (void)checkCartNumber:(void(^)(NSInteger))finished;
@end

