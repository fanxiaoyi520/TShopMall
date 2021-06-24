//
//  TSRankRecommendCell.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/17.
//

#import "TSRankRecommendCell.h"
#import "TSCustomLabel.h"

@interface TSRankRecommendCell ()
/** 冠军背景视图  */
@property(nonatomic, weak) UIView *championView;
/** 商品图  */
@property(nonatomic, weak) UIImageView *goodsImgV;
/** 商品标题  */
@property(nonatomic, weak) UILabel *titleLabel;
/** 商品价格  */
@property(nonatomic, weak) UILabel *priceLabel;
/** RMB显示  */
@property(nonatomic, weak) UILabel *rmbLabel;
/** 原价（提货价） */
@property(nonatomic, weak) UILabel *originPriceLabel;
/** 最高赚文字的显示  */
@property(nonatomic, weak) TSCustomLabel *bestLabel;
/** 最高赚数字的显示  */
@property(nonatomic, weak) TSCustomLabel *bestNumLabel;
/** 最高赚父视图  */
@property(nonatomic, weak) UIView *bestView;
@end

@implementation TSRankRecommendCell

- (void)fillCustomContentView {
    [super fillCustomContentView];
    self.contentView.backgroundColor = KWhiteColor;
    ///添加约束
    [self addConstraints];
    [self.contentView setCorners:UIRectCornerAllCorners radius:9.0];
}


- (void)addConstraints {
    [self.championView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(0);
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        make.top.equalTo(self.contentView.mas_top).with.offset(0);
        make.height.mas_equalTo(168);
    }];
    [self.goodsImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.championView.mas_left).with.offset(8);
        make.right.equalTo(self.championView.mas_right).with.offset(-8);
        make.top.equalTo(self.championView.mas_top).with.offset(8);
        make.bottom.equalTo(self.championView.mas_bottom).with.offset(-8);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.championView.mas_left).with.offset(8);
        make.right.equalTo(self.championView.mas_right).with.offset(-8);
        make.top.equalTo(self.championView.mas_bottom).with.offset(10);
    }];
    [self.rmbLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.championView.mas_left).with.offset(8);
        make.centerY.equalTo(self.priceLabel.mas_centerY).with.offset(1);
        make.width.mas_equalTo(15);
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rmbLabel.mas_right).with.offset(0);
        make.centerY.equalTo(self.bestView.mas_centerY).with.offset(0);
        make.right.equalTo(self.bestView.mas_left).with.offset(-3);
    }];
    [self.originPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rmbLabel.mas_left).with.offset(0);
        make.top.equalTo(self.priceLabel.mas_bottom).with.offset(5);
    }];
    [self.bestView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.championView.mas_right).with.offset(-8);
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(14);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(18);
    }];
    [self.bestNumLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bestView.mas_right).with.offset(0);
        make.top.equalTo(self.bestView.mas_top).with.offset(0);
        make.width.mas_equalTo(46);
        make.height.mas_equalTo(18);
    }];
    [self.bestLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bestNumLabel.mas_left).with.offset(10);
        make.centerY.equalTo(self.bestNumLabel.mas_centerY).with.offset(0);
        make.width.mas_equalTo(37);
        make.height.mas_equalTo(18);
    }];
}

- (UIImageView *)goodsImgV {
    if (_goodsImgV == nil) {
        UIImageView *goodsImgV = [[UIImageView alloc] init];
        _goodsImgV = goodsImgV;
        _goodsImgV.image = KImageMake(@"mall_rank_honor");
        _goodsImgV.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview: _goodsImgV];
    }
    return _goodsImgV;
}

- (UIView *)championView {
    if (_championView == nil) {
        UIView *championView = [[UIView alloc] init];
        _championView = championView;
        _championView.backgroundColor = KWhiteColor;
        [_championView setCorners:(UIRectCornerTopLeft|UIRectCornerTopRight) radius:9.0];
        [self.contentView addSubview: _championView];
    }
    return _championView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        _titleLabel = titleLabel;
        _titleLabel.textColor = KTextColor;
        _titleLabel.font = KRegularFont(14);
        _titleLabel.numberOfLines = 2;
        _titleLabel.text = @"XESS  55寸艺术电55寸艺术电55寸艺术";
        [self.contentView addSubview: _titleLabel];
    }
    return _titleLabel;
}

- (UILabel *)priceLabel {
    if (_priceLabel == nil) {
        UILabel *priceLabel = [[UILabel alloc] init];
        _priceLabel = priceLabel;
        _priceLabel.text = @"18990";
        _priceLabel.textColor = KHexColor(@"#E64C3D");
        _priceLabel.font = KFont(PingFangSCMedium, 20);
        [self.contentView addSubview: _priceLabel];
    }
    return _priceLabel;
}

- (UILabel *)rmbLabel {
    if (_rmbLabel == nil) {
        UILabel *rmbLabel = [[UILabel alloc] init];
        _rmbLabel = rmbLabel;
        _rmbLabel.textColor = KHexColor(@"#E64C3D");
        _rmbLabel.font = KRegularFont(16);
        _rmbLabel.text = @"￥";
        [self.contentView addSubview: _rmbLabel];
    }
    return _rmbLabel;
}

- (TSCustomLabel *)bestLabel {
    if (_bestLabel == nil) {
        TSCustomLabel *bestLabel = [[TSCustomLabel alloc] init];
        _bestLabel = bestLabel;
        _bestLabel.textColor = KWhiteColor;
        _bestLabel.backgroundColor = KHexColor(@"#F9AB50");
        _bestLabel.font = KRegularFont(10);
        _bestLabel.text = @"最高赚";
        _bestLabel.textAlignment = NSTextAlignmentCenter;
        _bestLabel.textInsets = UIEdgeInsetsMake(0.f, 1.0f, 0.f, 2.0f);
        _bestLabel.clipsToBounds = YES;
        [_bestLabel setCorners:(UIRectCornerTopRight|UIRectCornerBottomRight) radius:9.0];
        [self.bestView addSubview: _bestLabel];
    }
    return _bestLabel;
}

- (TSCustomLabel *)bestNumLabel {
    if (_bestNumLabel == nil) {
        TSCustomLabel *bestNumLabel = [[TSCustomLabel alloc] init];
        _bestNumLabel = bestNumLabel;
        _bestNumLabel.textColor = KWhiteColor;
        _bestNumLabel.backgroundColor = KHexColor(@"#FF4D49");
        _bestNumLabel.font = KRegularFont(9);
        _bestNumLabel.text = @"￥19999";
        _bestNumLabel.textAlignment = NSTextAlignmentLeft;
        _bestNumLabel.textInsets = UIEdgeInsetsMake(0.f, 10.0f, 0.f, 0.0f);
        [self.bestView insertSubview:_bestNumLabel belowSubview:self.bestLabel];
    }
    return _bestNumLabel;
}

- (UILabel *)originPriceLabel {
    if (_originPriceLabel == nil) {
        UILabel *originPriceLabel = [[UILabel alloc] init];
        _originPriceLabel = originPriceLabel;
        _originPriceLabel.textColor = KHexAlphaColor(@"#333333", 0.6);
        _originPriceLabel.font = KRegularFont(8);
        _originPriceLabel.text = @"提货价 ￥23990";
        [self.contentView addSubview: _originPriceLabel];
    }
    return _originPriceLabel;
}

- (UIView *)bestView {
    if (_bestView == nil) {
        UIView *bestView = [[UIView alloc] init];
        _bestView = bestView;
        _bestView.backgroundColor = UIColor.brownColor;
        //_bestView.layer.cornerRadius = 3.0;
        _bestView.clipsToBounds = YES;
        [_bestView setCorners:UIRectCornerAllCorners radius:3.0];
        [self.contentView addSubview: _bestView];
    }
    return _bestView;
}


@end
