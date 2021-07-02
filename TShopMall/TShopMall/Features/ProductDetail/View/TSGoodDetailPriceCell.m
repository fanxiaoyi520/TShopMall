//
//  TSGoodDetailPriceCell.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/15.
//

#import "TSGoodDetailPriceCell.h"
#import "TSGoodDetailItemModel.h"

@interface TSGoodDetailPriceCell()

/// 统一售价标识
@property (nonatomic, strong) UILabel *unifiedLable;
/// 统一售价
@property (nonatomic, strong) UILabel *unifiedPriceLable;
/// 提货价
@property (nonatomic, strong) UILabel *deliveryLable;
/// 提货价值
@property (nonatomic, strong) UILabel *deliveryValueLable;
/// 最高赚背景图
@property(nonatomic, strong) UIView *earnView;
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
    [self.contentView addSubview:self.deliveryValueLable];
    [self.contentView addSubview:self.unifiedLable];
    [self.contentView addSubview:self.unifiedPriceLable];
    [self.contentView addSubview:self.earnMoneyView];
    [self.earnMoneyView addSubview:self.earnMoneyLabel];
    [self.contentView addSubview:self.earnView];
    [self.earnView addSubview:self.earnLabel];
    
    [self.unifiedLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.top.equalTo(self.contentView).offset(21);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
    }];
    
    [self.unifiedPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.unifiedLable.mas_right).offset(2);
        make.centerY.equalTo(self.unifiedLable);
        make.height.mas_equalTo(24);
    }];
    
    [self.deliveryLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.bottom.equalTo(self.contentView).offset(-14);
        make.height.mas_equalTo(12);
    }];

    [self.deliveryValueLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.deliveryLable.mas_right).offset(5);
        make.centerY.equalTo(self.deliveryLable);
    }];

    [self.earnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.unifiedPriceLable.mas_right).offset(19);
        make.centerY.equalTo(self.unifiedPriceLable);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(53);
    }];

    [self.earnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.earnView);
    }];

    [self.earnMoneyLabel sizeToFit];
    CGFloat width = self.earnMoneyLabel.size.width + 20;
    if (width < 51) {
        width = 51;
    }

    [self.earnMoneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.earnView.mas_right).offset(-10);
        make.centerY.equalTo(self.earnView);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(20);
    }];

    [self.earnMoneyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.earnMoneyView.mas_left).offset(10);
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
        _unifiedPriceLable.text = @"";
    }
    return _unifiedPriceLable;
}

-(UILabel *)deliveryLable{
    if (!_deliveryLable) {
        _deliveryLable = [[UILabel alloc] init];
        _deliveryLable.font = KRegularFont(12);
        _deliveryLable.textColor = KHexAlphaColor(@"#2D3132", 0.4);
        _deliveryLable.text = @"提货价";
    }
    return _deliveryLable;
}

-(UILabel *)deliveryValueLable{
    if (!_deliveryValueLable) {
        _deliveryValueLable = [[UILabel alloc] init];
        _deliveryValueLable.font = KRegularFont(12);
        _deliveryValueLable.textColor = KHexAlphaColor(@"#2D3132", 0.4);
        _deliveryValueLable.text = @"";
    }
    return _deliveryValueLable;
}

-(UIView *)earnView{
    if (!_earnView) {
        _earnView = [[UIView alloc] init];
        _earnView.backgroundColor = [UIColor clearColor];
        [_earnView setCorners:(UIRectCornerTopLeft | UIRectCornerBottomLeft) radius:3];
        _earnView.clipsToBounds = YES;
    }
    return _earnView;
}

-(UILabel *)earnLabel{
    if (!_earnLabel) {
        _earnLabel = [[UILabel alloc] init];
        _earnLabel.font = KRegularFont(12);
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
        _earnMoneyLabel.font = KRegularFont(12);
        _earnMoneyLabel.textColor = KWhiteColor;
        _earnMoneyLabel.text = @"";
        _earnMoneyLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _earnMoneyLabel;
}

-(void)setDelegate:(id<UniversalCollectionViewCellDataDelegate>)delegate{
    TSGoodDetailItemPriceModel *item = [delegate universalCollectionViewCellModel:self.indexPath];
    
    if (!item.marketPrice) {
        self.unifiedPriceLable.text = @"";
        self.deliveryValueLable.text = @"";
        self.earnMoneyLabel.text = @"";
    }else{
        self.unifiedPriceLable.text = [NSString stringWithFormat:@"%@",item.marketPrice];
        self.deliveryValueLable.text = [NSString stringWithFormat:@"¥ %@",item.staffPrice];
        self.earnMoneyLabel.text = [NSString stringWithFormat:@"¥%@",item.earnMost];
    }
}

@end
