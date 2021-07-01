//
//  TSMakeOrderPriceCell.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/17.
//

#import "TSMakeOrderPriceCell.h"
#import "TSMakeOrderPriceViewModel.h"

@interface TSMakeOrderPriceView : UIView
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UILabel *des;
@end

@interface TSMakeOrderPriceCell()
@property (nonatomic, strong) TSMakeOrderPriceView *thPriceView;
@property (nonatomic, strong) TSMakeOrderPriceView *deliveryView;
@end

@implementation TSMakeOrderPriceCell

- (void)setObj:(id)obj{
    if ([obj isKindOfClass: [TSMakeOrderPriceViewModel class]]) {
        TSMakeOrderPriceViewModel *vm = (TSMakeOrderPriceViewModel *)obj;
        self.thPriceView.des.text  = [NSString stringWithFormat:@"¥ %d", vm.thPrice.intValue];
        self.deliveryView.des.text = [NSString stringWithFormat:@"¥ %d", vm.deliveryPrice.intValue];
    }
}

- (void)configUI{
    self.thPriceView.title.text = @"提货价";
    self.deliveryView.title.text = @"配送费";
}

- (void)layoutSubviews{
    [self.thPriceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(KRateW(30.0));
        make.top.equalTo(self.contentView.mas_top).offset(KRateW(12.0));
    }];
    
    [self.deliveryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.thPriceView);
        make.top.equalTo(self.thPriceView.mas_bottom);
    }];
}

- (TSMakeOrderPriceView *)thPriceView{
    if (_thPriceView) {
        return _thPriceView;
    }
    self.thPriceView = [TSMakeOrderPriceView new];
    [self.contentView addSubview:self.thPriceView];
    
    return self.thPriceView;
}

- (TSMakeOrderPriceView *)deliveryView{
    if (_deliveryView) {
        return _deliveryView;
    }
    self.deliveryView = [TSMakeOrderPriceView new];
    [self.contentView addSubview:self.deliveryView];
    
    return self.deliveryView;
}
@end

@implementation TSMakeOrderPriceView

- (void)layoutSubviews{
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(KRateW(16.0));
        make.top.bottom.equalTo(self);
    }];
    
    [self.des mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-KRateW(16.0));
        make.top.bottom.equalTo(self);
    }];

}

-  (UILabel *)title{
    if (_title) {
        return _title;
    }
    self.title = [UILabel new];
    self.title.font = KRegularFont(14.0);
    self.title.textColor = KHexColor(@"#2D3132");
    [self addSubview:self.title];
    
    return self.title;
}

- (UILabel *)des{
    if (_des) {
        return _des;
    }
    self.des = [UILabel new];
    self.des.font = KRegularFont(14.0);
    self.des.textColor = KHexColor(@"#2D3132");
    [self addSubview:self.des];
    
    return self.des;
}

@end
