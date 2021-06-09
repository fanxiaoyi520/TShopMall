//
//  TSHomePageBackgroundReusableView.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/8.
//

#import "TSHomePageBackgroundReusableView.h"
#import "TSGeneralSearchButton.h"

@interface TSHomePageBackgroundReusableView()

@end

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
    
    TSGeneralSearchButton *searchButton = [TSGeneralSearchButton buttonWithType:UIButtonTypeCustom];
    [searchButton addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:searchButton];
    
    [searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self).offset(-49);
        make.top.equalTo(self).offset(44);
        make.height.mas_equalTo(32);
    }];
    
    UIButton *categoryButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [categoryButton setImage:KImageMake(@"mall_home_classification") forState:UIControlStateNormal];
    [categoryButton setImage:KImageMake(@"mall_home_classification") forState:UIControlStateHighlighted];
    [categoryButton addTarget:self action:@selector(categoryAction:) forControlEvents:UIControlEventTouchUpInside];
    categoryButton.imageView.contentMode = UIViewContentModeCenter;
    [self addSubview:categoryButton];
    
    [categoryButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(searchButton.mas_right).offset(8);
        make.centerY.equalTo(searchButton);
        make.width.height.mas_equalTo(24);
    }];
}


#pragma mark - Action
-(void)searchAction:(TSGeneralSearchButton *)sender
{
    
}

-(void)categoryAction:(UIButton *)sender
{
    
}


@end
