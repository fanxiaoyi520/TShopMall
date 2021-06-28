//
//  TSDetailShareView.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/22.
//

#import "TSDetailShareView.h"

@interface TSDetailShareButton : UIButton

@end

@implementation TSDetailShareButton

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
    CGFloat titleY = 64;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageW = 56;
    CGFloat imageH = 56;
    CGFloat imageX = (contentRect.size.width - imageW) * 0.5;
    CGFloat imageY = 0;

    return CGRectMake(imageX, imageY, imageW, imageH);
}

-(void)setHighlighted:(BOOL)highlighted{}

@end

@interface TSDetailShareView()

/// 标题
@property(nonatomic, strong) UILabel *titleLabel;
/// 关闭按钮
@property(nonatomic, strong) UIButton *closeButton;
/// 微信
@property(nonatomic, strong) TSDetailShareButton *weixinButton;
/// 朋友圈
@property(nonatomic, strong) TSDetailShareButton *friendButton;
/// 下载素材
@property(nonatomic, strong) TSDetailShareButton *downloadButton;

@end

@implementation TSDetailShareView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.closeButton];
    [self addSubview:self.weixinButton];
    [self addSubview:self.friendButton];
    [self addSubview:self.downloadButton];
    
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(18);
        make.right.equalTo(self).offset(-15);
        make.width.height.mas_equalTo(30);
    }];
    
    //11 * 2 - 30
    CGFloat width = (kScreenWidth - 152)/3.0;
    CGFloat bottom = 9;
    if (GK_SAFEAREA_BTM > 0) {
        bottom = GK_SAFEAREA_BTM;
    }
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(24);
        make.top.equalTo(self).offset(16);
        make.centerX.equalTo(self);
    }];
     
    
    [self.weixinButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-bottom);
        make.left.equalTo(self).offset(50);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(82);
    }];
    
    [self.friendButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-bottom);
        make.left.equalTo(self.weixinButton.mas_right).offset(26);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(82);
    }];

    [self.downloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-bottom);
        make.left.equalTo(self.friendButton.mas_right).offset(26);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(82);
    }];
}

#pragma mark - Actions
-(void)closeAction:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(shareViewView:closeClick:)]) {
        [self.delegate shareViewView:self closeClick:sender];
    }
}

-(void)shareFriendsAction:(TSDetailShareButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(shareViewView:shareFriendsAction:)]) {
        [self.delegate shareViewView:self shareFriendsAction:sender];
    }
}

-(void)sharePYQAction:(TSDetailShareButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(shareViewView:sharePYQAction:)]) {
        [self.delegate shareViewView:self sharePYQAction:sender];
    }
}

-(void)downloadAction:(TSDetailShareButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(shareViewView:downloadAction:)]) {
        [self.delegate shareViewView:self downloadAction:sender];
    }
}

#pragma mark - Getter
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = KTextColor;
        _titleLabel.font = KRegularFont(16);
        _titleLabel.text = @"分享商品给好友";
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

-(UIButton *)closeButton{
    if (!_closeButton) {
        _closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeButton setImage:KImageMake(@"mall_detail_close") forState:UIControlStateNormal];
        [_closeButton setImage:KImageMake(@"mall_detail_close") forState:UIControlStateHighlighted];
        [_closeButton addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeButton;
}

-(TSDetailShareButton *)weixinButton{
    if (!_weixinButton) {
        _weixinButton = [TSDetailShareButton buttonWithType:UIButtonTypeCustom];
        [_weixinButton setTitle:@"微信" forState:UIControlStateNormal];
        [_weixinButton setImage:KImageMake(@"mall_detail_share_weixin") forState:UIControlStateNormal];
        [_weixinButton addTarget:self action:@selector(shareFriendsAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _weixinButton;
}

-(TSDetailShareButton *)friendButton{
    if (!_friendButton) {
        _friendButton = [TSDetailShareButton buttonWithType:UIButtonTypeCustom];
        [_friendButton setTitle:@"朋友圈" forState:UIControlStateNormal];
        [_friendButton setImage:KImageMake(@"mall_detail_share_friend") forState:UIControlStateNormal];
        [_friendButton addTarget:self action:@selector(sharePYQAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _friendButton;
}

-(TSDetailShareButton *)downloadButton{
    if (!_downloadButton) {
        _downloadButton = [TSDetailShareButton buttonWithType:UIButtonTypeCustom];
        [_downloadButton setTitle:@"下载素材" forState:UIControlStateNormal];
        [_downloadButton setImage:KImageMake(@"mall_detail_share_download") forState:UIControlStateNormal];
        [_downloadButton addTarget:self action:@selector(downloadAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _downloadButton;
}

@end
