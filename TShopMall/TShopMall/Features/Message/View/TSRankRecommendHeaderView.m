//
//  TSRankRecommendHeaderView.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/17.
//

#import "TSRankRecommendHeaderView.h"

@interface TSRankRecommendHeaderView()

@property(nonatomic, strong) UILabel *hotLabel;

@end

@implementation TSRankRecommendHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self fillCustomView];
    }
    return self;
}

-(void)fillCustomView{
    [self addSubview:self.hotLabel];
    
    [self.hotLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(64);
        make.height.mas_equalTo(24);
    }];
}

#pragma mark - Getter
-(UILabel *)hotLabel{
    if (!_hotLabel) {
        _hotLabel = [[UILabel alloc] init];
        _hotLabel.font = KFont(PingFangSCMedium, 16);
        _hotLabel.textAlignment = NSTextAlignmentCenter;
        _hotLabel.textColor = KTextColor;
        _hotLabel.text = @"热销推荐";
    }
    return _hotLabel;
}

@end
