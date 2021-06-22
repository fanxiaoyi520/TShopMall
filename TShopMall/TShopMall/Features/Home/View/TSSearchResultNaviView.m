//
//  TSSearchResultNaviView.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/21.
//

#import "TSSearchResultNaviView.h"

@implementation TSSearchResultNaviView

- (instancetype)init{
    if (self == [super init]) {
        self.backgroundColor = UIColor.whiteColor;
    }
    return self;
}

- (void)layoutSubviews{
    [self.typeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-KRateW(16.0));
        make.width.height.mas_equalTo(KRateW(24.0));
        make.bottom.equalTo(self.mas_bottom).offset(-KRateW(10.0));
    }];
    
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(KRateW(8.0));
        make.centerY.equalTo(self.typeBtn);
        make.width.height.mas_equalTo(KRateW(32.0)).priorityHigh();
    }];
    
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backBtn.mas_right).offset(KRateW(8.0));
        make.centerY.equalTo(self.typeBtn.mas_centerY);
        make.right.equalTo(self.typeBtn.mas_left).offset(-KRateW(8.0));
        make.height.mas_equalTo(KRateW(32.0));
    }];
}

- (UIButton *)backBtn{
    if (_backBtn) {
        return _backBtn;
    }
    self.backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backBtn setBackgroundImage:KImageMake(@"navi_back") forState:UIControlStateNormal];
    [self addSubview:self.backBtn];
    
    return self.backBtn;
}

- (TSSearchTextView *)searchView{
    if (_searchView) {
        return _searchView;
    }
    self.searchView = [TSSearchTextView new];
    self.searchView.frame = CGRectMake(0, 0, KRateW(250.0), KRateW(32.0));
    [self addSubview:self.searchView];
    
    return self.searchView;
}

- (UIButton *)typeBtn{
    if (_typeBtn) {
        return _typeBtn;
    }
    self.typeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.typeBtn.frame = CGRectMake(0, 0, KRateW(24), KRateW(24.0));
    [self.typeBtn setBackgroundImage:KImageMake(@"mall_category_btn_gird") forState:UIControlStateNormal];
    [self.typeBtn setBackgroundImage:KImageMake(@"mall_category_btn_rail") forState:UIControlStateSelected];
    [self addSubview:self.typeBtn];
    
    return self.typeBtn;
}

@end
