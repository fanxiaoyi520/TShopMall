//
//  TSMineEarningsCell.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/11.
//

#import "TSMineEarningsCell.h"

@interface TSMineEarningsCell()

@property(nonatomic, strong) UIImageView *walletImgView;
@property(nonatomic, strong) UILabel *nameLabel;
@property(nonatomic, strong) UIImageView *seperateImgView;
@property(nonatomic, strong) UILabel *earnLabel;
@property(nonatomic, strong) UILabel *earnMoneyLabel;
@property(nonatomic, strong) UIButton *eyeButton;

@end

@implementation TSMineEarningsCell

-(void)fillCustomContentView{
    self.contentView.backgroundColor = UIColor.whiteColor;
    
    [self.contentView addSubview:self.seperateImgView];
    [self.contentView addSubview:self.walletImgView];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.earnLabel];
    [self.contentView addSubview:self.earnMoneyLabel];
    [self.contentView addSubview:self.eyeButton];
    
    [self.seperateImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-66);
        make.width.mas_equalTo(6);
        make.height.mas_equalTo(34);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.walletImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(9);
        make.width.height.mas_equalTo(26);
        make.height.height.mas_equalTo(24);
        make.right.equalTo(self.contentView).offset(-22);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.walletImgView.mas_bottom).offset(6);
        make.right.equalTo(self.contentView);
        make.left.equalTo(self.seperateImgView.mas_right).offset(0);
    }];
    
    [self.earnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-12);
        make.width.mas_equalTo(50);
        make.centerX.equalTo(self.contentView).offset(-40);
    }];
    
    [self.earnMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.earnLabel.mas_top).offset(-3);
        make.centerX.equalTo(self.earnLabel);
        make.height.mas_equalTo(22);
    }];
    
    [self.eyeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.earnLabel.mas_right).offset(0);
        make.centerY.equalTo(self.earnLabel);
        make.width.height.mas_equalTo(30);
    }];
}

#pragma mark - Actions
-(void)eyeAction:(UIButton *)sender{
    if (sender.selected) {
        _earnMoneyLabel.hidden = YES;
        sender.selected = NO;
    } else {
        _earnMoneyLabel.hidden = NO;
        sender.selected = YES;
    }
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"TSMineEarningsCell" forKey:@"cellType"];
    [params setValue:@(EyeAction) forKey:@"clickType"];
    if (self.delegate && [self.delegate respondsToSelector:@selector(universalCollectionViewCellClick:params:)]) {
        [self.delegate universalCollectionViewCellClick:self.indexPath params:params];
    }
}

#pragma mark - Getter
-(UIImageView *)walletImgView{
    if (!_walletImgView) {
        _walletImgView = [[UIImageView alloc] init];
        _walletImgView.image = KImageMake(@"mall_mine_wallet");
    }
    return _walletImgView;
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = KRegularFont(12);
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.textColor = KHexColor(@"#333333");
        _nameLabel.text = @"我的钱包";
    }
    return _nameLabel;
}

-(UIImageView *)seperateImgView{
    if (!_seperateImgView) {
        _seperateImgView = [[UIImageView alloc] init];
        _seperateImgView.image = KImageMake(@"mall_mine_wallet_seperate");
    }
    return _seperateImgView;
}

-(UILabel *)earnLabel{
    if (!_earnLabel) {
        _earnLabel = [[UILabel alloc] init];
        _earnLabel.font = KRegularFont(12);
        _earnLabel.textAlignment = NSTextAlignmentCenter;
        _earnLabel.textColor = KHexColor(@"#333333");
        _earnLabel.text = @"我的收益";
    }
    return _earnLabel;
}

-(UILabel *)earnMoneyLabel{
    if (!_earnMoneyLabel) {
        _earnMoneyLabel = [[UILabel alloc] init];
        _earnMoneyLabel.font = KFont(PingFangSCMedium, 16);
        _earnMoneyLabel.textAlignment = NSTextAlignmentCenter;
        _earnMoneyLabel.textColor = KHexColor(@"#333333");
        _earnMoneyLabel.text = @"¥999";
        _earnMoneyLabel.hidden = YES;
    }
    return _earnMoneyLabel;
}

-(UIButton *)eyeButton{
    if (!_eyeButton) {
        _eyeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_eyeButton setImage:KImageMake(@"mall_mine_eye") forState:UIControlStateNormal];
        [_eyeButton setImage:KImageMake(@"mall_mine_eye") forState:UIControlStateSelected];
        [_eyeButton addTarget:self action:@selector(eyeAction:) forControlEvents:UIControlEventTouchUpInside];
        _eyeButton.selected = YES;
    }
    return _eyeButton;
}

@end
