//
//  TSMineMoreButton.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/15.
//

#import "TSMineMoreButton.h"

@implementation TSMineMoreButton

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupBasic];
    }
    return self;
}

-(void)setupBasic{
    self.backgroundColor = [UIColor whiteColor];
    self.titleLabel.font = KRegularFont(12);
    [self setImage:KImageMake(@"mall_mine_more") forState:UIControlStateNormal];
    [self setTitleColor:KHexAlphaColor(@"#999999", 1.0) forState:UIControlStateNormal];
    [self setTitleColor:KHexAlphaColor(@"#999999", 1.0) forState:UIControlStateHighlighted];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.titleLabel.textAlignment = NSTextAlignmentRight;
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    CGFloat titleW = contentRect.size.width - 16;
    CGFloat titleH = contentRect.size.height;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageW = 16;
    CGFloat imageH = 16;
    CGFloat imageX = contentRect.size.width - 6;
    CGFloat imageY = (contentRect.size.height - imageH) * 0.5;

    return CGRectMake(imageX, imageY, imageW, imageH);
}

-(void)setHighlighted:(BOOL)highlighted{}

@end
