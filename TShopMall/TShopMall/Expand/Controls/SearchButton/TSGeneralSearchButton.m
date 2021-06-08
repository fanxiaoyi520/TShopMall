//
//  TSGeneralSearchButton.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/3.
//

#import "TSGeneralSearchButton.h"

@implementation TSGeneralSearchButton

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupBasic];
    }
    return self;
}

-(void)setupBasic{
    self.backgroundColor = [UIColor whiteColor];
    self.titleLabel.font = KRegularFont(12);
    [self setTitle:@"搜索商品" forState:UIControlStateNormal];
    [self setImage:KImageMake(@"mall_home_search") forState:UIControlStateNormal];
    [self setTitleColor:KHexAlphaColor(@"#2D3132", 0.4) forState:UIControlStateNormal];
    [self setTitleColor:KHexAlphaColor(@"#2D3132", 0.4) forState:UIControlStateHighlighted];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleX = 8 + 24 + 8;
    CGFloat titleY = 0;
    CGFloat titleW = contentRect.size.width - titleX;
    CGFloat titleH = contentRect.size.height;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageW = 24;
    CGFloat imageH = 24;
    CGFloat imageX = 8;
    CGFloat imageY = (contentRect.size.height - imageH) * 0.5;

    return CGRectMake(imageX, imageY, imageW, imageH);
}

-(void)setHighlighted:(BOOL)highlighted{}

@end
