//
//  TSHybridRightButton.m
//  TSale
//
//  Created by 陈洁 on 2021/3/1.
//  Copyright © 2021 TCL. All rights reserved.
//

#import "TSHybridRightButton.h"

@implementation TSHybridRightButton

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupBasic];
    }
    return self;
}

-(void)setupBasic{
    self.titleLabel.font = KRegularFont(14);
    self.titleLabel.textAlignment = NSTextAlignmentRight;
    [self setTitleColor:KHexAlphaColor(@"#2D3132", 0.6) forState:UIControlStateNormal];
    [self setTitleColor:KHexAlphaColor(@"#E64C3D", 0.6) forState:UIControlStateSelected];
    [self setImage:KImageMake(@"hybrid_down") forState:UIControlStateNormal];
    [self setImage:KImageMake(@"hybrid_up") forState:UIControlStateSelected];
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageW = 9;
    CGFloat imageH = 9;
    CGFloat imageX = contentRect.size.width - imageW;
    CGFloat imageY = (contentRect.size.height - imageH) * 0.5;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleW = contentRect.size.width - 9 - 5;
    CGFloat titleH = contentRect.size.height;
    CGFloat titleX = 0;
    CGFloat titleY = 0;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

@end
