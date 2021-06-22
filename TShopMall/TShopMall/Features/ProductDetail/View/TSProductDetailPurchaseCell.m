//
//  TSProductDetailPurchaseCell.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/15.
//

#import "TSProductDetailPurchaseCell.h"

@interface TSProductDetailPurchaseCell()

/// 背景视图
@property(nonatomic, strong) UIView *bgView;
/// 赠品
@property(nonatomic, strong) UILabel *giftLabel;
/// 赠品图片
@property(nonatomic, strong) UIImageView *giftImageView;
/// 赠品名称
@property(nonatomic, strong) UILabel *giftNameLabel;
/// 赠品更多
@property(nonatomic, strong) UIButton *giftButton;
/// 分割线1
@property(nonatomic, strong) UIView *seperateOne;
/// 已选
@property(nonatomic, strong) UILabel *selectLabel;
/// 已选
@property(nonatomic, strong) UILabel *selectValueLabel;
/// 已选更多
@property(nonatomic, strong) UIButton *selectButton;
/// 分割线2
@property(nonatomic, strong) UIView *seperateTwo;
/// 配送
@property(nonatomic, strong) UILabel *deliveryLabel;
/// 配送值
@property(nonatomic, strong) UILabel *deliveryValueLabel;
/// 配送更多
@property(nonatomic, strong) UIButton *deliveryButton;
/// 有货
@property(nonatomic, strong) UILabel *flagLabel;
/// 运费
@property(nonatomic, strong) UIButton *feeButton;

@end

@implementation TSProductDetailPurchaseCell

-(void)fillCustomContentView{
    self.contentView.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.giftLabel];
    [self.bgView addSubview:self.giftImageView];
    [self.bgView addSubview:self.giftNameLabel];
    [self.bgView addSubview:self.giftButton];
    [self.bgView addSubview:self.seperateOne];
    [self.bgView addSubview:self.selectLabel];
    [self.bgView addSubview:self.selectValueLabel];
    [self.bgView addSubview:self.selectButton];
    [self.bgView addSubview:self.seperateTwo];
    [self.bgView addSubview:self.deliveryLabel];
    [self.bgView addSubview:self.deliveryValueLabel];
    [self.bgView addSubview:self.deliveryButton];
    [self.bgView addSubview:self.flagLabel];
    [self.bgView addSubview:self.feeButton];

    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [self.giftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(16);
        make.top.equalTo(self.bgView).offset(18);
        make.height.mas_equalTo(18);
        make.width.mas_equalTo(24);
    }];
    
    [self.giftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.giftLabel.mas_right).offset(11);
        make.centerY.equalTo(self.giftLabel);
        make.width.height.mas_equalTo(40);
    }];
    
    [self.giftNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.giftImageView.mas_right).offset(8);
        make.centerY.equalTo(self.giftLabel);
        make.height.mas_equalTo(22);
    }];
    
    [self.giftButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView.mas_right).offset(-10);
        make.width.height.mas_equalTo(40);
        make.centerY.equalTo(self.giftLabel);
    }];
    
    [self.seperateOne mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(50);
        make.top.equalTo(self.bgView).offset(55);
        make.right.equalTo(self.bgView);
        make.height.mas_equalTo(0.3);
    }];
    
    [self.selectLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(16);
        make.top.equalTo(self.seperateOne.mas_bottom).offset(16);
        make.height.mas_equalTo(18);
        make.width.mas_equalTo(24);
    }];
    
    [self.selectValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selectLabel.mas_right).offset(16);
        make.top.equalTo(self.selectLabel);
        make.right.equalTo(self.bgView.mas_right).offset(-60);
    }];
    
    [self.selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView.mas_right).offset(-10);
        make.width.height.mas_equalTo(40);
        make.centerY.equalTo(self.selectValueLabel);
    }];
    
    [self.seperateTwo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(50);
        make.top.equalTo(self.seperateOne.mas_bottom).offset(75);
        make.right.equalTo(self.bgView);
        make.height.mas_equalTo(0.3);
    }];
    
    [self.deliveryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(16);
        make.top.equalTo(self.seperateTwo.mas_bottom).offset(18);
        make.height.mas_equalTo(18);
        make.width.mas_equalTo(24);
    }];
    
    [self.deliveryValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.deliveryLabel.mas_right).offset(16);
        make.top.equalTo(self.seperateTwo.mas_bottom).offset(16);
        make.right.equalTo(self.bgView.mas_right).offset(-60);
    }];
    
    [self.deliveryButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView.mas_right).offset(-10);
        make.width.height.mas_equalTo(40);
        make.centerY.equalTo(self.deliveryValueLabel);
    }];
    
    [self.flagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.deliveryValueLabel);
        make.width.height.mas_equalTo(28);
        make.bottom.equalTo(self.bgView).offset(-5);
    }];
    
    [self.feeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.flagLabel.mas_right).offset(16);
        make.height.mas_equalTo(30);
        make.centerY.equalTo(self.flagLabel);
    }];
}

#pragma mark - Actions
-(void)giftMoreAction:(UIButton *)sender{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"TSProductDetailPurchaseCell" forKey:@"cellType"];
    [params setValue:@(PurchaseCellMoreTypeGift) forKey:@"purchaseType"];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(universalCollectionViewCellClick:params:)]) {
        [self.delegate universalCollectionViewCellClick:self.indexPath params:params];
    }
}

-(void)selectMoreAction:(UIButton *)sender{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"TSProductDetailPurchaseCell" forKey:@"cellType"];
    [params setValue:@(PurchaseCellMoreTypeSelected) forKey:@"purchaseType"];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(universalCollectionViewCellClick:params:)]) {
        [self.delegate universalCollectionViewCellClick:self.indexPath params:params];
    }
}

-(void)deliveryAction:(UIButton *)sender{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"TSProductDetailPurchaseCell" forKey:@"cellType"];
    [params setValue:@(PurchaseCellMoreTypeDelivery) forKey:@"purchaseType"];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(universalCollectionViewCellClick:params:)]) {
        [self.delegate universalCollectionViewCellClick:self.indexPath params:params];
    }
}

-(void)feeAction:(UIButton *)sender{
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [params setValue:@"TSProductDetailPurchaseCell" forKey:@"cellType"];
    [params setValue:@(PurchaseCellMoreTypeFee) forKey:@"purchaseType"];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(universalCollectionViewCellClick:params:)]) {
        [self.delegate universalCollectionViewCellClick:self.indexPath params:params];
    }
}

#pragma mark - Getter
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = UIColor.whiteColor;
        [_bgView setCorners:UIRectCornerAllCorners radius:9];
    }
    return _bgView;
}

-(UILabel *)giftLabel{
    if (!_giftLabel) {
        _giftLabel = [[UILabel alloc] init];
        _giftLabel.font = KRegularFont(12);
        _giftLabel.textColor = KHexAlphaColor(@"#2D3132", 0.4);
        _giftLabel.text = @"赠品";
    }
    return _giftLabel;
}

-(UIImageView *)giftImageView{
    if (!_giftImageView) {
        _giftImageView = [[UIImageView alloc] init];
        _giftImageView.backgroundColor = KHexColor(@"#F5EDED");
    }
    return _giftImageView;
}

-(UILabel *)giftNameLabel{
    if (!_giftNameLabel) {
        _giftNameLabel = [[UILabel alloc] init];
        _giftNameLabel.font = KFont(PingFangSCRegular, 14);
        _giftNameLabel.textColor = KTextColor;
        _giftNameLabel.text = @"赠品名称";
    }
    return _giftNameLabel;
}

-(UIButton *)giftButton{
    if (!_giftButton) {
        _giftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_giftButton setImage:KImageMake(@"mall_detail_more") forState:UIControlStateNormal];
        [_giftButton setImage:KImageMake(@"mall_detail_more") forState:UIControlStateHighlighted];
        [_giftButton addTarget:self action:@selector(giftMoreAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _giftButton;
}

-(UIView *)seperateOne{
    if (!_seperateOne) {
        _seperateOne = [[UIView alloc] init];
        _seperateOne.backgroundColor = KlineColor;
    }
    return _seperateOne;
}

-(UILabel *)selectLabel{
    if (!_selectLabel) {
        _selectLabel = [[UILabel alloc] init];
        _selectLabel.font = KRegularFont(12);
        _selectLabel.textColor = KHexAlphaColor(@"#2D3132", 0.4);
        _selectLabel.text = @"已选";
    }
    return _selectLabel;
}

-(UILabel *)selectValueLabel{
    if (!_selectValueLabel) {
        _selectValueLabel = [[UILabel alloc] init];
        _selectValueLabel.font = KRegularFont(14);
        _selectValueLabel.textColor = KTextColor;
        _selectValueLabel.text = @"已选：珠光黑/一体包/3200，彩电-5已选：珠光黑/一体包/3200，彩电-5已选：珠光黑/一体包/3200，彩电-5";
        _selectValueLabel.numberOfLines = 2;
    }
    return _selectValueLabel;
}

-(UIButton *)selectButton{
    if (!_selectButton) {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_selectButton setImage:KImageMake(@"mall_detail_more") forState:UIControlStateNormal];
        [_selectButton setImage:KImageMake(@"mall_detail_more") forState:UIControlStateHighlighted];
        [_selectButton addTarget:self action:@selector(selectMoreAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectButton;
}

-(UIView *)seperateTwo{
    if (!_seperateTwo) {
        _seperateTwo = [[UIView alloc] init];
        _seperateTwo.backgroundColor = KlineColor;
    }
    return _seperateTwo;
}

-(UILabel *)deliveryLabel{
    if (!_deliveryLabel) {
        _deliveryLabel = [[UILabel alloc] init];
        _deliveryLabel.font = KRegularFont(12);
        _deliveryLabel.textColor = KHexAlphaColor(@"#2D3132", 0.4);
        _deliveryLabel.text = @"配送";
    }
    return _deliveryLabel;
}

-(UILabel *)deliveryValueLabel{
    if (!_deliveryValueLabel) {
        _deliveryValueLabel = [[UILabel alloc] init];
        _deliveryValueLabel.font = KRegularFont(14);
        _deliveryValueLabel.textColor = KTextColor;
        _deliveryValueLabel.numberOfLines = 2;
        _deliveryValueLabel.text = @"广东省深圳市南山区西丽街道西丽街道西丽街广东省深圳市南山区西丽街道西丽街道西丽街";
    }
    return _deliveryValueLabel;
}

-(UIButton *)deliveryButton{
    if (!_deliveryButton) {
        _deliveryButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deliveryButton setImage:KImageMake(@"mall_detail_more") forState:UIControlStateNormal];
        [_deliveryButton setImage:KImageMake(@"mall_detail_more") forState:UIControlStateHighlighted];
        [_deliveryButton addTarget:self action:@selector(deliveryAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deliveryButton;
}

-(UILabel *)flagLabel{
    if (!_flagLabel) {
        _flagLabel = [[UILabel alloc] init];
        _flagLabel.font = KRegularFont(14);
        _flagLabel.textColor = KMainColor;
        _flagLabel.text = @"有货";
    }
    return _flagLabel;
}

-(UIButton *)feeButton{
    if (!_feeButton) {
        _feeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_feeButton setTitleColor:KHexAlphaColor(@"#2D3132", 0.4) forState:UIControlStateNormal];
        [_feeButton setTitleColor:KHexAlphaColor(@"#2D3132", 0.4) forState:UIControlStateHighlighted];
        _feeButton.titleLabel.font = KRegularFont(14);
        [_feeButton setTitle:@"运费:￥0.00" forState:UIControlStateNormal];
        [_feeButton addTarget:self action:@selector(feeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _feeButton;
}

@end
