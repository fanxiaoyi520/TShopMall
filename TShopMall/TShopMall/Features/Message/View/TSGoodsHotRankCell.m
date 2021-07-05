//
//  TSGoodsHotRankCell.m
//  TShopMall
//
//  Created by edy on 2021/6/20.
//

#import "TSGoodsHotRankCell.h"
#import "TSHotSectionModel.h"
#import "TSRecommendMaxPriceView.h"

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

/// 最高赚
@property (nonatomic, strong) TSRecommendMaxPriceView *maxPriceView;

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
        make.centerY.equalTo(self.maxPriceView);
    }];
    [self.originPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.rmbLabel.mas_left).with.offset(0);
        make.top.equalTo(self.priceLabel.mas_bottom).with.offset(5);
    }];
    
    [self.maxPriceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(14);
        make.left.equalTo(self.priceLabel.mas_right).offset(10);
        make.size.sizeOffset(CGSizeMake(69, 18));
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

- (TSRecommendMaxPriceView *)maxPriceView {
    if (!_maxPriceView) {
        _maxPriceView = [[TSRecommendMaxPriceView alloc] init];
        [self.contentView addSubview: self.maxPriceView];
    }
    return _maxPriceView;
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
    TSRecomendGoods *goodModel = item.goodModel;
    
    if (self.indexPath.row == 0) {
        self.rankImgV.hidden = NO;
        self.rankImgV.image = KImageMake(@"mall_hot_no1");
    } else if (self.indexPath.row == 1) {
        self.rankImgV.hidden = NO;
        self.rankImgV.image = KImageMake(@"mall_hot_no2");
    } else if (self.indexPath.row == 2) {
        self.rankImgV.hidden = NO;
        self.rankImgV.image = KImageMake(@"mall_hot_no3");
    } else {
        self.rankImgV.hidden = YES;
    }
    
    self.titleLabel.text = goodModel.name;
    self.priceLabel.text = goodModel.price;
    self.originPriceLabel.text = [NSString stringWithFormat:@"提货价 ￥%@", goodModel.staffPrice];
    self.maxPriceView.maxPrice =  goodModel.earnMost;
    
    [self.goodsImgV sd_setImageWithURL:[NSURL URLWithString:goodModel.imageUrl] placeholderImage:KImageMake(@"image_test")];
}

@end
