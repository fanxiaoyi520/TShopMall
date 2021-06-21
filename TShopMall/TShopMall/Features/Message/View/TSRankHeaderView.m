//
//  TSRankHeaderView.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/17.
//

#import "TSRankHeaderView.h"

@interface TSRankHeaderView()

@property(nonatomic, strong) UILabel *rankLabel;
@property(nonatomic, strong) UILabel *userLabel;
@property(nonatomic, strong) UILabel *earnLabel;

@end

@implementation TSRankHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self fillCustomView];
    }
    return self;
}

-(void)fillCustomView{
    [self addSubview:self.rankLabel];
    [self addSubview:self.userLabel];
    [self addSubview:self.earnLabel];
    
    [self.rankLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(30);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(28);
        make.height.mas_equalTo(22);
    }];
    
    [self.userLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.width.mas_equalTo(28);
        make.height.mas_equalTo(22);
    }];
    
    [self.earnLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(22);
    }];

}

#pragma mark - Getter
-(UILabel *)rankLabel{
    if (!_rankLabel) {
        _rankLabel = [[UILabel alloc] init];
        _rankLabel.font = KRegularFont(14);
        _rankLabel.textAlignment = NSTextAlignmentCenter;
        _rankLabel.textColor = KTextColor;
        _rankLabel.text = @"排名";
    }
    return _rankLabel;
}

-(UILabel *)userLabel{
    if (!_userLabel) {
        _userLabel = [[UILabel alloc] init];
        _userLabel.font = KRegularFont(14);
        _userLabel.textAlignment = NSTextAlignmentCenter;
        _userLabel.textColor = KTextColor;
        _userLabel.text = @"用户";
    }
    return _userLabel;
}

-(UILabel *)earnLabel{
    if (!_earnLabel) {
        _earnLabel = [[UILabel alloc] init];
        _earnLabel.font = KRegularFont(14);
        _earnLabel.textAlignment = NSTextAlignmentCenter;
        _earnLabel.textColor = KTextColor;
        _earnLabel.text = @"销售收益";
    }
    return _earnLabel;
}

@end
