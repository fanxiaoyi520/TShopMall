//
//  TSPaySuccessRecomendHeaderView.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/28.
//

#import "TSPaySuccessRecomendHeaderView.h"

@interface TSPaySuccessRecomendHeaderView()
@property (nonatomic, strong) UILabel *title;
@end

@implementation TSPaySuccessRecomendHeaderView


-(void)layoutSubviews{
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.bottom.equalTo(self);
    }];
}

- (UILabel *)title{
    if (_title) {
        return _title;
    }
    self.title = [UILabel new];
    self.title.text = @"热销推荐";
    self.title.font  = KFont(PingFangSCMedium, 14.0);
    self.title.textColor = KHexColor(@"#2D3132");
    [self addSubview:self.title];
    
    return self.title;
}

@end
