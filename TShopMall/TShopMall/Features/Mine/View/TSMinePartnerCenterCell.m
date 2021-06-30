//
//  TSMinePartnerCenterCell.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/11.
//

#import "TSMinePartnerCenterCell.h"
#import "TSMineMoreButton.h"
#import "TSPartnerCenterData.h"
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
@property(nonatomic, strong) UILabel *orderLabel;
@property(nonatomic, strong) UILabel *orderValueLabel;

@property(nonatomic, strong) UILabel *moneyLabel;
@property(nonatomic, strong) UILabel *moneyValueLabel;

@property(nonatomic, strong) UILabel *contributeLabel;
@property(nonatomic, strong) UILabel *contributeValueLabel;

@property(nonatomic, strong) UILabel *partnerLabel;
@property(nonatomic, strong) UILabel *partnerValueLabel;

@end

@implementation TSMinePartnerCenterCell

-(void)fillCustomContentView{

    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.moreButton];
    [self.contentView addSubview:self.eyeButton];
    [self.contentView addSubview:self.seperateView];
    [self.contentView addSubview:self.partnerValueLabel];
    [self.contentView addSubview:self.partnerLabel];
    [self.contentView addSubview:self.contributeLabel];
    [self.contentView addSubview:self.contributeValueLabel];
    [self.contentView addSubview:self.orderLabel];
    [self.contentView addSubview:self.orderValueLabel];
    [self.contentView addSubview:self.moneyLabel];
    [self.contentView addSubview:self.moneyValueLabel];
    
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
        make.right.equalTo(self.contentView).offset(-16);
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
    
    [self.partnerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-14);
        make.left.equalTo(self.contentView.mas_centerX);
        make.right.equalTo(self.contentView);
        make.height.mas_equalTo(17);
    }];
    
    [self.partnerValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.partnerLabel.mas_top).offset(-3);
        make.height.mas_equalTo(22);
        make.left.equalTo(self.contentView.mas_centerX);
        make.right.equalTo(self.contentView);
    }];
    
    [self.contributeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-14);
        make.right.equalTo(self.contentView.mas_centerX);
        make.left.equalTo(self.contentView);
        make.height.mas_equalTo(17);
    }];
    
    [self.contributeValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contributeLabel.mas_top).offset(-3);
        make.height.mas_equalTo(22);
        make.right.equalTo(self.contentView.mas_centerX);
        make.left.equalTo(self.contentView);
    }];
    
    [self.orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contributeValueLabel.mas_top).offset(-20);
        make.right.equalTo(self.contentView.mas_centerX);
        make.left.equalTo(self.contentView);
        make.height.mas_equalTo(17);
    }];
    
    [self.orderValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.orderLabel.mas_top).offset(-3);
        make.height.mas_equalTo(22);
        make.right.equalTo(self.contentView.mas_centerX);
        make.left.equalTo(self.contentView);
    }];
    
    [self.moneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.orderLabel);
        make.left.equalTo(self.contentView.mas_centerX);
        make.right.equalTo(self.contentView);
        make.height.mas_equalTo(17);
    }];
    
    [self.moneyValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.orderValueLabel);
        make.height.mas_equalTo(22);
        make.left.equalTo(self.contentView.mas_centerX);
        make.right.equalTo(self.contentView);
    }];
}

- (void)setDelegate:(id<UniversalCollectionViewCellDataDelegate>)delegate {
    [super setDelegate:delegate];
    TSPartnerCenterData *model = [delegate universalCollectionViewCellModel:self.indexPath];
    
    _orderValueLabel.text = model.orderNum;
    _moneyValueLabel.text = model.orderMoney;
    _contributeValueLabel.text = model.profitFromMyself;
    _partnerValueLabel.text = model.profitFromPartner;
    _eyeButton.selected = model.eyeIsOn;
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
        _orderValueLabel.text = @"****";
        _moneyValueLabel.text = @"****";
        _contributeValueLabel.text = @"****";
        _partnerValueLabel.text = @"****";
        sender.selected = NO;
    } else {
        if ([self.delegate respondsToSelector:@selector(universalCollectionViewCellClick:params:)]) {
            TSPartnerCenterData *model = [self.delegate universalCollectionViewCellModel:self.indexPath];
            _orderValueLabel.text = model.orderNum;
            _moneyValueLabel.text = model.orderMoney;
            _contributeValueLabel.text = model.profitFromMyself;
            _partnerValueLabel.text = model.profitFromPartner;
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
        [_moreButton setTitle:@"更多" forState:UIControlStateNormal];
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

-(UILabel *)orderLabel{
    if (!_orderLabel) {
        _orderLabel = [[UILabel alloc] init];
        _orderLabel.font = KFont(PingFangSCRegular, 12);
        _orderLabel.textAlignment = NSTextAlignmentCenter;
        _orderLabel.textColor = KHexColor(@"#333333");
        _orderLabel.text = @"累计订单";
    }
    return _orderLabel;
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

-(UILabel *)orderValueLabel{
    if (!_orderValueLabel) {
        _orderValueLabel = [[UILabel alloc] init];
        _orderValueLabel.font = KFont(PingFangSCMedium, 16);
        _orderValueLabel.textAlignment = NSTextAlignmentCenter;
        _orderValueLabel.textColor = KHexColor(@"#333333");
        _orderValueLabel.text = @"¥2380";
    }
    return _orderValueLabel;
}

-(UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] init];
        _moneyLabel.font = KFont(PingFangSCRegular, 12);
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
        _moneyLabel.textColor = KHexColor(@"#333333");
        _moneyLabel.text = @"累计金额";
    }
    return _moneyLabel;
}

-(UILabel *)moneyValueLabel{
    if (!_moneyValueLabel) {
        _moneyValueLabel = [[UILabel alloc] init];
        _moneyValueLabel.font = KFont(PingFangSCMedium, 16);
        _moneyValueLabel.textAlignment = NSTextAlignmentCenter;
        _moneyValueLabel.textColor = KHexColor(@"#333333");
        _moneyValueLabel.text = @"¥8380";
    }
    return _moneyValueLabel;
}

-(UILabel *)contributeLabel{
    if (!_contributeLabel) {
        _contributeLabel = [[UILabel alloc] init];
        _contributeLabel.font = KFont(PingFangSCRegular, 12);
        _contributeLabel.textAlignment = NSTextAlignmentCenter;
        _contributeLabel.textColor = KHexColor(@"#333333");
        _contributeLabel.text = @"自身贡献收入";
    }
    return _contributeLabel;
}

-(UILabel *)contributeValueLabel{
    if (!_contributeValueLabel) {
        _contributeValueLabel = [[UILabel alloc] init];
        _contributeValueLabel.font = KFont(PingFangSCMedium, 16);
        _contributeValueLabel.textAlignment = NSTextAlignmentCenter;
        _contributeValueLabel.textColor = KHexColor(@"#333333");
        _contributeValueLabel.text = @"¥2380";
    }
    return _contributeValueLabel;
}

-(UILabel *)partnerValueLabel{
    if (!_partnerValueLabel) {
        _partnerValueLabel = [[UILabel alloc] init];
        _partnerValueLabel.font = KFont(PingFangSCMedium, 16);
        _partnerValueLabel.textAlignment = NSTextAlignmentCenter;
        _partnerValueLabel.textColor = KHexColor(@"#333333");
        _partnerValueLabel.text = @"¥8380";
    }
    return _partnerValueLabel;
}

-(UILabel *)partnerLabel{
    if (!_partnerLabel) {
        _partnerLabel = [[UILabel alloc] init];
        _partnerLabel.font = KFont(PingFangSCRegular, 12);
        _partnerLabel.textAlignment = NSTextAlignmentCenter;
        _partnerLabel.textColor = KHexColor(@"#333333");
        _partnerLabel.text = @"合伙人贡献收入";
    }
    return _partnerLabel;
}


@end
