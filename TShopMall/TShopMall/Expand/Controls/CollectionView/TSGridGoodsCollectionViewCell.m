//
//  TSGridGoodsCollectionViewCell.m
//  TShopMall
//
//  Created by sway on 2021/6/27.
//

#import "TSGridGoodsCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "TSRecommendMaxPriceView.h"

@interface TSGridGoodsCollectionViewCell()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *rmbLabel;
@property (nonatomic, strong) UILabel *priceLabel;
//最高价
@property (nonatomic, strong) TSRecommendMaxPriceView * maxPriceView;

@property (nonatomic, strong) UILabel *getPriceLabel;
@end

@implementation TSGridGoodsCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
       self.layer.cornerRadius = 8;
       self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview: self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(self);
            make.height.equalTo(@168);
        }];
        
        [self addSubview: self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.imageView.mas_bottom).offset(8);
            make.left.equalTo(self).offset(8);
            make.right.equalTo(self).offset(-8);
            make.height.equalTo(@44).priorityLow();;
        }];
        
        [self addSubview: self.maxPriceView];
        [self.maxPriceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.offset(-8);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(14);
            make.size.sizeOffset(CGSizeMake(69, 18));
        }];
        
        [self addSubview:self.rmbLabel];
        [self.rmbLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.maxPriceView);
            make.left.equalTo(self).offset(8);
            make.height.equalTo(@30).priorityLow();;
        }];
        
        [self addSubview: self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.maxPriceView);
            make.left.equalTo(self.rmbLabel.mas_right).offset(2);
            make.height.equalTo(@30).priorityLow();;
        }];
        
        
        
        [self addSubview: self.getPriceLabel];
        [self.getPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.priceLabel.mas_bottom);
            make.left.equalTo(self).offset(8);
            make.height.equalTo(@16);
            make.bottom.equalTo(self).offset(-8).priorityLow();;
        }];
    }
    return self;
}

- (void)setItem:(id<TSRecomendGoodsProtocol>)item{
    _item = item;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:item.imageUrl]];
    
    self.titleLabel.text = item.name;
    self.titleLabel.backgroundColor = [UIColor clearColor];
    
    self.rmbLabel.text = @"¥";
    self.rmbLabel.backgroundColor = [UIColor clearColor];

    self.priceLabel.text = item.goodsPrice;
    self.priceLabel.backgroundColor = [UIColor clearColor];

    self.maxPriceView.maxPrice = item.goodsEarnMost;
    self.getPriceLabel.text = [NSString stringWithFormat:@"提货价 ¥%@",item.goodsStaffPrice];
    self.getPriceLabel.backgroundColor = [UIColor clearColor];
    
    [self.getPriceLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.priceLabel.mas_bottom);
    }];

    [self layoutIfNeeded];
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = KGrayColor;
    }
    return _imageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.backgroundColor = KGrayColor;
        _titleLabel.numberOfLines = 2;
        _titleLabel.font = KRegularFont(14);
        _titleLabel.textColor = KHexColor(@"#2D3132");
    }
    return _titleLabel;
}

- (UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [UILabel new];
        _priceLabel.font = KFont(PingFangSCMedium, 20.0);
        _priceLabel.textColor = KHexColor(@"#E64C3D");
        _priceLabel.backgroundColor = KGrayColor;
    }
    return _priceLabel;
}

- (UILabel *)rmbLabel{
    if (!_rmbLabel) {
        _rmbLabel = [UILabel new];
        _rmbLabel.font = KRegularFont(16);
        _rmbLabel.textColor = KHexColor(@"#E64C3D");

        _rmbLabel.backgroundColor = KGrayColor;
    }
    return _rmbLabel;
}

- (UILabel *)getPriceLabel{
    if (!_getPriceLabel) {
        _getPriceLabel = [UILabel new];
        _getPriceLabel.font = KFont(PingFangSCRegular, 10.0);
        _getPriceLabel.textColor = KHexAlphaColor(@"333333", .6);
        
        _getPriceLabel.backgroundColor = KGrayColor;
    }
    return _getPriceLabel;
}

- (TSRecommendMaxPriceView *)maxPriceView {
    if (!_maxPriceView) {
        _maxPriceView = [[TSRecommendMaxPriceView alloc] init];
    }
    return _maxPriceView;
}

@end
