//
//  TSCartCell.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/8.
//

#import "TSCartCell.h"
#import "TSCartModel.h"
#import "TSNumOperationView.h"

@interface TSCartCell()
@property (nonatomic, strong) UIButton *selBtn;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *specification;
@property (nonatomic, strong) UILabel *priceTitle;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) TSNumOperationView *numView;
@property (nonatomic, strong) TSCartGiftButton *giftBtn;
@property (nonatomic, strong) UILabel *notEnough;

@property (nonatomic, strong) TSCart *cart;
@end

@implementation TSCartCell

- (void)dealloc{
    [self.obj removeObserver:self];
}

- (void)setObj:(id)obj{
     self.cart = (TSCart *)obj;
//    [self configGiftView];
    
    self.selBtn.selected = self.cart.checked;
    [self.icon sd_setImageWithURL:[NSURL URLWithString:self.cart.productImgUrl]];
    self.name.text = self.cart.productName;
    self.specification.text = self.cart.parentSkuNo;
    self.numView.hidden  = NO;
    self.numView.number.text = [NSString stringWithFormat:@"%ld", self.cart.buyNum];
    self.priceTitle.text = @"提货价";
    self.price.text = [NSString stringWithFormat:@"¥%d", self.cart.singleMarketPrice.intValue];
    
    [self.cart addObserver:self forKeyPath:@"checked" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
    
    self.notEnough.hidden = self.cart.isEnough;
    self.notEnough.text = @"库存紧张";
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"checked"]) {
        self.cart = (TSCart *)object;
        self.selBtn.selected = self.cart.checked;
    }
}

- (void)testUI{
    self.selBtn.selected = NO;
    self.icon.image = KImageMake(@"image_test");
    self.name.text = @"XESS 65寸 家庭浮窗场景TV标题标题 标题踢踢踢标题踢踢踢标…";
    self.specification.text = @"已选规格";
    self.numView.hidden  = NO;
    self.priceTitle.text = @"提货价";
    self.price.text = @"¥ 4999";
}

- (void)configGiftView{
//    if (self.cartModel.hasGift) {
//        self.giftBtn.hidden = NO;
//        self.giftBtn.tips.text = @"赠品: ";
//        self.giftBtn.img.image = KImageMake(@"image_test");
//        self.giftBtn.name.text = @"产品信息和标题标题产品信息和标题标题…";
//        self.giftBtn.indeImg.image = KImageMake(@"inde_right_small");
//    } else {
//        self.giftBtn.hidden = YES;
//    }
//    [self.price mas_updateConstraints:^(MASConstraintMaker *make) {
//           make.bottom.equalTo(self.contentView.mas_bottom).offset(-KRateW(self.cartModel.hasGift? 52:16));
//       }];
}

- (void)selBtnAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    self.cart.checked = sender.selected;
    [self.delegate goodsSelected:self.cart indexPath:self.indexPath];
}

- (void)checkGift{
    [self.delegate checkGift:self.cart];
}

- (void)layoutView{
    [self.selBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(KRateW(50.0));
        make.width.height.mas_equalTo(KRateW(20.0));
        make.left.equalTo(self.contentView.mas_left).offset(KRateW(14.0));
    }];
    
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.selBtn.mas_right).offset(KRateW(22.0));
        make.top.equalTo(self.contentView.mas_top).offset(KRateW(16.0));
        make.width.height.mas_equalTo(KRateW(88.0)).priorityHigh();
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon.mas_right).offset(KRateW(8.0));
        make.top.equalTo(self.contentView.mas_top).offset(KRateW(16.0));
        make.right.equalTo(self.contentView.mas_right).offset(-KRateW(16.0));
    }];
    
    [self.specification mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.name);
        make.top.equalTo(self.name.mas_bottom).offset(KRateW(4.0));
        make.height.mas_equalTo(KRateW(18.0));
    }];
    
    [self.priceTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.name.mas_left);
        make.centerY.equalTo(self.icon.mas_bottom);
        make.height.mas_equalTo(KRateW(18.0));
        make.width.mas_equalTo(KRateW(42.0)).priorityHigh();
    }];
    
    [self.numView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.name.mas_right);
        make.centerY.equalTo(self.priceTitle);
        make.height.mas_equalTo(KRateW(20.0));
    }];
    
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceTitle.mas_right).offset(KRateW(3.0)).priorityHigh();
        make.right.equalTo(self.numView.mas_left).offset(-KRateW(8.0));
        make.centerY.equalTo(self.priceTitle);
        make.height.mas_equalTo(KRateW(24.0));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-KRateW(16.0));
    }];
    
    [self.giftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.name.mas_right);
        make.height.mas_equalTo(KRateW(20.0));
        make.left.equalTo(self.name.mas_left);
        make.top.mas_equalTo(self.price.mas_bottom).offset(KRateW(16.0));
    }];
    
    [self.notEnough mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.icon);
        make.bottom.equalTo(self.icon.mas_bottom);
        make.height.mas_equalTo(KRateW(18.0));
    }];
}

- (UIButton *)selBtn{
    if (_selBtn) {
        return _selBtn;
    }
    self.selBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.selBtn setBackgroundImage:KImageMake(@"btn_normal") forState:UIControlStateNormal];
    [self.selBtn setBackgroundImage:KImageMake(@"btn_sel") forState:UIControlStateSelected];
    [self.selBtn addTarget:self action:@selector(selBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.selBtn];
    
    return self.selBtn;
}

- (UIImageView *)icon{
    if (_icon) {
        return _icon;
    }
    self.icon = [UIImageView new];
    self.icon.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.icon];
    
    return self.icon;
}

- (UILabel *)name{
    if (_name) {
        return _name;
    }
    self.name = [UILabel new];
    self.name.numberOfLines = 2;
    self.name.font = KFont(PingFangSCRegular, 14.0);
    self.name.textColor = KHexColor(@"#2D3132");
    [self.contentView addSubview:self.name];
    
    return self.name;
}

- (UILabel *)specification{
    if (_specification) {
        return _specification;
    }
    self.specification = [UILabel new];
    self.specification.font = KFont(PingFangSCRegular, 12.0);
    self.specification.textColor = [KHexColor(@"#2D3132") colorWithAlphaComponent:0.6];
    [self.contentView addSubview:self.specification];
    
    return self.specification;
}

- (UILabel *)priceTitle{
    if (_priceTitle) {
        return _priceTitle;
    }
    self.priceTitle = [UILabel new];
    self.priceTitle.font = KFont(PingFangSCRegular, 12.0);
    self.priceTitle.textColor = [KHexColor(@"#2D3132") colorWithAlphaComponent:0.6];
    [self.contentView addSubview:self.priceTitle];
    
    return self.priceTitle;
}

- (TSNumOperationView *)numView{
    if (_numView) {
        return _numView;
    }
    self.numView = [TSNumOperationView new];
    self.numView.min = 1;
    [self.contentView addSubview:self.numView];
    __weak typeof(self) weakSelf = self;
    self.numView.numberOperationDone = ^(NSInteger currentNumber, NumOperationType type) {
        weakSelf.cart.buyNum = currentNumber;
        [weakSelf.delegate changeGoodsBuyNumberOfCart:weakSelf.cart];
    };
    
    return self.numView;
}

- (UILabel *)price{
    if (_price) {
        return _price;
    }
    self.price = [UILabel new];
    self.price.font = KFont(PingFangSCMedium,16.0);
    self.price.textColor = KHexColor(@"#E64C3D");
    [self.contentView addSubview:self.price];
    
    return self.price;
}

- (TSCartGiftButton *)giftBtn{
    if (_giftBtn) {
        return _giftBtn;
    }
    self.giftBtn = [TSCartGiftButton new];
    [self.giftBtn addTarget:self action:@selector(checkGift) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.giftBtn];
    
    return self.giftBtn;
}

- (UILabel *)notEnough{
    if (_notEnough) {
        return _notEnough;
    }
    self.notEnough = [UILabel new];
    self.notEnough.backgroundColor = KHexColor(@"ffffff");
    self.notEnough.font = KRegularFont(12.0);
    self.notEnough.textColor = KHexColor(@"#E64C3D");
    self.notEnough.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.notEnough];
    
    return self.notEnough;
}

@end

@implementation TSCartGiftButton

- (void)layoutSubviews{
    [self.indeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.centerY.equalTo(self);
        make.width.height.mas_equalTo(KRateW(12.0));
    }];
    
    [self.tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.mas_left);
        make.width.mas_equalTo(KRateW(36.0));
    }];
    
    [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tips.mas_right).offset(KRateW(3.0));
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(KRateW(20.0));
    }];
    
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.img.mas_right).offset(KRateW(6.0));
        make.top.bottom.equalTo(self);
        make.right.equalTo(self.indeImg.mas_left).offset(-KRateW(6.0));
    }];
}

- (UIImageView *)indeImg{
    if (_indeImg) {
        return _indeImg;
    }
    self.indeImg = [UIImageView new];
    [self addSubview:self.indeImg];
    
    return self.indeImg;
}

- (UILabel *)tips{
    if (_tips) {
        return _tips;
    }
    self.tips = [UILabel new];
    [self.tips setTextColor:KHexColor(@"#2D3132")];
    self.tips.font = KFont(PingFangSCRegular, 12.0);
    [self addSubview:self.tips];
    
    return self.tips;
}

- (UIImageView *)img{
    if (_img) {
        return _img;
    }
    self.img = [UIImageView new];
    [self addSubview:self.img];
    
    return self.img;
}

- (UILabel *)name{
    if (_name) {
        return _name;
    }
    self.name = [UILabel new];
    self.name.textColor = KHexColor(@"#2D3132");
    self.name.font = KFont(PingFangSCRegular, 12.0);
    [self addSubview:self.name];
    
    return self.name;
}
@end
