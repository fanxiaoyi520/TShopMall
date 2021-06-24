//
//  TSSettingExitCell.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/13.
//

#import "TSSettingExitCell.h"

@interface TSSettingExitCell ()
/** 退出登录 */
@property(nonatomic, weak) UIButton *exitButton;

@end

@implementation TSSettingExitCell

- (void)fillCustomContentView {
    [super fillCustomContentView];
    self.contentView.backgroundColor = KWhiteColor;
    ///添加约束
    [self addConstraints];
}

- (void)addConstraints {
    [self.exitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX).with.offset(0);
        make.centerY.equalTo(self.contentView.mas_centerY).with.offset(0);
    }];
}


- (UIButton *)exitButton {
    if (_exitButton == nil) {
        UIButton *exitButton = [[UIButton alloc] init];
        _exitButton = exitButton;
        _exitButton.enabled = NO;
        _exitButton.titleLabel.font = KRegularFont(16);
        [_exitButton setTitleColor:KHexColor(@"#E64C3D") forState:UIControlStateNormal];
        [_exitButton setTitle:@"退出登录" forState:UIControlStateNormal];
        [self.contentView addSubview:_exitButton];
    }
    return _exitButton;
}

@end
