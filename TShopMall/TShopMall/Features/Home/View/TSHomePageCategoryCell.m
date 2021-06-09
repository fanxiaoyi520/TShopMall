//
//  TSHomePageCategoryCell.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/8.
//

#import "TSHomePageCategoryCell.h"

@interface TSHomePageCategoryCell()

@property(nonatomic, strong) UIImageView *iconImageView;
@property(nonatomic, strong) UILabel *nameLabel;

@end

@implementation TSHomePageCategoryCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self fillCustomView];
    }
    return self;
}

-(void)fillCustomView{

    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.nameLabel];
    
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(13);
        make.width.height.mas_equalTo(45);
        make.centerX.equalTo(self.contentView);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImageView.mas_bottom).offset(11);
        make.bottom.left.right.equalTo(self.contentView);
    }];
}

#pragma mark - Getter
-(UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.backgroundColor = KGrayColor;
    }
    return _iconImageView;
}

-(UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = KRegularFont(12);
        _nameLabel.textColor = KTextColor;
        _nameLabel.text = @"燃气灶";
    }
    return _nameLabel;
}

@end
