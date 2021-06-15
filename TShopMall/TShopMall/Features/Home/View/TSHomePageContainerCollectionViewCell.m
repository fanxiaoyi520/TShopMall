//
//  TSHomePageContainerCollectionViewCell.m
//  TShopMall
//
//  Created by sway on 2021/6/15.
//

#import "TSHomePageContainerCollectionViewCell.h"
#import "TSHighPriceTagView.h"
#import "UIImageView+WebCache.h"

@interface TSHomePageContainerCollectionViewCell()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *priceLabel;
@property (nonatomic, strong) TSHighPriceTagView *highPriceView;
@property (nonatomic, strong) UILabel *getPriceLabel;
@property (nonatomic, strong) UILabel *rmbLabel;


@end
@implementation TSHomePageContainerCollectionViewCell

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
            make.top.equalTo(self.imageView.mas_bottom).offset(0);
            make.left.equalTo(self).offset(8);
            make.right.equalTo(self).offset(-8);
            make.height.equalTo(@44);
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
            make.height.equalTo(@30);
        }];
        
        [self addSubview: self.priceLabel];
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.highPriceView);
            make.left.equalTo(self.rmbLabel.mas_right).offset(2);
            make.height.equalTo(@30);
        }];
        
        
        
        [self addSubview: self.getPriceLabel];
        [self.getPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.priceLabel.mas_bottom);
            make.left.equalTo(self).offset(8);
            make.height.equalTo(@16);
            make.bottom.equalTo(self).offset(-8);
        }];
    }
    return self;
}

- (void)setItem:(TSHomePageContainerModel *)item{
    _item = item;
    
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:item.imageUrl]];
    
    self.titleLabel.text = item.title;
    self.priceLabel.text = item.price;
    self.highPriceView.leftLabel.text = @"最高赚";
    self.highPriceView.rightLabel.text = item.highPrice;
    self.getPriceLabel.text = item.getPrice;

    [self layoutIfNeeded];
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
    }
    return _imageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.numberOfLines = 2;
        _titleLabel.font = KFont(PingFangSCMedium, 15.0);
        _titleLabel.textColor = KHexColor(@"#2D3132");
    }
    return _titleLabel;
}

- (UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [UILabel new];
        _priceLabel.font = KFont(PingFangSCMedium, 20.0);
        _priceLabel.textColor = KHexColor(@"#E64C3D");
    }
    return _priceLabel;
}

- (UILabel *)rmbLabel{
    if (!_rmbLabel) {
        _rmbLabel = [UILabel new];
        _rmbLabel.font = KFont(PingFangSCRegular, 16.0);
        _rmbLabel.textColor = KHexColor(@"#E64C3D");
        _rmbLabel.text = @"¥";
    }
    return _rmbLabel;
}

- (UILabel *)getPriceLabel{
    if (!_getPriceLabel) {
        _getPriceLabel = [UILabel new];
        _getPriceLabel.font = KFont(PingFangSCRegular, 10.0);
        _getPriceLabel.textColor = KHexAlphaColor(@"333333", .6);
    }
    return _getPriceLabel;
}

- (TSHighPriceTagView *)highPriceView{
    if (!_highPriceView) {
        _highPriceView = [[TSHighPriceTagView alloc] initWithFrame:CGRectZero leftText:@"最高赚" rightText:@"¥19999"];
    }
    return _highPriceView;
}
@end
