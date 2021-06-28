//
//  TSGridGoodsCollectionViewCell.m
//  TShopMall
//
//  Created by sway on 2021/6/27.
//

#import "TSGridGoodsCollectionViewCell.h"
#import "TSHighPriceTagView.h"
#import "UIImageView+WebCache.h"

@interface TSGridGoodsCollectionViewCell()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) TSHighPriceTagView *highPriceView;
@property (nonatomic, strong) UILabel *getPriceLabel;
@property (nonatomic, strong) UILabel *rmbLabel;
@end

@implementation TSGridGoodsCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
       self.layer.cornerRadius = 5;
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
        
        [self addSubview: self.highPriceView];
        [self.highPriceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.titleLabel.mas_bottom).offset(14);
            make.right.equalTo(self).offset(-8);
            make.height.equalTo(@18);
            make.width.equalTo(@69);
        }];
        
        [self addSubview:self.rmbLabel];
        [self.rmbLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.highPriceView);
            make.left.equalTo(self).offset(8);
            make.height.equalTo(@30).priorityLow();;
        }];
        
        [self addSubview: self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.highPriceView);
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
    self.titleLabel.layer.cornerRadius = 0;
    
    self.rmbLabel.text = @"¥";
    self.rmbLabel.backgroundColor = [UIColor clearColor];

    self.priceLabel.text = item.goodsPrice;
    self.priceLabel.backgroundColor = [UIColor clearColor];

    [self.highPriceView setLeftText:@"最高赚" rightText:[NSString stringWithFormat:@"¥%@",item.goodsEarnMost]];
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

- (TSHighPriceTagView *)highPriceView{
    if (!_highPriceView) {
        _highPriceView = [TSHighPriceTagView new];
        _highPriceView.backgroundColor = KGrayColor;
        _highPriceView.layer.cornerRadius = 4;
        _highPriceView.clipsToBounds = YES;
    }
    return _highPriceView;
}
@end
