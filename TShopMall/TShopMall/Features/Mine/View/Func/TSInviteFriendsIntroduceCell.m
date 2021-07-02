//
//  TSInviteFriendsIntroduceCell.m
//  TShopMall
//
//  Created by 林伟 on 2021/7/1.
//

#import "TSInviteFriendsIntroduceCell.h"
#import "TSInviteFriendsSectionModel.h"
@interface TSInviteFriendsIntroduceCell ()

@property(nonatomic, strong) UIImageView *imgView;
@property(nonatomic, strong) UILabel *kindLabel;
@end

@implementation TSInviteFriendsIntroduceCell

-(void)fillCustomContentView{
    self.contentView.backgroundColor = UIColor.clearColor;
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.kindLabel];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(7);
        make.width.mas_equalTo(68);
        make.height.mas_equalTo(86);
        make.centerX.equalTo(self.contentView);
        
    }];
    
    [self.kindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgView.mas_bottom);
        make.left.right.equalTo(self.imgView);
    }];
   
}

 

#pragma mark - Getter
-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imgView;
}
-(UILabel *)kindLabel{
    if (!_kindLabel) {
        _kindLabel = [[UILabel alloc] init];
        _kindLabel.font = KFont(PingFangSCRegular, 10);
        _kindLabel.numberOfLines = 2;
        _kindLabel.textAlignment = NSTextAlignmentCenter;
        _kindLabel.textColor = KHexAlphaColor(@"#2D3132", 1);
        _kindLabel.alpha = 0.4;
    }
    return _kindLabel;
}
 
-(void)setDelegate:(id<UniversalCollectionViewCellDataDelegate>)delegate{
    TSInviteFriendsModel *item = [delegate universalCollectionViewCellModel:self.indexPath];
    self.imgView.image = KImageMake(item.imageName);
    self.kindLabel.text = item.title;
}

@end
