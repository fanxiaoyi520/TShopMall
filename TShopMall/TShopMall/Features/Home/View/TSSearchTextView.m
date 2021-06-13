//
//  TSSearchTextView.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/12.
//

#import "TSSearchTextView.h"

@implementation TSSearchTextView

- (instancetype)init{
    if (self == [super init]) {
        self.layer.cornerRadius = KRateW(16.0);
        self.layer.masksToBounds = YES;
        self.backgroundColor = KHexColor(@"#F4F4F5");
    }
    return self;
}

- (void)layoutSubviews{
    [self.indeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.width.height.mas_offset(KRateW(18.0));
        make.left.equalTo(self.mas_left).offset(KRateW(10.0));
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-KRateW(10.0));
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.indeImg.mas_right).offset(KRateW(10.0));
    }];
}

- (UIImageView *)indeImg{
    if (_indeImg) {
        return _indeImg;
    }
    self.indeImg = [UIImageView new];
    self.indeImg.image = KImageMake(@"mall_home_search");
    [self addSubview:self.indeImg];
    
    return self.indeImg;
}

- (UITextField *)textField{
    if (_textField) {
        return _textField;
    }
    self.textField = [UITextField new];
    self.textField.delegate = self;
    self.textField.returnKeyType = UIReturnKeySearch;
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [self.textField setPlaceholderColor:[KHexColor(@"#2D3132") colorWithAlphaComponent:0.6] fontType:PingFangSCRegular fontSize:12.0];
    [self.textField setTextColor:KHexColor(@"#2D3132") fontType:PingFangSCRegular fontSize:12.0];
    self.textField.placeholder = @"请输入商品编号";
    [self addSubview:self.textField];
    
    return self.textField;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField endEditing:YES];
    self.startSearch(textField.text);
    return self;
}

@end
