//
//  TSHomePageBackgroundReusableView.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/8.
//

#import "TSHomePageBackgroundReusableView.h"

@implementation TSHomePageBackgroundReusableView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self fillCustomView];
    }
    return self;
}

-(void)fillCustomView
{
    UIImage *image = KImageMake(@"mall_home_bg");
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:image];
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    bgImageView.clipsToBounds = YES;
    [self addSubview:bgImageView];
    
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
}

@end
