//
//  TSInviteFriendsCell.m
//  TShopMall
//
//  Created by 林伟 on 2021/7/1.
//

#import "TSInviteFriendsCell.h"
#import "TSInviteFriendsSectionModel.h"
@interface TSInviteFriendsCell ()

@property (nonatomic ,strong) UIImageView *iconImageView;
@property (nonatomic ,strong) UILabel *nameLab;
@property (nonatomic ,strong) UILabel *iphoneLb;
@end
@implementation TSInviteFriendsCell
 
-(void)fillCustomContentView{
    
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.iphoneLb];
    [self.contentView addSubview:self.nameLab];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView.mas_left).offset(16);
        make.width.height.mas_equalTo(32);
    }];
    
    [self.iconImageView jaf_customFilletRectCorner:UIRectCornerAllCorners cornerRadii:CGSizeMake(16, 16)];
    
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.iconImageView.mas_right).offset(18);
//        make.right.lessThanOrEqualTo(self.iphoneLb.mas_left).offset(-8);
    }];
    
   
    [self.iphoneLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).offset(-28);
        make.left.greaterThanOrEqualTo(self.nameLab.mas_right).offset(8);
    }];
}

// MARK: model
- (void)setDelegate:(id<UniversalCollectionViewCellDataDelegate>)delegate {
    
    
}
// MARK: get
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
        _iconImageView.image = KImageMake(@"mine_icon_def_touxiang");
    }
    return _iconImageView;
}

- (UILabel *)nameLab {
    if (!_nameLab) {
        _nameLab = [UILabel new];
        _nameLab.textColor = KHexColor(@"#2D3132");
        _nameLab.font = KRegularFont(16);
        _nameLab.text = @"JERRYJUICE";
    }
    return _nameLab;
}

- (UILabel *)iphoneLb {
    if (!_iphoneLb) {
        _iphoneLb = [UILabel new];
        _iphoneLb.textColor = KHexColor(@"#2D3132");
        _iphoneLb.font = KRegularFont(16);
        _iphoneLb.text = @"185****8903";
        _iphoneLb.textAlignment = NSTextAlignmentRight;
        [_iphoneLb setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
    }
    return _iphoneLb;
}
@end
