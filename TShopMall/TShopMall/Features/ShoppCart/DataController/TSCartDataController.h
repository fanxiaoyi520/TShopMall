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
#import "TSRecomendModel.h"

@interface TSCartDataController : TSBaseDataController
@property (nonatomic, strong) TSCartModel *cartModel;
@property (nonatomic, assign, readonly) BOOL isAllSelected;//是否是全选中状态
@property (nonatomic, assign, readonly) NSInteger selectedCount;
@property (nonatomic, strong) NSMutableArray<TSCartGoodsSection *> *sections;

@property (nonatomic, strong) NSArray<TSCart *> *validCarts;
@property (nonatomic, strong) NSArray<TSCart *> *invalidCarts;

///查看购物差
- (void)viewCart:(void(^)(void))finished;

- (NSArray<TSCart *> *)selectedGoods;
- (NSArray<TSCart *> *)invalidGoods;

///配置推荐商品
- (void)configRecomendSectons:(NSArray<TSRecomendGoods *> *)goods isGrid:(BOOL)isGrid;

//检查购物车数量
+ (void)checkCartNumber:(void(^)(NSInteger))finished;
@end

