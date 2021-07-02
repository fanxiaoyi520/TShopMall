//
//  TSInviteFriendsInvitationCell.m
//  TShopMall
//
//  Created by 林伟 on 2021/7/1.
//

#import "TSInviteFriendsInvitationCell.h"

@interface TSInviteFriendsInvitationCell ()

@property (nonatomic ,strong) UILabel *title;
@property (nonatomic ,strong) UILabel *kcodeLab;
@property (nonatomic ,strong) UIButton *kCopyBtn;
@end
@implementation TSInviteFriendsInvitationCell

-(void)fillCustomContentView{ 
    [self.contentView addSubview:self.title];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).offset(16);
    }];
    
    [self.contentView  addSubview:self.kcodeLab];
    [self.kcodeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.title.mas_right);
    }];
    
    [self.contentView  addSubview:self.kCopyBtn];
    [self.kCopyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).offset(-16);
        make.height.mas_equalTo(28);
        make.width.mas_equalTo(88);
    }];
    [self.kCopyBtn jaf_customFilletRectCorner:UIRectCornerAllCorners cornerRadii:CGSizeMake(16, 16)];
}

// MARK: actions
- (void)kCopyAction:(UIButton *)sender {
    UIPasteboard *pab = [UIPasteboard generalPasteboard];
    NSString *str = [self.kcodeLab.text stringByReplacingOccurrencesOfString:@"邀请码:" withString:@""];
    pab.string = str;
    if (str) {
        [Popover popToastOnWindowWithText:@"复制成功"];
    } else {
        [Popover popToastOnWindowWithText:@"复制失败"];
    }
}
 
- (UILabel *)title {
    if (!_title) {
        _title = [UILabel new];
        _title.textColor = KHexColor(@"#2D3132");
        _title.font = KFont(PingFangSCRegular, 16);
        _title.text = @"邀请码: ";
    }
    return _title;
}

- (UILabel *)kcodeLab {
    if (!_kcodeLab) {
        _kcodeLab = [UILabel new];
        _kcodeLab.textColor = KHexColor(@"#2D3132");
        _kcodeLab.font = KFont(PingFangSCMedium, 16);
        _kcodeLab.text = @"DFY788889";
    }
    return _kcodeLab;
}

- (UIButton *)kCopyBtn {
    if (!_kCopyBtn) {
        _kCopyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _kCopyBtn.backgroundColor = KHexColor(@"#FF4D49");
        [_kCopyBtn setTitle:@"复制" forState:UIControlStateNormal];
        _kCopyBtn.titleLabel.font = KRegularFont(14);
        [_kCopyBtn setTitleColor:KHexColor(@"#FFFFFF") forState:UIControlStateNormal];
        [_kCopyBtn addTarget:self action:@selector(kCopyAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _kCopyBtn;
}
@end
