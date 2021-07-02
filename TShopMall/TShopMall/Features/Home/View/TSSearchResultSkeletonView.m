//
//  TSSearchResultSkeletonView.m
//  TShopMall
//
//  Created by 橙子 on 2021/7/2.
//

#import "TSSearchResultSkeletonView.h"

@implementation TSSearchResultSkeletonView

- (instancetype)init{
    if (self == [super init]) {
        self.backgroundColor = KHexColor(@"#F4F4F5");
        [self setUpImage];
    }
    return self;
}

- (void)setUpImage{//home_search_skeleton
    for (NSInteger i=0; i<6; i++) {
        UIImageView *imageView = [UIImageView new];
        imageView.image = KImageMake(@"home_search_skeleton");
        [self addSubview:imageView];
        [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.mas_top).offset(KRateW(10.0) + KRateW(131.0) * i);
            make.width.mas_equalTo(kScreenWidth);
            make.height.mas_equalTo(KRateW(131.0));
        }];
    }
}

@end
