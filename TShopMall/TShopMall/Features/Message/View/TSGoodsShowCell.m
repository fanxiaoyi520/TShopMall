//
//  TSGoodsShowCell.m
//  TShopMall
//
//  Created by edy on 2021/6/21.
//

#import "TSGoodsShowCell.h"

@interface TSGoodsShowCell ()
/// 背景视图
@property(nonatomic, weak) UIImageView *bgImageView;
/** 底部  */
@property(nonatomic, weak) UIImageView *rankBottomImgV;
@property(nonatomic, weak) UIImageView *championImgV;
@property(nonatomic, weak) UIImageView *championIconImgV;
@property(nonatomic, weak) UIImageView *rightImgV;
@property(nonatomic, weak) UIImageView *rightIconImgV;
@property(nonatomic, weak) UIImageView *leftImgV;
@property(nonatomic, weak) UIImageView *leftIconImgV;
/** title显示  */
@property(nonatomic, weak) UIButton *titleButton;

@end

@implementation TSGoodsShowCell

- (void)fillCustomContentView {
    [super fillCustomContentView];
    self.contentView.backgroundColor = KWhiteColor;
    ///添加约束
    [self addConstraints];
}

- (void)addConstraints {
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).with.offset(0);
        make.left.equalTo(self.contentView.mas_left).with.offset(0);
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        make.height.mas_equalTo(240);
    }];
    [self.rankBottomImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(0);
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        make.bottom.equalTo(self.bgImageView.mas_bottom).with.offset(10);
        make.height.mas_equalTo(51.22);
    }];
    [self.championImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX).with.offset(0);
        make.bottom.equalTo(self.rankBottomImgV.mas_top).with.offset(-5);
        make.width.mas_equalTo(154);
        make.height.mas_equalTo(64);
    }];
    [self.championIconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.championImgV.mas_centerX).with.offset(0);
        make.bottom.equalTo(self.championImgV.mas_top).with.offset(28);
        make.width.mas_equalTo(154);
        make.height.mas_equalTo(88);
    }];
    [self.rightImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).with.offset(-KRateW(43));
        make.bottom.equalTo(self.championImgV.mas_top).with.offset(10);
        make.width.mas_equalTo(98);
        make.height.mas_equalTo(41);
    }];
    [self.rightIconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.rightImgV.mas_centerX).with.offset(0);
        make.bottom.equalTo(self.rightImgV.mas_top).with.offset(28);
        make.width.mas_equalTo(98);
        make.height.mas_equalTo(66);
    }];
    
    [self.leftImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(KRateW(40));
        make.centerY.equalTo(self.rightImgV.mas_centerY).with.offset(0);
        make.width.mas_equalTo(98);
        make.height.mas_equalTo(41);
    }];
    [self.leftIconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.leftImgV.mas_centerX).with.offset(0);
        make.bottom.equalTo(self.leftImgV.mas_top).with.offset(28);
        make.width.mas_equalTo(98);
        make.height.mas_equalTo(66);
    }];
    [self.titleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX).with.offset(0);
        make.top.equalTo(self.championImgV.mas_bottom).with.offset(-20);
        make.width.mas_equalTo(195);
        make.height.mas_equalTo(32);
    }];
}


#pragma mark - Getter
- (UIImageView *)bgImageView{
    if (_bgImageView == nil) {
        UIImageView *bgImageView = [[UIImageView alloc] init];
        _bgImageView = bgImageView;
        _bgImageView.image = KImageMake(@"mall_rank_hotgoodsbg");
        [self.contentView insertSubview:_bgImageView atIndex:0];
    }
    return _bgImageView;
}

- (UIImageView *)rankBottomImgV {
    if (_rankBottomImgV == nil) {
        UIImageView *rankBottomImgV = [[UIImageView alloc] init];
        _rankBottomImgV = rankBottomImgV;
        _rankBottomImgV.image = KImageMake(@"mall_rank_bottom");
        [self.contentView addSubview: _rankBottomImgV];
    }
    return _rankBottomImgV;
}

- (UIImageView *)championImgV {
    if (_championImgV == nil) {
        UIImageView *championImgV = [[UIImageView alloc] init];
        _championImgV = championImgV;
        _championImgV.image = KImageMake(@"mall_rank_hotbest");
        _championImgV.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview: _championImgV];
    }
    return _championImgV;
}

- (UIImageView *)championIconImgV {
    if (_championIconImgV == nil) {
        UIImageView *championIconImgV = [[UIImageView alloc] init];
        _championIconImgV = championIconImgV;
        _championIconImgV.image = KImageMake(@"image_test");
        _championIconImgV.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView insertSubview:_championIconImgV aboveSubview:self.championImgV];
    }
    return _championIconImgV;
}

- (UIImageView *)rightImgV {
    if (_rightImgV == nil) {
        UIImageView *rightImgV = [[UIImageView alloc] init];
        _rightImgV = rightImgV;
        _rightImgV.image = KImageMake(@"mall_rank_hotright");
        _rightImgV.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView insertSubview:_rightImgV belowSubview:self.championImgV];
    }
    return _rightImgV;
}

- (UIImageView *)rightIconImgV {
    if (_rightIconImgV == nil) {
        UIImageView *rightIconImgV = [[UIImageView alloc] init];
        _rightIconImgV = rightIconImgV;
        _rightIconImgV.image = KImageMake(@"image_test");
        _rightIconImgV.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView insertSubview:_rightIconImgV aboveSubview:self.rightImgV];
    }
    return _rightIconImgV;
}

- (UIImageView *)leftImgV {
    if (_leftImgV == nil) {
        UIImageView *leftImgV = [[UIImageView alloc] init];
        _leftImgV = leftImgV;
        _leftImgV.image = KImageMake(@"mall_rank_hotleft");
        _leftImgV.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView insertSubview:_leftImgV belowSubview:self.championImgV];
    }
    return _leftImgV;
}

- (UIImageView *)leftIconImgV {
    if (_leftIconImgV == nil) {
        UIImageView *leftIconImgV = [[UIImageView alloc] init];
        _leftIconImgV = leftIconImgV;
        _leftIconImgV.image = KImageMake(@"image_test");
        _leftIconImgV.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView insertSubview:_leftIconImgV aboveSubview:self.leftImgV];
    }
    return _leftIconImgV;
}

- (UIButton *)titleButton {
    if (_titleButton == nil) {
        UIButton *titleButton = [[UIButton alloc] init];
        _titleButton = titleButton;
        _titleButton.enabled = NO;
        _titleButton.titleLabel.font = KRegularFont(14);
        [_titleButton setTitle:@"TCL 灵犀C12  65寸 " forState:UIControlStateNormal];
        [_titleButton setTitleColor:KWhiteColor forState:(UIControlStateNormal)];
        [_titleButton setBackgroundImage:KImageMake(@"mall_rank_titlebg") forState:(UIControlStateNormal)];
        [self.contentView addSubview: _titleButton];
    }
    return _titleButton;
}


@end
