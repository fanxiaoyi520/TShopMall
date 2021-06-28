//
//  TSOfficialServicesCell.m
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/27.
//

#import "TSOfficialServicesCell.h"

@interface TSOfficialServicesCell ()

@property (nonatomic ,strong) UIImageView *iconImageView;
@property (nonatomic ,strong) UILabel *funcLab;
@end

@implementation TSOfficialServicesCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self jaf_layoutSubView];
    }
    return self;
}

- (void)jaf_layoutSubView {
    [self addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(16);
        make.centerX.equalTo(self);
        make.width.height.mas_equalTo(40);
    }];
    
    [self addSubview:self.funcLab];
    [self.funcLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(61);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(self.width);
    }];
}

// MARK: set
- (void)setIconStr:(NSString *)iconStr {
    _iconStr = iconStr;
    _iconImageView.image = KImageMake(_iconStr);
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(16);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(self.iconImageView.image.size.width);
        make.height.mas_equalTo(self.iconImageView.image.size.height);
    }];
}

- (void)setFuncStr:(NSString *)funcStr {
    _funcStr = funcStr;
    _funcLab.text = _funcStr;
}

// MARK: get
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
    }
    return _iconImageView;
}

- (UILabel *)funcLab {
    if (!_funcLab) {
        _funcLab = [UILabel new];
        _funcLab.textColor = KHexColor(@"#000000");
        _funcLab.font = KRegularFont(12);
        _funcLab.text = @"测试数据";
        _funcLab.numberOfLines = 0;
        _funcLab.textAlignment = NSTextAlignmentCenter;
    }
    return _funcLab;
}
@end
