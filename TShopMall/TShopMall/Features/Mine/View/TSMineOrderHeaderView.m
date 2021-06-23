//
//  TSMineOrderHeaderView.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/11.
//

#import "TSMineOrderHeaderView.h"
#import "TSMineMoreButton.h"

@interface TSMineOrderHeaderView ()

/// 标题
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIButton *eyeButton;
/// 查看更多
@property(nonatomic, strong) TSMineMoreButton *moreButton;
/// 分割线
@property(nonatomic, strong) UIView *seperateView;

@end

@implementation TSMineOrderHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self fillCustomView];
    }
    return self;
}

-(void)fillCustomView{
    [self addSubview:self.titleLabel];
    [self addSubview:self.moreButton];
    [self addSubview:self.seperateView];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.centerY.equalTo(self);
    }];
    
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-16);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(150);
    }];
    
    [self.seperateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self);
        make.height.mas_equalTo(0.5);
        make.bottom.equalTo(self).offset(-0.5);
    }];
}

-(void)bindMineSectionModel:(TSMineSectionModel *)model{
    self.titleLabel.text = model.headerName;
}

#pragma mark - Actions
-(void)moreAction:(TSMineMoreButton *)sender{
    if (self.clickBlock) {
        self.clickBlock();
    }
        
}

#pragma mark - Getter
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = KFont(PingFangSCMedium, 16);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = KHexColor(@"#333333");
    }
    return _titleLabel;
}

-(UIButton *)eyeButton{
    if (!_eyeButton) {
        _eyeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_eyeButton setImage:KImageMake(@"mall_mine_eye") forState:UIControlStateNormal];
        [_eyeButton setImage:KImageMake(@"mall_mine_eye") forState:UIControlStateHighlighted];
        [_eyeButton addTarget:self action:@selector(eyeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _eyeButton;
}

-(TSMineMoreButton *)moreButton{
    if (!_moreButton) {
        _moreButton = [TSMineMoreButton buttonWithType:UIButtonTypeCustom];
        [_moreButton setTitle:@"查看全部订单" forState:UIControlStateNormal];
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

@end
