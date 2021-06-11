//
//  TSMineOrderHeaderView.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/11.
//

#import "TSMineOrderHeaderView.h"

@interface TSTextImageButton : UIButton

@end

@implementation TSTextImageButton

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupBasic];
    }
    return self;
}

-(void)setupBasic{
    self.backgroundColor = [UIColor whiteColor];
    self.titleLabel.font = KRegularFont(12);
    [self setTitle:@"查看全部订单" forState:UIControlStateNormal];
    [self setImage:KImageMake(@"mall_home_search") forState:UIControlStateNormal];
    [self setTitleColor:KHexAlphaColor(@"#999999", 1.0) forState:UIControlStateNormal];
    [self setTitleColor:KHexAlphaColor(@"#999999", 1.0) forState:UIControlStateHighlighted];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.titleLabel.textAlignment = NSTextAlignmentRight;
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    CGFloat titleW = contentRect.size.width - 12;
    CGFloat titleH = contentRect.size.height;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageW = 6;
    CGFloat imageH = 11;
    CGFloat imageX = contentRect.size.width - 6;
    CGFloat imageY = (contentRect.size.height - imageH) * 0.5;

    return CGRectMake(imageX, imageY, imageW, imageH);
}

-(void)setHighlighted:(BOOL)highlighted{}

@end

@interface TSMineOrderHeaderView ()

/// 标题
@property(nonatomic, strong) UILabel *titleLabel;
/// 查看更多
@property(nonatomic, strong) TSTextImageButton *moreButton;
/// 分割线
@property(nonatomic, strong) UIView *seperateView;

@end

@implementation TSMineOrderHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self fillCustomView];
    }
    return self;
}

-(void)fillCustomView{
    [self addSubview:self.titleLabel];
    [self addSubview:self.moreButton];
    [self addSubview:self.seperateView];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.centerY.equalTo(self);
    }];
    
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-16);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(150);
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

#pragma mark - Actions
-(void)moreAction:(TSTextImageButton *)sender{
    
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

-(TSTextImageButton *)moreButton{
    if (!_moreButton) {
        _moreButton = [TSTextImageButton buttonWithType:UIButtonTypeCustom];
        [_moreButton addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreButton;
}

-(UIView *)seperateView{
    if (!_seperateView) {
        _seperateView = [[UIView alloc] init];
        _seperateView.backgroundColor = KlineColor;
    }
    return _seperateView;
}

@end
