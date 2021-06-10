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

}

//商品选中状态变更
- (void)goodsSelectedStatusChanged{
    
    NSArray<TSCart *> *cartModels = [TSCartViewModel canOperationGoodsInSections:self.cartView.sections];
    [self.settleView updateSelBtnStatus:[TSCartViewModel isAllGoodsSelected:cartModels]];
}

- (void)allSelected:(BOOL)status{
    for (TSCartGoodsSection *section in self.cartView.sections) {
        TSCartGoodsRow *row = section.rows.lastObject;
        if ([row.cellIdentifier isEqualToString:@"TSCartCell"]) {
            [row.obj setValue:@(status) forKey:@"isSelected"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"CartCellShouldUpdateSelectedStatus" object:nil userInfo:@{@"obj":row.obj}];
        }
    }
}

- (void)edit:(UIButton *)sender{
    sender.selected = !sender.selected;
    [self.settleView updateSettleViewStates:sender.selected];
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
        make.top.equalTo(self.view.mas_top).offset(self.view.statusBarHight + KNaviBarHeight);
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
