//
//  TSMineTitleHeaderView.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/11.
//

#import "TSMineTitleHeaderView.h"

@interface TSMineTitleHeaderView()

/// 标题
@property(nonatomic, strong) UILabel *titleLabel;
/// 分割线
@property(nonatomic, strong) UIView *seperateView;

@end

@implementation TSMineTitleHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self fillCustomView];
    }
    return self;
}

-(void)fillCustomView{
    [self addSubview:self.titleLabel];
    [self addSubview:self.seperateView];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.centerY.equalTo(self);
    }];
    
    [self.seperateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self);
        make.height.mas_equalTo(0.5);
        make.bottom.equalTo(self).offset(-0.5);
    }];
}

-(void)bindMineSectionModel:(TSMineSectionModel *)model{
    self.titleLabel.text = model.headerName;
}

#pragma mark - Getter
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = KFont(PingFangSCMedium, 16);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = KHexColor(@"#333333");
    }
    return _titleLabel;
}

-(UIView *)seperateView{
    if (!_seperateView) {
        _seperateView = [[UIView alloc] init];
        _seperateView.backgroundColor = KlineColor;
    }
    return _seperateView;
}

@end
