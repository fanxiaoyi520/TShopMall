//
//  TSCartViewController.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/3.
//

#import "TSCartViewController.h"
#import "TSCartView.h"
#import "TSCartDataController.h"
#import "TSCartSettleView.h"
#import "TSCartProtocol.h"
#import "TSAlertView.h"

@interface TSCartViewController ()<TSCartProtocol>
@property (nonatomic, strong) UIButton *editBtn;
@property (nonatomic, strong) TSCartView *cartView;
@property (nonatomic, strong) TSCartSettleView *settleView;
@end

@implementation TSCartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"购物车";
    if (@available(iOS 11.0, *)) {
        
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self configInfo];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.editBtn];
}

- (void)configInfo{
    [TSCartDataController getInfoFinished:^(TSCartModel *cartModel, NSError *error) {
        if (error) {
            
            return ;
        }
        self.cartView.sections = [TSCartViewModel congfigViewModelWithCartInfo:cartModel].sections;
    }];
}

//失效区清空按钮事件
- (void)clearInvalideGoods{
    TSAlertView.new.alertInfo(@"提示", @"您确定要清空失效商品吗?").confirm(@"确定", ^{
        
    }).cancel(@"取消", ^{}).show();
}

- (void)goToSettle{
    if (self.editBtn.selected == YES) {//编辑
        [self batchDelete];
        
    } else {
        
    }
}

//商品选中状态变更
- (void)goodsSelectedStatusChanged{
    [self updateSettleView];
}

//全选
- (void)allSelected:(BOOL)status{
    for (TSCartGoodsSection *section in self.cartView.sections) {
        TSCartGoodsRow *row = section.rows.lastObject;
        if ([row.cellIdentifier isEqualToString:@"TSCartCell"]) {
            [row.obj setValue:@(status) forKey:@"isSelected"];
        }
    }
    [self updateSettleView];
}

- (void)updateSettleView{
    NSArray<TSCart *> *cartModels = [TSCartViewModel canOperationGoodsInSections:self.cartView.sections];
    [self.settleView updateSelBtnStatus:[TSCartViewModel isAllGoodsSelected:cartModels]];
    NSArray<TSCart *> *selCarts = [TSCartViewModel selectedInfo:cartModels];
    NSString *totalPrice = [TSCartViewModel totalPrice:selCarts];
    [self.settleView updateSettleBtnText:selCarts.count];
    [self.settleView updatePrice:totalPrice];
}

- (void)edit:(UIButton *)sender{
    sender.selected = !sender.selected;
    [self.settleView updateSettleViewStates:sender.selected];
}

//删除商品(侧滑删除)
- (void)scrollDeleteCart:(TSCart *)cart indexPath:(NSIndexPath *)indexPath{
    NSMutableArray *sections = [NSMutableArray arrayWithArray:self.cartView.sections];
    [sections removeObjectAtIndex:indexPath.section];
    self.cartView.sections = sections;
    if (cart.isSelected == YES) {
        [self updateSettleView];
    }
}

- (void)batchDelete{
    NSArray<TSCart *> *cartModels = [TSCartViewModel canOperationGoodsInSections:self.cartView.sections];
    NSArray<TSCart *> *carts = [TSCartViewModel selectedInfo:cartModels];
    if (carts.count != 0) {
        TSAlertView.new.alertInfo(nil, @"确认删除选中商品吗？").confirm(@"确定", ^{
            NSMutableArray *sections = [NSMutableArray arrayWithArray:self.cartView.sections];
            NSMutableArray *selSections = [NSMutableArray array];
            for (TSCartGoodsSection *section in self.cartView.sections) {
                TSCartGoodsRow *row = [section.rows lastObject];
                if ([row.obj isKindOfClass:[TSCart class]]) {
                    TSCart *cart = (TSCart *)row.obj;
                    if (cart.isSelected == YES) {
                        [sections removeObject:section];
                    }
                }
            }
            self.cartView.sections = selSections;
        }).cancel(@"取消", ^{}).show();
    }
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
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.settleView.mas_top);
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
    self.cartView = [TSCartView new];
    self.cartView.controller = self;
    [self.view addSubview:self.cartView];
    
    return self.cartView;
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

- (BOOL)isRootControllerInNivagationController{
    if (self.navigationController.viewControllers.count == 1) {
        return YES;
    }
    return NO;
}

@end
