//
//  TSTopFunctionView.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/22.
//

#import "TSTopFunctionView.h"

@interface TSFuncButton : UIButton

@end

@implementation TSFuncButton

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupBasic];
    }
    return self;
}

-(void)setupBasic{
    self.backgroundColor = [UIColor whiteColor];
    self.titleLabel.font = KRegularFont(12);
    [self setTitleColor:KTextColor forState:UIControlStateNormal];
    [self setTitleColor:KTextColor forState:UIControlStateHighlighted];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleX = 0;
    CGFloat titleY = 48;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageW = 40;
    CGFloat imageH = 40;
    CGFloat imageX = (contentRect.size.width - imageW) * 0.5;
    CGFloat imageY = 0;

    return CGRectMake(imageX, imageY, imageW, imageH);
}

-(void)setHighlighted:(BOOL)highlighted{}

@end

@interface TSTopFunctionView()

/// 关闭按钮
@property(nonatomic, strong) UIButton *closeButton;
/// 改价发券
@property(nonatomic, strong) TSFuncButton *changeButton;
/// 分享商品
@property(nonatomic, strong) TSFuncButton *shareButton;
/// 下载素材
@property(nonatomic, strong) TSFuncButton *downloadButton;

@end

@implementation TSTopFunctionView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    
    [self addSubview:self.closeButton];
    [self addSubview:self.changeButton];
    [self addSubview:self.shareButton];
    [self addSubview:self.downloadButton];
    
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(40);
        make.right.equalTo(self).offset(-15);
        make.width.height.mas_equalTo(30);
    }];
    
    [self.changeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-31);
        make.left.equalTo(self).offset(11);
        make.width.mas_equalTo(75);
        make.height.mas_equalTo(66);
    }];
    
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-31);
        make.left.equalTo(self.changeButton.mas_right).offset(18);
        make.width.mas_equalTo(75);
        make.height.mas_equalTo(66);
    }];

    [self.downloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-31);
        make.left.equalTo(self.shareButton.mas_right).offset(18);
        make.width.mas_equalTo(75);
        make.height.mas_equalTo(66);
    }];
}

#pragma mark - Actions
-(void)closeAction:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(topFunctionView:closeClick:)]) {
        [self.delegate topFunctionView:self closeClick:sender];
    }
}

-(void)changeAction:(TSFuncButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(topFunctionView:changeClick:)]) {
        [self.delegate topFunctionView:self changeClick:sender];
    }
}

-(void)shareAction:(TSFuncButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(topFunctionView:shareClick:)]) {
        [self.delegate topFunctionView:self shareClick:sender];
    }
}

-(void)downloadAction:(TSFuncButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(topFunctionView:downloadClick:)]) {
        [self.delegate topFunctionView:self downloadClick:sender];
    }
}

#pragma mark - Getter
-(UIButton *)closeButton{
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
        [_closeButton setBackgroundColor:UIColor.redColor];
    }
    return _closeButton;
}

-(TSFuncButton *)changeButton{
    if (!_changeButton) {
        _changeButton = [TSFuncButton buttonWithType:UIButtonTypeCustom];
        [_changeButton setTitle:@"改价发券" forState:UIControlStateNormal];
        [_changeButton setImage:KImageMake(@"mall_detail_change_price") forState:UIControlStateNormal];
        [_changeButton addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _changeButton;
}

-(TSFuncButton *)shareButton{
    if (!_shareButton) {
        _shareButton = [TSFuncButton buttonWithType:UIButtonTypeCustom];
        [_shareButton setTitle:@"分享商品" forState:UIControlStateNormal];
        [_shareButton setImage:KImageMake(@"mall_detail_change_share") forState:UIControlStateNormal];
        [_shareButton addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareButton;
}

-(TSFuncButton *)downloadButton{
    if (!_downloadButton) {
        _downloadButton = [TSFuncButton buttonWithType:UIButtonTypeCustom];
        [_downloadButton setTitle:@"下载素材" forState:UIControlStateNormal];
        [_downloadButton setImage:KImageMake(@"mall_detail_change_doanload") forState:UIControlStateNormal];
        [_downloadButton addTarget:self action:@selector(downloadAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _downloadButton;
}

@end
