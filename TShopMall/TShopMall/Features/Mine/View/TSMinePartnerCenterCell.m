//
//  TSMinePartnerCenterCell.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/11.
//

#import "TSMinePartnerCenterCell.h"
#import "TSMineMoreButton.h"
#import "TSPartnerCenterData.h"

@interface TSMinePartnerCenterCellItem : UIView
@property(nonatomic, strong) UILabel *title;
@property(nonatomic, strong) UILabel *detailL;
@end

@implementation TSMinePartnerCenterCellItem


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.title];
        [self addSubview:self.detailL];
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.equalTo(self.mas_centerY).offset(2);
        }];
        
        [self.detailL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self.mas_centerY).offset(-2);
        }];
    }
    return self;
}


-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.font = KFont(PingFangSCRegular, 12);
        _title.textAlignment = NSTextAlignmentCenter;
        _title.textColor = KHexColor(@"#666666");
        _title.text = @"自身贡献收入";
    }
    return _title;
}

-(UILabel *)detailL{
    if (!_detailL) {
        _detailL = [[UILabel alloc] init];
        _detailL.font = KFont(PingFangSCMedium, 18);
        _detailL.textAlignment = NSTextAlignmentCenter;
        _detailL.textColor = KHexColor(@"#FF6460");
        _detailL.text = @"¥2380";
    }
    return _detailL;
}
@end

@interface TSMinePartnerCenterCell()

/// 标题
@property(nonatomic, strong) UILabel *titleLabel;
/// 查看收益
@property(nonatomic, strong) UIButton *eyeButton;
/// 查看更多
@property(nonatomic, strong) TSMineMoreButton *moreButton;
/// 分割线
@property(nonatomic, strong) UIView *seperateView;

//累计订单
@property(nonatomic, strong) TSMinePartnerCenterCellItem *orderItem;

@property(nonatomic, strong) TSMinePartnerCenterCellItem *moneyItem;

@property(nonatomic, strong) TSMinePartnerCenterCellItem *contributeItem;

@property(nonatomic, strong) TSMinePartnerCenterCellItem *partnerItem;

@property(nonatomic, strong) UIStackView *topStackView;
@property(nonatomic, strong) UIStackView *bottomStackView;
@end

@implementation TSMinePartnerCenterCell

-(void)fillCustomContentView{

    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.moreButton];
    [self.contentView addSubview:self.eyeButton];
    [self.contentView addSubview:self.seperateView];
    [self.contentView addSubview:self.topStackView];
    [self.contentView addSubview:self.bottomStackView];
    
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.top.equalTo(self.contentView).offset(17);
        make.height.mas_equalTo(24);
        make.width.mas_equalTo(80);
    }];
    
    [self.eyeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(6);
        make.centerY.equalTo(self.titleLabel);
        make.width.height.mas_equalTo(30);
    }];
    
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-20);
        make.centerY.equalTo(self.titleLabel);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(80);
    }];

    [self.seperateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.right.equalTo(self.contentView.mas_right).offset(-16);
        make.height.mas_equalTo(0.5);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(7);
    }];
    
    [self.topStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.seperateView.mas_bottom);
        make.right.left.equalTo(self.contentView);
        make.height.mas_equalTo(67);
    }];
    
    [self.bottomStackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topStackView.mas_bottom);
        make.right.left.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(0);
    }];

   
}

- (void)setDelegate:(id<UniversalCollectionViewCellDataDelegate>)delegate {
    [super setDelegate:delegate];
    TSPartnerCenterData *model = [delegate universalCollectionViewCellModel:self.indexPath];
    if (model.eyeIsOn) {
        _orderItem.detailL.text = [NSString stringWithFormat:@"¥%@",model.orderNum];
        _moneyItem.detailL.text = [NSString stringWithFormat:@"¥%@",model.orderMoney];
        _contributeItem.detailL.text = [NSString stringWithFormat:@"¥%@",model.profitFromMyself];
        _partnerItem.detailL.text = [NSString stringWithFormat:@"¥%@",model.profitFromPartner];
        _orderItem.detailL.textColor = KHexColor(@"#FF6460");
        _moneyItem.detailL.textColor = KHexColor(@"#FF6460");
        _contributeItem.detailL.textColor = KHexColor(@"#FF6460");
        _partnerItem.detailL.textColor = KHexColor(@"#FF6460");
    } else {
        _orderItem.detailL.text = @"****";
        _moneyItem.detailL.text = @"****";
        _contributeItem.detailL.text = @"****";
        _partnerItem.detailL.text = @"****";
        _orderItem.detailL.textColor = KHexColor(@"#333333");
        _moneyItem.detailL.textColor = KHexColor(@"#333333");
        _contributeItem.detailL.textColor = KHexColor(@"#333333");
        _partnerItem.detailL.textColor = KHexColor(@"#333333");
    }
    
    [self.topStackView.arrangedSubviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    [self.bottomStackView.arrangedSubviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj removeFromSuperview];
    }];
    if ([model.salesmanRankLevel isEqualToString: @"1"]) {
        
        [self.topStackView addArrangedSubview:self.orderItem];
        [self.topStackView addArrangedSubview:self.contributeItem];
        [self.bottomStackView addArrangedSubview:self.moneyItem];
        [self.bottomStackView addArrangedSubview:self.partnerItem];
        self.bottomStackView.hidden = NO;
        [self.bottomStackView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(67);
        }];
    } else {
        [self.topStackView addArrangedSubview:self.orderItem];
        [self.topStackView addArrangedSubview:self.contributeItem];
        [self.topStackView addArrangedSubview:self.moneyItem];
        self.bottomStackView.hidden = YES;
        [self.bottomStackView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }
}

#pragma mark - Actions
-(void)moreAction:(TSMineMoreButton *)sender{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"TSMinePartnerCenterCell" forKey:@"cellType"];
    [params setValue:@(MoreAction) forKey:@"clickType"];
    if (self.delegate && [self.delegate respondsToSelector:@selector(universalCollectionViewCellClick:params:)]) {
        [self.delegate universalCollectionViewCellClick:self.indexPath params:params];
    }
}

-(void)eyeAction:(UIButton *)sender{
    if (sender.selected) {
        _orderItem.detailL.text = @"****";
        _moneyItem.detailL.text = @"****";
        _contributeItem.detailL.text = @"****";
        _partnerItem.detailL.text = @"****";
        _orderItem.detailL.textColor = KHexColor(@"#333333");
        _moneyItem.detailL.textColor = KHexColor(@"#333333");
        _contributeItem.detailL.textColor = KHexColor(@"#333333");
        _partnerItem.detailL.textColor = KHexColor(@"#333333");
        sender.selected = NO;
    } else {
        if ([self.delegate respondsToSelector:@selector(universalCollectionViewCellClick:params:)]) {
            TSPartnerCenterData *model = [self.delegate universalCollectionViewCellModel:self.indexPath];
            _orderItem.detailL.text = [NSString stringWithFormat:@"¥%@",model.orderNum];
            _moneyItem.detailL.text = [NSString stringWithFormat:@"¥%@",model.orderMoney];
            _contributeItem.detailL.text = [NSString stringWithFormat:@"¥%@",model.profitFromMyself];
            _partnerItem.detailL.text = [NSString stringWithFormat:@"¥%@",model.profitFromPartner];
            _orderItem.detailL.textColor = KHexColor(@"#FF6460");
            _moneyItem.detailL.textColor = KHexColor(@"#FF6460");
            _contributeItem.detailL.textColor = KHexColor(@"#FF6460");
            _partnerItem.detailL.textColor = KHexColor(@"#FF6460");
        }
        sender.selected = YES;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"TSMinePartnerCenterCell" forKey:@"cellType"];
    [params setValue:@(EyeAction) forKey:@"clickType"];
    if (self.delegate && [self.delegate respondsToSelector:@selector(universalCollectionViewCellClick:params:)]) {
        [self.delegate universalCollectionViewCellClick:self.indexPath params:params];
    }
}

#pragma mark - Getter
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = KFont(PingFangSCMedium, 16);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = KHexColor(@"#333333");
        _titleLabel.text = @"合伙人中心";
    }
    return _titleLabel;
}

-(TSMineMoreButton *)moreButton{
    if (!_moreButton) {
        _moreButton = [TSMineMoreButton buttonWithType:UIButtonTypeCustom];
//        [_moreButton setTitle:@"更多" forState:UIControlStateNormal];
        [_moreButton addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreButton;
}

-(UIView *)seperateView{
    if (!_seperateView) {
        _seperateView = [[UIView alloc] init];
        _seperateView.backgroundColor = KlineColor;
    }
    return _seperateView;
}


-(UIButton *)eyeButton{
    if (!_eyeButton) {
        _eyeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_eyeButton setImage:KImageMake(@"mall_mine_invisiable") forState:UIControlStateNormal];
        [_eyeButton setImage:KImageMake(@"mall_mine_eye") forState:UIControlStateSelected];
        [_eyeButton addTarget:self action:@selector(eyeAction:) forControlEvents:UIControlEventTouchUpInside];
        _eyeButton.selected = YES;
    }
    return _eyeButton;
}
 

-(TSMinePartnerCenterCellItem *)orderItem{
    if (!_orderItem) {
        _orderItem = [[TSMinePartnerCenterCellItem alloc] init];
        _orderItem.title.text = @"累计订单";
    }
    return _orderItem;
}

-(TSMinePartnerCenterCellItem *)moneyItem{
    if (!_moneyItem) {
        _moneyItem = [[TSMinePartnerCenterCellItem alloc] init];
        _moneyItem.title.text = @"累计金额";
    }
    return _moneyItem;
}

-(TSMinePartnerCenterCellItem *)contributeItem{
    if (!_contributeItem) {
        _contributeItem = [[TSMinePartnerCenterCellItem alloc] init];
        _contributeItem.title.text = @"自身贡献收入";
    }
    return _contributeItem;
}

-(TSMinePartnerCenterCellItem *)partnerItem{
    if (!_partnerItem) {
        _partnerItem = [[TSMinePartnerCenterCellItem alloc] init];
        _partnerItem.title.text = @"合伙人贡献收入";
    }
    return _partnerItem;
}

- (UIStackView *)topStackView {
    if (!_topStackView) {
        _topStackView = [[UIStackView alloc] init];
        _topStackView.distribution = UIStackViewDistributionFillEqually;
        _topStackView.axis = UILayoutConstraintAxisHorizontal;
        _topStackView.alignment = UIStackViewAlignmentFill;
    }
    return  _topStackView;
}

- (UIStackView *)bottomStackView {
    if (!_bottomStackView) {
        _bottomStackView = [[UIStackView alloc] init];
        _bottomStackView.distribution = UIStackViewDistributionFillEqually;
        _bottomStackView.axis = UILayoutConstraintAxisHorizontal;
        _bottomStackView.alignment = UIStackViewAlignmentFill;
    }
    return  _bottomStackView;
}

@end


