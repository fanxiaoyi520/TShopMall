//
//  TSRecomendHeaderTitleView.m
//  TShopMall
//
//  Created by 橙子 on 2021/7/5.
//

#import "TSRecomendHeaderTitleView.h"

@interface TSRecomendHeaderTitleView()
@property (nonatomic, strong) UILabel *title;
@end

@implementation TSRecomendHeaderTitleView

- (void)updateTitle:(NSString *)title textAlignment:(NSTextAlignment)textAlignment{
    self.title.text = title;
    self.title.textAlignment = textAlignment;
}

- (void)layoutSubviews{
    self.backgroundColor = UIColor.clearColor;
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(KRateW(16.0));
        make.right.equalTo(self.mas_right).offset(-KRateW(16.0));
        make.centerY.equalTo(self);
        make.height.mas_equalTo(KRateW(24.0));
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


@end
