//
//  TSMineLeftBarView.m
//  TShopMall
//
//  Created by 林伟 on 2021/6/30.
//

#import "TSMineLeftBarView.h"

@implementation TSMineLeftBarView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self == [super initWithFrame:frame]) {
        [self addSubview:self.userImg];
        [self addSubview:self.userName];
        [_userImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(KRateW(16));
            make.centerY.equalTo(self);
            make.height.width.mas_equalTo(30);
        }];
        [_userName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_userImg.mas_right).offset(KRateW(10));
            make.centerY.equalTo(self);
            make.right.equalTo(self.mas_right);
        }];
    }
    return  self;
}


-(UIImageView *)userImg{
    if (!_userImg) {
        _userImg = [[UIImageView alloc] init];
        _userImg.layer.cornerRadius = 15;
        _userImg.layer.masksToBounds = YES;
        _userImg.contentMode = UIViewContentModeScaleAspectFill;
        _userImg.backgroundColor = [UIColor redColor];
    }
    return _userImg;
}
 
-(UILabel *)userName{
    if (!_userName) {
        _userName = [[UILabel alloc] init];
        _userName.font = KRegularFont(18);
        _userName.textColor = KHexColor(@"#2D3132");
    }
    return _userName;
}

@end
