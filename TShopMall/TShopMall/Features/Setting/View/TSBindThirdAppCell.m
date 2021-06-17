//
//  TSBindThirdAppCell.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/15.
//

#import "TSBindThirdAppCell.h"
#import "TSBindThirdSectionModel.h"

@interface TSBindThirdAppCell ()
/** 确认 */
@property(nonatomic, weak) UIButton *commitButton;
/** 取消 */
@property(nonatomic, weak) UIButton *cancelButton;
/** 标题 */
@property(nonatomic, weak) UILabel *titleLabel;
/** icon */
@property(nonatomic, weak) UIImageView *iconImgV;
/** 当前账号 */
@property(nonatomic, weak) UILabel *accountLabel;
/** 提示 */
@property(nonatomic, weak) UILabel *tipsLabel;

@end

@implementation TSBindThirdAppCell

- (void)fillCustomContentView {
    [super fillCustomContentView];
    ///添加约束
    [self addConstraints];
}

- (void)addConstraints {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX).with.offset(0);
        make.top.equalTo(self.contentView.mas_top).with.offset(32);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX).with.offset(0);
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(30);
        make.width.mas_equalTo(66);
        make.height.mas_equalTo(66);
    }];
    [self.accountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX).with.offset(0);
        make.top.equalTo(self.iconImgV.mas_bottom).with.offset(40);
    }];
    [self.tipsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX).with.offset(0);
        make.top.equalTo(self.accountLabel.mas_bottom).with.offset(8);
    }];
    [self.commitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(24);
        make.right.equalTo(self.contentView.mas_right).with.offset(-24);
        make.top.equalTo(self.tipsLabel.mas_bottom).with.offset(24);
        make.height.mas_equalTo(40);
    }];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(24);
        make.right.equalTo(self.contentView.mas_right).with.offset(-24);
        make.top.equalTo(self.commitButton.mas_bottom).with.offset(24);
        make.height.mas_equalTo(40);
    }];
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        _titleLabel = titleLabel;
        _titleLabel.text = @"确定关联TCL账号";
        _titleLabel.textColor = KHexColor(@"#333333");
        _titleLabel.font = KRegularFont(20);
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIImageView *)iconImgV {
    if (_iconImgV == nil) {
        UIImageView *iconImgV = [[UIImageView alloc] init];
        _iconImgV = iconImgV;
        _iconImgV.image = KImageMake(@"mall_login_wechat");
        [self.contentView addSubview:_iconImgV];
    }
    return _iconImgV;
}

- (UILabel *)accountLabel {
    if (_accountLabel == nil) {
        UILabel *accountLabel = [[UILabel alloc] init];
        _accountLabel = accountLabel;
        _accountLabel.text = @"当前账号:";
        _accountLabel.textColor = KHexColor(@"#333333");
        _accountLabel.font = KRegularFont(15);
        [self.contentView addSubview:_accountLabel];
    }
    return _accountLabel;
}

- (UILabel *)tipsLabel {
    if (_tipsLabel == nil) {
        UILabel *tipsLabel = [[UILabel alloc] init];
        _tipsLabel = tipsLabel;
        _tipsLabel.text = @"关联后可使用微信快速登录";
        _tipsLabel.textColor = KHexAlphaColor(@"#2D3132", 0.4);
        _tipsLabel.font = KRegularFont(15);
        [self.contentView addSubview:_tipsLabel];
    }
    return _tipsLabel;
}

- (UIButton *)commitButton {
    if (_commitButton == nil) {
        UIButton *commitButton = [[UIButton alloc] init];
        _commitButton = commitButton;
        _commitButton.backgroundColor = KHexColor(@"#2EC404");
        _commitButton.layer.cornerRadius = 20;
        _commitButton.clipsToBounds = YES;
        _commitButton.titleLabel.font = KRegularFont(16);
        [_commitButton setTitleColor:KWhiteColor forState:UIControlStateNormal];
        [_commitButton setTitle:@"确认绑定" forState:UIControlStateNormal];
        [_commitButton addTarget:self action:@selector(commitAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_commitButton];
    }
    return _commitButton;
}

- (UIButton *)cancelButton {
    if (_cancelButton == nil) {
        UIButton *cancelButton = [[UIButton alloc] init];
        _cancelButton = cancelButton;
        _cancelButton.backgroundColor = KHexColor(@"#DDDDDD");
        _cancelButton.layer.cornerRadius = 20;
        _cancelButton.clipsToBounds = YES;
        _cancelButton.titleLabel.font = KRegularFont(16);
        [_cancelButton setTitleColor:KHexAlphaColor(@"#2D3132", 0.4) forState:UIControlStateNormal];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_cancelButton];
    }
    return _cancelButton;
}

- (void)setDelegate:(id<UniversalCollectionViewCellDataDelegate>)delegate {
    TSBindThirdSectionItemModel *item = [delegate universalCollectionViewCellModel:self.indexPath];
    self.accountLabel.text = [NSString stringWithFormat:@"当前账号: %@", item.account];
    if (!item.isWechat) {///苹果账号绑定
        self.commitButton.backgroundColor = KHexColor(@"#000000");
        self.iconImgV.image = KImageMake(@"mall_login_apple");
        self.tipsLabel.text = @"关联后可使用Apple快速登录";
    }
}

#pragma mark - Actions
- (void)commitAction {
    
}

- (void)cancelAction {
    
}

@end
