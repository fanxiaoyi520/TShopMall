//
//  TSHomePageCategoryCell.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/8.
//

#import "TSHomePageCategoryCell.h"

@implementation TSHomePageCategoryCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self fillCustomView];
    }
    return self;
}

-(void)fillCustomView
{
    self.contentView.backgroundColor = [UIColor orangeColor];
}

@end
