//
//  TSSelectorCell.m
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/25.
//

#import "TSSelectorCell.h"

@interface TSSelectorCell ()

@property (nonatomic ,strong) UIImageView *bankIconImageView;
@property (nonatomic ,strong) UILabel *bankNameLab;
@property (nonatomic ,strong) UIImageView *tipsImageView;
@property (nonatomic ,strong) UIView *lineView;
@end
@implementation TSSelectorCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self jaf_layoutSubview];
    }
    return self;
}

- (void)jaf_layoutSubview {
    [self addSubview:self.bankIconImageView];
    [self.bankIconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.centerY.equalTo(self);
        make.width.height.mas_equalTo(35);
    }];
    
    [self addSubview:self.bankNameLab];
    [self.bankNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@[self.bankIconImageView.mas_right]).offset(10);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(30);
    }];
    
    [self addSubview:self.tipsImageView];
    [self.tipsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-16);
        make.centerY.equalTo(self);
        make.width.height.mas_equalTo(16);
    }];
    
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.height.mas_equalTo(1);
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self).offset(-16);
    }];
}

// MARK: get
- (UIImageView *)bankIconImageView {
    if (!_bankIconImageView) {
        _bankIconImageView = [UIImageView new];
        _bankIconImageView.image = KImageMake(@"mine_gongshang_de");
    }
    return _bankIconImageView;
}

- (UILabel *)bankNameLab {
    if (!_bankNameLab) {
        _bankNameLab = [UILabel new];
        _bankNameLab.textColor = KHexColor(@"#2D3132");
        _bankNameLab.font = KRegularFont(16);
        _bankNameLab.text = @"工商银行";
    }
    return _bankNameLab;
}

- (UIImageView *)tipsImageView {
    if (!_tipsImageView) {
        _tipsImageView = [UIImageView new];
        _tipsImageView.image = KImageMake(@"mine_tips_right");
    }
    return _tipsImageView;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = KHexAlphaColor(@"#E6E6E6", .5);
    }
    return _lineView;
}
@end


@interface TSSelectorHeader ()

@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UIButton *closeBtn;
@property (nonatomic ,strong) UIView *lineView;
@end
@implementation TSSelectorHeader
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self jaf_layoutSubViews];
    }
    return self;
}

- (void)jaf_layoutSubViews {
    [self addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(16);
        make.height.mas_equalTo(22);
    }];
    
    [self addSubview:self.closeBtn];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-16);
        make.height.mas_equalTo(24);
        make.width.mas_equalTo(24);
    }];
    
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(self.width);
    }];
}

// MARK: actions
- (void)closeAction:(UIButton *)sender {
    if ([self.kDelegate respondsToSelector:@selector(selectorHeaderCloseAction:)]) {
        [self.kDelegate selectorHeaderCloseAction:sender];
    }
}

// MAKR: get
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.text = @"请选择银行名称";
        _titleLab.textColor = KHexColor(@"#333333");
        _titleLab.font = KRegularFont(16);
    }
    return _titleLab;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
        [_closeBtn setImage:KImageMake(@"general_close") forState:UIControlStateNormal];
        [_closeBtn jaf_setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
    }
    return _closeBtn;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = KHexAlphaColor(@"#E6E6E6", .5);
    }
    return _lineView;
}
@end

@interface TSSelectorCellHeader ()

@property (nonatomic ,strong) UIButton *oneTitleBtn;
@property (nonatomic ,strong) UIButton *secondTitleBtn;
@property (nonatomic ,strong) UIView *lineView;
@end
@implementation TSSelectorCellHeader
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = KWhiteColor;
        [self jaf_layoutSubViews];
    }
    return self;
}

- (void)jaf_layoutSubViews {
    [self addSubview:self.oneTitleBtn];
    [self.oneTitleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(16);
        make.height.mas_equalTo(22);
    }];
    
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self).offset(-16);
        make.height.mas_equalTo(1);
    }];
}

// MARK: actions

// MARK: get
- (UIButton *)oneTitleBtn {
    if (!_oneTitleBtn) {
        _oneTitleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_oneTitleBtn setTitle:@"当前支持以下银行" forState:UIControlStateNormal];
        _oneTitleBtn.titleLabel.font = KRegularFont(14);
        [_oneTitleBtn setTitleColor:KHexColor(@"#2D3132") forState:UIControlStateNormal];
    }
    return _oneTitleBtn;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = KHexAlphaColor(@"#E6E6E6", .5);
    }
    return _lineView;
}
@end
