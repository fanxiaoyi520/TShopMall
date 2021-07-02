//
//  TSOneRowsGoodsCollectionViewCell.m
//  TShopMall
//
//  Created by  on 2021/6/29.
//

#import "TSOneRowsGoodsCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "TSRecommendMaxPriceView.h"

@interface TSOneRowsGoodsCollectionViewCell()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) TSRecommendMaxPriceView *maxPriceView;
@property (nonatomic, strong) UILabel *getPriceLabel;
@property (nonatomic, strong) UILabel *rmbLabel;
@property (nonatomic, strong) UIView *line;

@end

@implementation TSOneRowsGoodsCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
       
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview: self.imageView];
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(10);
            make.left.equalTo(self.contentView).offset(16);
            make.bottom.equalTo(self.contentView).offset(-10);
            make.width.equalTo(@(self.contentView.height-20));
        }];
        
        [self addSubview: self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(11);
            make.left.equalTo(self.imageView.mas_right).offset(8);
            make.right.equalTo(self.contentView);
            make.height.equalTo(@44).priorityLow();;
        }];
        
        [self addSubview:self.rmbLabel];
        [self.rmbLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(11);
            make.left.equalTo(self.imageView.mas_right).offset(8);
            make.height.equalTo(@24).priorityLow();;
        }];
        
        [self addSubview: self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.rmbLabel);
            make.left.equalTo(self.rmbLabel.mas_right).offset(2);
            make.height.equalTo(@30).priorityLow();;
        }];
        
        [self addSubview: self.maxPriceView];
        [self.maxPriceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.rmbLabel);
            make.left.equalTo(self.priceLabel.mas_right).offset(14);
            make.size.sizeOffset(CGSizeMake(KRateW(69), KRateH(18)));
        }];
        
        [self addSubview: self.getPriceLabel];
        [self.getPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.priceLabel.mas_bottom);
            make.left.equalTo(self.imageView.mas_right).offset(8);
            make.height.equalTo(@16);
            make.bottom.equalTo(self.imageView.mas_bottom).priorityLow();;
        }];
        
        [self addSubview: self.line];
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.priceLabel.mas_bottom);
            make.left.equalTo(self.imageView.mas_right).offset(8);
            make.right.equalTo(self.contentView);
            make.height.equalTo(@0.5);
            make.bottom.equalTo(self.contentView).offset(-0.5);
        }];
    }
    return self;
}

- (void)setItem:(id<TSRecomendGoodsProtocol>)item{
    _item = item;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:item.imageUrl]];
    
    self.titleLabel.text = item.name;
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.layer.cornerRadius = 0;
    
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
        _imageView.clipsToBounds = YES;
        _imageView.layer.cornerRadius = 5.5;
    }
    return _imageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.backgroundColor = KGrayColor;
        _titleLabel.layer.cornerRadius = 4;
        _titleLabel.clipsToBounds = YES;
        _titleLabel.numberOfLines = 2;
        _titleLabel.font = KFont(PingFangSCRegular, 15.0);
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
        _priceLabel.layer.cornerRadius = 4;
        _priceLabel.clipsToBounds = YES;
    }
    return _priceLabel;
}

- (UILabel *)rmbLabel{
    if (!_rmbLabel) {
        _rmbLabel = [UILabel new];
        _rmbLabel.font = KFont(PingFangSCRegular, 16.0);
        _rmbLabel.textColor = KHexColor(@"#E64C3D");

        _rmbLabel.backgroundColor = KGrayColor;
        _rmbLabel.layer.cornerRadius = 4;
        _rmbLabel.clipsToBounds = YES;
    }
    return _rmbLabel;
}

- (UILabel *)getPriceLabel{
    if (!_getPriceLabel) {
        _getPriceLabel = [UILabel new];
        _getPriceLabel.font = KFont(PingFangSCRegular, 10.0);
        _getPriceLabel.textColor = KHexAlphaColor(@"333333", .6);
        
        _getPriceLabel.backgroundColor = KGrayColor;
        _getPriceLabel.layer.cornerRadius = 4;
        _getPriceLabel.clipsToBounds = YES;
    }
    return _getPriceLabel;
}

- (TSRecommendMaxPriceView *)maxPriceView {
    if (!_maxPriceView) {
        _maxPriceView = [[TSRecommendMaxPriceView alloc] init];
    }
    return _maxPriceView;
}

- (UIView *)line{
    if (!_line) {
        _line = [UIView new];
        _line.backgroundColor = KHexColor(@"E6E6E6");
    }
    return _line;
}
@end
