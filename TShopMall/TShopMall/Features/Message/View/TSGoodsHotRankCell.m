//
//  TSGoodsHotRankCell.m
//  TShopMall
//
//  Created by edy on 2021/6/20.
//

#import "TSGoodsHotRankCell.h"
#import "TSEdgeInsetLabel.h"
#import "TSHotSectionModel.h"

@interface TSGoodsHotRankCell ()
/** 冠军背景视图  */
@property(nonatomic, weak) UIView *championView;
/** 商品图  */
@property(nonatomic, weak) UIImageView *goodsImgV;
/** 排名的图标  */
@property(nonatomic, weak) UIImageView *rankImgV;
/** 商品标题  */
@property(nonatomic, weak) UILabel *titleLabel;

/** 商品价格  */
@property(nonatomic, weak) UILabel *priceLabel;
/** RMB显示  */
@property(nonatomic, weak) UILabel *rmbLabel;

/** 原价（提货价） */
@property(nonatomic, weak) UILabel *originPriceLabel;

/** 最高赚文字的显示  */
@property(nonatomic, weak) TSEdgeInsetLabel *bestLabel;
/** 最高赚数字的显示  */
@property(nonatomic, weak) TSEdgeInsetLabel *bestNumLabel;
/** 最高赚父视图  */
@property(nonatomic, weak) UIView *bestView;

/** 分割线  */
@property(nonatomic, weak) UIView *splitView;

@end

@implementation TSGoodsHotRankCell


- (void)fillCustomContentView {
    [super fillCustomContentView];
    self.contentView.backgroundColor = KWhiteColor;
    ///添加约束
    [self addConstraints];
}

- (void)addConstraints {
    [self.championView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(16);
        make.top.equalTo(self.contentView.mas_top).with.offset(0);
        make.width.height.mas_equalTo(120);
    }];
    [self.goodsImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.championView.mas_left).with.offset(8);
        make.right.equalTo(self.championView.mas_right).with.offset(-8);
        make.top.equalTo(self.championView.mas_top).with.offset(8);
        make.bottom.equalTo(self.championView.mas_bottom).with.offset(-8);
    }];
    [self.rankImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.championView.mas_left).with.offset(0);
        make.right.equalTo(self.championView.mas_right).with.offset(0);
        make.bottom.equalTo(self.goodsImgV.mas_bottom).with.offset(0);
        make.height.mas_equalTo(33);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.championView.mas_right).with.offset(8);
        make.right.equalTo(self.contentView.mas_right).with.offset(-16);
        make.top.equalTo(self.contentView.mas_top).with.offset(10);
    }];
    
    [self.rmbLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel);
        make.centerY.equalTo(self.priceLabel.mas_centerY).with.offset(1);
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rmbLabel.mas_right).with.offset(1);
        make.centerY.equalTo(self.bestView);
    }];
    [self.originPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rmbLabel.mas_left).with.offset(0);
        make.top.equalTo(self.priceLabel.mas_bottom).with.offset(5);
    }];
    
    [self.bestView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLabel.mas_right).offset(10);
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
        make.right.equalTo(self.bestNumLabel.mas_left).with.offset(12);
        make.centerY.equalTo(self.bestNumLabel.mas_centerY).with.offset(0);
        make.width.mas_equalTo(37);
        make.height.mas_equalTo(18);
    }];
    [self.splitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        make.left.equalTo(self.titleLabel.mas_left).with.offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(0);
        make.height.mas_equalTo(0.5);
    }];
}

- (UIImageView *)goodsImgV {
    if (_goodsImgV == nil) {
        UIImageView *goodsImgV = [[UIImageView alloc] init];
        _goodsImgV = goodsImgV;
        _goodsImgV.image = KImageMake(@"image_test");
        _goodsImgV.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview: _goodsImgV];
    }
    return _goodsImgV;
}

- (UIImageView *)rankImgV {
    if (_rankImgV == nil) {
        UIImageView *rankImgV = [[UIImageView alloc] init];
        _rankImgV = rankImgV;
        _rankImgV.image = KImageMake(@"mall_hot_no1");
        _rankImgV.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview: _rankImgV];
    }
    return _rankImgV;
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
        _titleLabel.text = @"XESS 65寸 家庭浮窗场景TV标题TV标题TV标题TV标题TV标题";
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
        _rmbLabel.text = @"¥";
        [self.contentView addSubview: _rmbLabel];
    }
    return _rmbLabel;
}

- (TSEdgeInsetLabel *)bestLabel {
    if (_bestLabel == nil) {
        TSEdgeInsetLabel *bestLabel = [[TSEdgeInsetLabel alloc] init];
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

- (TSEdgeInsetLabel *)bestNumLabel {
    if (_bestNumLabel == nil) {
        TSEdgeInsetLabel *bestNumLabel = [[TSEdgeInsetLabel alloc] init];
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
        _originPriceLabel.font = KRegularFont(10);
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
        _bestView.clipsToBounds = YES;
        [_bestView setCorners:UIRectCornerAllCorners radius:3.0];
        [self.contentView addSubview: _bestView];
    }
    return _bestView;
}

- (UIView *)splitView {
    if (_splitView == nil) {
        UIView *splitView = [[UIView alloc] init];
        _splitView = splitView;
        _splitView.backgroundColor = KHexColor(@"#EEEEEE");
        [self.contentView addSubview: _splitView];
    }
    return _splitView;
}

- (void)setDelegate:(id<UniversalCollectionViewCellDataDelegate>)delegate {
    TSHotSectionItemModel *item = [delegate universalCollectionViewCellModel:self.indexPath];
    if (item.rank == 1) {
        self.rankImgV.hidden = NO;
        self.rankImgV.image = KImageMake(@"mall_hot_no1");
    } else if (item.rank == 2) {
        self.rankImgV.hidden = NO;
        self.rankImgV.image = KImageMake(@"mall_hot_no2");
    } else if (item.rank == 3) {
        self.rankImgV.hidden = NO;
        self.rankImgV.image = KImageMake(@"mall_hot_no3");
    } else {
        self.rankImgV.hidden = YES;
    }
}

@end
