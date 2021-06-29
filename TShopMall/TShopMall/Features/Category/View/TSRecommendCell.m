//
//  TSRecommendCell.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/10.
//

#import "TSRecommendCell.h"
#import "TSCategorySectionModel.h"
#import "TSRecommendMaxPriceView.h"

@interface TSRecommendCell()

@property(nonatomic, strong) UIImageView *imgView;
@property(nonatomic, strong) UILabel *contentLabel;

@property(nonatomic, strong) UILabel *signLabel;
@property(nonatomic, strong) UILabel *retailPriceLabel;

@property(nonatomic, strong) UILabel *goodsPriceLabel;
@property(nonatomic, strong) UIView *seperateView;

//最高价
@property (nonatomic, strong) TSRecommendMaxPriceView * maxPriceView;

@end

@implementation TSRecommendCell

-(void)fillCustomContentView{
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.signLabel];
    [self.contentView addSubview:self.retailPriceLabel];
    [self.contentView addSubview:self.goodsPriceLabel];
    [self.contentView addSubview:self.seperateView];
    [self.contentView addSubview:self.maxPriceView];
    
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(15);
        make.width.height.mas_equalTo(88);
        make.centerY.equalTo(self.contentView);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgView.mas_right).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-16);
        make.top.equalTo(self.contentView).offset(6);
    }];
    
    [self.seperateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgView.mas_right).offset(15);
        make.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-1);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.goodsPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgView.mas_right).offset(15);
        make.right.equalTo(self.contentView);
        make.bottom.equalTo(self.seperateView.mas_top).offset(-5);
        make.height.mas_equalTo(16);
    }];
    
    [self.signLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.imgView.mas_right).offset(15);
        make.bottom.equalTo(self.goodsPriceLabel.mas_top).offset(-3);
        make.height.mas_equalTo(24);
        make.width.mas_equalTo(10);
    }];
    
    [self.retailPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.signLabel.mas_right).offset(2);
        make.right.equalTo(self.maxPriceView.mas_left);
        make.centerY.equalTo(self.signLabel);
    }];
    
    [self.maxPriceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-23);
        make.centerY.equalTo(self.signLabel);
        make.size.sizeOffset(CGSizeMake(KRateW(69), KRateH(18)));
    }];
}

#pragma mark - Getter
-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.backgroundColor = [UIColor clearColor];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imgView;
}

-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = KRegularFont(14);
        _contentLabel.textAlignment = NSTextAlignmentLeft;
        _contentLabel.textColor = KTextColor;
        _contentLabel.text = @"";
        _contentLabel.numberOfLines = 2;
    }
    return _contentLabel;
}

-(UILabel *)signLabel{
    if (!_signLabel) {
        _signLabel = [[UILabel alloc] init];
        _signLabel.font = KRegularFont(16);
        _signLabel.textAlignment = NSTextAlignmentLeft;
        _signLabel.textColor = KMainColor;
        _signLabel.text = @"¥";
    }
    return _signLabel;
}

-(UILabel *)retailPriceLabel{
    if (!_retailPriceLabel) {
        _retailPriceLabel = [[UILabel alloc] init];
        _retailPriceLabel.font = KFont(PingFangSCMedium, 20);
        _retailPriceLabel.textAlignment = NSTextAlignmentLeft;
        _retailPriceLabel.textColor = KMainColor;
        _retailPriceLabel.text = @"";
    }
    return _retailPriceLabel;
}

-(UILabel *)goodsPriceLabel{
    if (!_goodsPriceLabel) {
        _goodsPriceLabel = [[UILabel alloc] init];
        _goodsPriceLabel.font = KRegularFont(8);
        _goodsPriceLabel.textAlignment = NSTextAlignmentLeft;
        _goodsPriceLabel.textColor = KHexAlphaColor(@"#333333", 0.6);
        _goodsPriceLabel.text = @"提货价¥";
    }
    return _goodsPriceLabel;
}

-(UIView *)seperateView{
    if (!_seperateView) {
        _seperateView = [[UIView alloc] init];
        _seperateView.backgroundColor = KlineColor;
    }
    return _seperateView;
}

- (TSRecommendMaxPriceView *)maxPriceView {
    if (!_maxPriceView) {
        _maxPriceView = [[TSRecommendMaxPriceView alloc] init];
    }
    return _maxPriceView;
}

-(void)setDelegate:(id<UniversalCollectionViewCellDataDelegate>)delegate{
    TSCategorySectionRecommendItemModel *item = [delegate universalCollectionViewCellModel:self.indexPath];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:item.imageUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
    }];
    self.contentLabel.text = item.productName;
    self.retailPriceLabel.text = [NSString stringWithFormat:@"%@",item.price];
    self.goodsPriceLabel.text = [NSString stringWithFormat:@"提货价¥%@",item.staffPrice];
    self.maxPriceView.maxPrice = item.earnMost;
}

@end
