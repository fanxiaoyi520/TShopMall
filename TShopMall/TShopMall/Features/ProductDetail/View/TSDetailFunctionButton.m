//
//  TSDetailFunctionButton.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/15.
//

#import "TSDetailFunctionButton.h"

@implementation TSDetailFunctionButton

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupBasic];
    }
    return self;
}

-(void)setupBasic{
    self.backgroundColor = [UIColor whiteColor];
    self.titleLabel.font = KRegularFont(10);
    [self setTitleColor:KTextColor forState:UIControlStateNormal];
    [self setTitleColor:KTextColor forState:UIControlStateHighlighted];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleX = 0;
    CGFloat titleY = 33;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = contentRect.size.height - titleY;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageW = 20;
    CGFloat imageH = 20;
    CGFloat imageX = (contentRect.size.width - imageW) * 0.5;
    CGFloat imageY = 11;

    return CGRectMake(imageX, imageY, imageW, imageH);
}

-(void)setHighlighted:(BOOL)highlighted{}

@end
