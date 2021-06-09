//
//  TSHomePageReleaseCell.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/8.
//

#import "TSHomePageReleaseCell.h"

@interface TSHomePageReleaseCell()

@property(nonatomic, strong) UIImageView *iconImageView;
@property(nonatomic, strong) UILabel *nameLabel;

@end

@implementation TSHomePageReleaseCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self fillCustomView];
    }
    return self;
}

-(void)fillCustomView{

    [self.contentView addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.right.equalTo(self.contentView).offset(-16);
        make.top.bottom.equalTo(self.contentView);
    }];
}

#pragma mark - Getter
-(UIImageView *)iconImageView{
    if (!_iconImageView) {
        _iconImageView = [[UIImageView alloc] init];
        _iconImageView.backgroundColor = [UIColor orangeColor];
    }
    return _iconImageView;
}


@end
