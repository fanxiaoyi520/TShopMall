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
    
//    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).offset(15);
//        make.top.equalTo(self).offset(13);
//        make.height.mas_equalTo(20);
//    }];
//    
//    [self.downloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self).offset(-15);
//        make.bottom.equalTo(self).offset(-31);
//        make.width.mas_equalTo(28);
//        make.height.mas_equalTo(88);
//    }];
//    
//    [self.selectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).offset(18);
//        make.centerY.equalTo(self.downloadButton);
//        make.height.mas_equalTo(20);
//        make.width.mas_equalTo(70);
//    }];
//    
//    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self);
//        make.top.equalTo(self.numLabel.mas_bottom).offset(13);
//        make.bottom.equalTo(self.selectedButton.mas_top).offset(0);
//    }];
}

@end
