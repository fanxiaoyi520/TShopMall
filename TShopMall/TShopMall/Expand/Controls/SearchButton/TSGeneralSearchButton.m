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
//    self.backgroundColor = [UIColor whiteColor];
//    self.titleLabel.font = KRegularFont(14);
//    [self setTitleColor:KHexAlphaColor(@"#2D3132", 0.6) forState:UIControlStateNormal];
//    [self setTitleColor:KHexAlphaColor(@"#2D3132", 0.6) forState:UIControlStateHighlighted];
//    self.imageView.contentMode = UIViewContentModeCenter;
//    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleX = 0;
    CGFloat titleY = 48 + 11;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = 18;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageW = 48;
    CGFloat imageH = 48;
    CGFloat imageX = (contentRect.size.width - imageW) * 0.5;
    CGFloat imageY = 0;

    return CGRectMake(imageX, imageY, imageW, imageH);
}

@end
