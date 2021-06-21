//
//  TSTextImageButton.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/16.
//

#import "TSTextImageButton.h"

@implementation TSTextImageButton

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupBasic];
    }
    return self;
}

-(void)setupBasic{
    self.backgroundColor = [UIColor whiteColor];
    self.titleLabel.font = KRegularFont(10);
    [self setTitleColor:KHexColor(@"#747474") forState:UIControlStateNormal];
    [self setTitleColor:KHexColor(@"#747474") forState:UIControlStateHighlighted];
    [self setImage:KImageMake(@"mall_detail_more") forState:UIControlStateNormal];
    [self setImage:KImageMake(@"mall_detail_more") forState:UIControlStateHighlighted];
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
    CGFloat imageW = 12;
    CGFloat imageH = 12;
    CGFloat imageX = contentRect.size.width - imageW;
    CGFloat imageY = (contentRect.size.height - imageH) * 0.5;

    return CGRectMake(imageX, imageY, imageW, imageH);
}

-(void)setHighlighted:(BOOL)highlighted{}

@end
