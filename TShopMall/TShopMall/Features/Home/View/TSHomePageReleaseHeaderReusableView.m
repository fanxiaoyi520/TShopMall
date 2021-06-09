//
//  TSHomePageReleaseHeaderReusableView.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/8.
//

#import "TSHomePageReleaseHeaderReusableView.h"

@interface TSHomePageReleaseHeaderReusableView()

@property(nonatomic, strong) UILabel *nameLabel;

@end

@implementation TSHomePageReleaseHeaderReusableView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self fillCustomView];
    }
    return self;
}

-(void)fillCustomView
{
    self.backgroundColor = KClearColor;
    
    [self addSubview:self.nameLabel];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.centerY.equalTo(self);
    }];
}

#pragma mark - Getter
-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = KRegularFont(16);
        _nameLabel.textColor = KHexColor(@"#393939");
        _nameLabel.text = @"新品推荐";
    }
    return _nameLabel;
}

@end
