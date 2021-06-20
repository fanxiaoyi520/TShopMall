//
//  TSGoodDetailPriceCell.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/15.
//

#import "TSGoodDetailPriceCell.h"

@interface TSGoodDetailPriceCell()

/// 统一售价标识
@property (nonatomic, strong) UILabel *unifiedLable;
/// 统一售价
@property (nonatomic, strong) UILabel *unifiedPriceLable;
/// 提货价
@property (nonatomic, strong) UILabel *deliveryLable;
/// 最高赚
@property(nonatomic, strong) UILabel *earnLabel;
/// 最高赚金额背景
@property(nonatomic, strong) UIView *earnMoneyView;
/// 最高赚金额
@property(nonatomic, strong) UILabel *earnMoneyLabel;

@end

@implementation TSGoodDetailPriceCell

-(void)fillCustomContentView{
    self.contentView.backgroundColor = UIColor.whiteColor;
    
    [self.contentView addSubview:self.deliveryLable];
    [self.contentView addSubview:self.unifiedLable];
    [self.contentView addSubview:self.unifiedPriceLable];
    [self.contentView addSubview:self.earnMoneyView];
    [self.earnMoneyView addSubview:self.earnMoneyLabel];
    [self.contentView addSubview:self.earnLabel];
    
    [self.unifiedLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.top.equalTo(self.contentView).offset(16);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(30);
    }];
    
    [self.unifiedPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.unifiedLable.mas_right).offset(2);
        make.centerY.equalTo(self.unifiedLable);
        make.height.mas_equalTo(36);
    }];
    
    [self.deliveryLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.bottom.equalTo(self.contentView).offset(-11);
        make.height.mas_equalTo(18);
    }];
    
    [self.earnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.unifiedPriceLable.mas_right).offset(21);
        make.centerY.equalTo(self.unifiedLable);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(20);
    }];
    
    [self.earnMoneyLabel sizeToFit];
    CGFloat width = self.earnMoneyLabel.size.width + 20;
    
    [self.earnMoneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.earnLabel.mas_right).offset(-10);
        make.centerY.equalTo(self.unifiedLable);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(20);
    }];
    
    [self.earnMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.earnMoneyView.mas_right).offset(-5);
        make.centerY.equalTo(self.earnMoneyView);
    }];
}


#pragma mark - Getter
-(UILabel *)unifiedLable{
    if (!_unifiedLable) {
        _unifiedLable = [[UILabel alloc] init];
        _unifiedLable.font = KFont(PingFangSCMedium, 20);
        _unifiedLable.textColor = KMainColor;
        _unifiedLable.text = @"¥";
    }
    return _unifiedLable;
}

-(UILabel *)unifiedPriceLable{
    if (!_unifiedPriceLable) {
        _unifiedPriceLable = [[UILabel alloc] init];
        _unifiedPriceLable.font = KFont(PingFangSCMedium, 24);
        _unifiedPriceLable.textColor = KMainColor;
        _unifiedPriceLable.text = @"899999";
    }
    return _unifiedPriceLable;
}

-(UILabel *)deliveryLable{
    if (!_deliveryLable) {
        _deliveryLable = [[UILabel alloc] init];
        _deliveryLable.font = KRegularFont(12);
        _deliveryLable.textColor = KHexAlphaColor(@"#2D3132", 0.4);
        _deliveryLable.text = @"提货价 ¥10800";
    }
    return _deliveryLable;
}

-(UILabel *)earnLabel{
    if (!_earnLabel) {
        _earnLabel = [[UILabel alloc] init];
        _earnLabel.font = KRegularFont(14);
        _earnLabel.textColor = KWhiteColor;
        _earnLabel.backgroundColor = KHexColor(@"#F9AB50");
        _earnLabel.textAlignment = NSTextAlignmentCenter;
        [_earnLabel setCorners:(UIRectCornerTopRight | UIRectCornerBottomRight) radius:10];
        _earnLabel.clipsToBounds = YES;
        _earnLabel.text = @"最高赚";
    }
    return _earnLabel;
}

-(UIView *)earnMoneyView{
    if (!_earnMoneyView) {
        _earnMoneyView = [[UIView alloc] init];
        _earnMoneyView.backgroundColor = KHexColor(@"#FF4D49");
        _earnMoneyView.clipsToBounds = YES;
        [_earnMoneyView setCorners:(UIRectCornerTopRight | UIRectCornerBottomRight) radius:3];
    }
    return _earnMoneyView;
}


-(UILabel *)earnMoneyLabel{
    if (!_earnMoneyLabel) {
        _earnMoneyLabel = [[UILabel alloc] init];
        _earnMoneyLabel.font = KRegularFont(14);
        _earnMoneyLabel.textColor = KWhiteColor;
        _earnMoneyLabel.text = @"¥19999";
        _earnMoneyLabel.textAlignment = NSTextAlignmentRight;
    }
    return _earnMoneyLabel;
}

@end
