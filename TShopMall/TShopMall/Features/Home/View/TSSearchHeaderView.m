//
//  TSSearchHeaderView.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/12.
//

#import "TSSearchHeaderView.h"

@implementation TSSearchHeaderView

- (void)setStr:(NSString *)str{
    _str = str;
    self.title.text = str;
    self.deleteBtn.hidden = YES;
    if ([str isEqual:@"历史搜索"]) {
        self.deleteBtn.hidden = NO;
    }
}

- (void)deleteTapAction{
    if (self.deleteAction) {
        self.deleteAction(self.title.text);
    }
}

- (void)layoutSubviews{
    self.backgroundColor = UIColor.whiteColor;
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(KRateW(16.0));
        make.top.equalTo(self);
        make.height.mas_equalTo(KRateW(32.0));
    }];
    
    [self.deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-KRateW(18.0));
        make.centerY.equalTo(self);
        make.width.mas_equalTo(KRateW(14.0));
        make.height.mas_equalTo(KRateW(15.0));
    }];
}

- (UILabel *)title{
    if (_title) {
        return _title;
    }
    self.title = [UILabel new];
    self.title.font  = KFont(PingFangSCMedium, 14.0);
    self.title.textColor = KHexColor(@"#2D3132");
    [self addSubview:self.title];
    
    return self.title;
}

- (UIButton *)deleteBtn{
    if (_deleteBtn) {
        return _deleteBtn;
    }
    self.deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.deleteBtn setBackgroundImage:KImageMake(@"home_search_delete") forState:UIControlStateNormal];
    [self.deleteBtn addTarget:self action:@selector(deleteTapAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.deleteBtn];
    
    return self.deleteBtn;
}
@end
