//
//  TSCartViewController.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/3.
//

#import "TSCartViewController.h"
#import "TSCartView.h"
#import "TSCartDataController.h"
#import "TSCartOperationDataController.h"
#import "TSCartSettleView.h"
#import "TSCartProtocol.h"
#import "TSAlertView.h"
#import "TSMakeOrderController.h"
#import "TSRecomendDataController.h"
#import "TSHybridViewController.h"
#import "TSProductDetailController.h"
#import "AppDelegate.h"
#import "TSBaseNavigationController.h"
#import "TSMainViewController.h"

@interface TSCartViewController ()<TSCartProtocol>
@property (nonatomic, strong) UIButton *editBtn;
@property (nonatomic, strong) TSCartView *cartView;
@property (nonatomic, strong) TSCartSettleView *settleView;
@property (nonatomic, strong) TSCartDataController *dataCon;
@property (nonatomic, strong) RefreshGifHeader *refreshHeader;
@end

@implementation TSCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.gk_navTitle = @"购物车";
    if (@available(iOS 11.0, *)) {
        self.cartView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.gk_navRightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.editBtn];
    [self configInfo];
}


#pragma mark - Noti
- (void)loginStateDidChanged:(NSNotification *)noti{
   
}

- (void)configInfo{
    __weak typeof(self) weakSelf = self;
    [self.dataCon viewCart:^{
        [weakSelf endRefresh];
        weakSelf.cartView.sections = weakSelf.dataCon.sections;
        [weakSelf updateSettleView];
        [weakSelf configRecomendView];
        weakSelf.editBtn.hidden  = weakSelf.dataCon.cartModel.carts.count==0? YES:NO;
    }];
}

- (void)configRecomendView{
    [TSRecomendDataController checkCurrentRecomendPage:RecomendCartPage finished:^(TSRecomendModel *recomendInfo, TSRecomendPageInfo *pageInfo) {
        if (recomendInfo.goodsList.count != 0) {
            [self.dataCon configRecomendSectons:recomendInfo.goodsList isGrid:YES];
            self.cartView.sections = self.dataCon.sections;
        }
    }];
}

- (void)edit:(UIButton *)sender{
    sender.selected = !sender.selected;
    
    [self.settleView updateSettleViewStates:sender.selected];
}

//失效区清空按钮事件
- (void)clearInvalideGoods{
    TSAlertView.new.alertInfo(@"提示", @"您确定要清空失效商品吗?").confirm(@"确定", ^{
        
    }).cancel(@"取消", ^{}).show();
}

- (void)goToSettle{
    if (self.editBtn.selected == YES) {//编辑
        NSArray *carts = [self.dataCon selectedGoods];
        TSAlertView.new.alertInfo(nil, @"确认删除选中商品吗？").confirm(@"确定", ^{
            [self deleteSelectedCarts:carts];
        }).cancel(@"取消", ^{}).show();
    } else {
        TSMakeOrderController *con  = [TSMakeOrderController new];
        con.isFromCart = YES;
        [self.navigationController pushViewController:con animated:YES];
    }
}

//改变选中状态
- (void)goodsSelected:(TSCart *)cart indexPath:(NSIndexPath *)indexPath{
    [TSCartOperationDataController updateGoodsChooseStatus:cart status:cart.checked finished:^{
        [self configInfo];
    }];
}

//修改数量
- (void)changeGoodsBuyNumberOfCart:(TSCart *)cart{
    [TSCartOperationDataController updateGoodsNumber:cart finished:^{
        [self configInfo];
    }];
}

//全选
- (void)allSelected:(BOOL)status{
    [TSCartOperationDataController updateGoodsChooseStatus:nil status:status finished:^{
        [self configInfo];
    }];
}

- (void)checkGift:(TSCart *)cart{}

///删除商品(侧滑删除)
- (void)scrollDeleteCart:(TSCart *)cart{
    [TSCartOperationDataController deleteCarts:@[cart] finished:^{
        [self configInfo];
    }];
}

- (void)deleteSelectedCarts:(NSArray<TSCart *> *)carts{
    [TSCartOperationDataController deleteCarts:carts finished:^{
        [self configInfo];
    }];
}

//去购物
- (void)goToShopping{
    UIViewController *con = [NSClassFromString(@"TSAddressEditController") new];
    [self.navigationController pushViewController:con animated:YES];
    return;
    self.tabBarController.selectedIndex = 0;
}

- (void)recomendGoodsSelected:(NSString *)uuid{
    TSProductDetailController *detail = [[TSProductDetailController alloc] init];
    detail.uuid = uuid;
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)updateSettleView{
    self.settleView.hidden = self.dataCon.validCarts.count==0? YES:NO;
    [self.settleView updateSelBtnStatus:self.dataCon.isAllSelected];
    [self.settleView updatePrice:self.dataCon.cartModel.cartsTotalMount];
    [self.settleView updateSettleBtnText:self.dataCon.selectedCount];
}

- (void)viewWillLayoutSubviews{
    CGFloat tabbarHeight = 49.0;
    if ([self isRootControllerInNivagationController] == NO) {
        tabbarHeight = 0;
    }
    [self.settleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(KRateW(56.0));
        make.bottom.equalTo(self.view.mas_bottom).offset(-self.view.bottomSafeAreaHeight - tabbarHeight);
    }];
    
    [self.cartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(GK_SAFEAREA_TOP + GK_NAVBAR_HEIGHT);
        make.bottom.equalTo(self.settleView.mas_bottom);
    }];
}

- (UIButton *)editBtn{
    if (_editBtn) {
        return _editBtn;
    }
    self.editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.editBtn.titleLabel.font = [UIFont font:PingFangSCRegular size:KRateW(16.0)];
    [self.editBtn setTitle:@"编辑" forState:UIControlStateNormal];
    [self.editBtn setTitleColor:KHexColor(@"#2D3132") forState:UIControlStateNormal];
    self.editBtn.frame = CGRectMake(0, 0, KRateW(32.0), KRateW(24.0));
    [self.editBtn addTarget:self action:@selector(edit:) forControlEvents:UIControlEventTouchUpInside];
    
    return self.editBtn;
}

- (TSCartView *)cartView{
    if (_cartView) {
        return _cartView;
    }
    self.cartView = [[TSCartView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.cartView.controller = self;
    [self.view addSubview:self.cartView];
    
    [self addMJHeaderAndFooter];
    
    return self.cartView;
}

- (void)addMJHeaderAndFooter {
    //默认【下拉刷新】
    RefreshGifHeader *header = [RefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(mjHeadreRefresh:)];
    self.cartView.mj_header = header;
    self.refreshHeader = header;
}

- (void)mjHeadreRefresh:(RefreshGifHeader *)mj_header {
    [self configInfo];
}

- (void)endRefresh{
    [self.refreshHeader endRefreshing];
}

- (TSCartSettleView *)settleView{
    if (_settleView) {
        return _settleView;
    }
    self.settleView = [TSCartSettleView new];
    self.settleView.delegate = self;
    [self.view addSubview:self.settleView];
    
    return self.settleView;
}

- (TSCartDataController *)dataCon{
    if (_dataCon) {
        return _dataCon;
    }
    self.dataCon = [TSCartDataController new];
    self.dataCon.context = self;
    
    return self.dataCon;
}

- (BOOL)isRootControllerInNivagationController{
    if (self.navigationController.viewControllers.count == 1) {
        return YES;
    }
    return NO;
}

@end
