//
//  TSGoodDetailReusableHeaderView.m
//  TSale
//
//  Created by 陈洁 on 2021/1/25.
//  Copyright © 2021 TCL. All rights reserved.
//

#import "TSGoodDetailReusableHeaderView.h"

@interface TSGoodDetailReusableHeaderView()

@property (nonatomic, strong) UILabel *nameLable;

@end

@implementation TSGoodDetailReusableHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self fillCustomView];
    }
    return self;
}

-(void)fillCustomView{
    
    [self addSubview:self.nameLable];
    
    [self.nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.equalTo(self);
        make.left.equalTo(self).offset(16);
    }];
}

#pragma mark - Setter and Getter
-(UILabel *)nameLable{
    if (!_nameLable) {
        _nameLable = [UILabel new];
        _nameLable.textAlignment  = NSTextAlignmentLeft;
        _nameLable.textColor = KHexAlphaColor(@"#2D3132", 0.4);
        _nameLable.font = KRegularFont(14.0);
        _nameLable.backgroundColor = [UIColor clearColor];
    }
    return _nameLable;
}

-(void)setCategoryName:(NSString *)categoryName{
    _categoryName = categoryName;
    self.nameLable.text = categoryName;
}

@end
