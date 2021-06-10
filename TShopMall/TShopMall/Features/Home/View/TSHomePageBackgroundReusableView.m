//
//  TSHomePageBackgroundReusableView.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/8.
//

#import "TSHomePageBackgroundReusableView.h"


@interface TSHomePageBackgroundReusableView()

@end

@implementation TSHomePageBackgroundReusableView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self fillCustomView];
    }
    return self;
}

-(void)fillCustomView{
    self.backgroundColor = KGrayColor;
    
    UIImage *image = KImageMake(@"mall_home_bg");
    UIImageView *bgImageView = [[UIImageView alloc] initWithImage:image];
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    bgImageView.clipsToBounds = YES;
    [self addSubview:bgImageView];
    
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(205);
    }];
}





@end
