//
//  TSInviteFriendsShareCell.m
//  TShopMall
//
//  Created by 林伟 on 2021/7/1.
//

#import "TSInviteFriendsShareCell.h"
#import "TSInviteFriendsSectionModel.h"
@interface TSInviteFriendsShareCell()

@property(nonatomic, strong) UIImageView *imgView;
@property(nonatomic, strong) UILabel *kindLabel;
@end

@implementation TSInviteFriendsShareCell

-(void)fillCustomContentView{
    self.contentView.backgroundColor = UIColor.clearColor; 
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.kindLabel];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(16);
        make.width.height.mas_equalTo(32);
        make.centerX.equalTo(self.contentView);
    }];
    
    [self.kindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgView.mas_bottom).offset(6);
        make.left.right.equalTo(self.contentView);
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
        _kindLabel.font = KRegularFont(12);
        _kindLabel.textAlignment = NSTextAlignmentCenter;
        _kindLabel.textColor = KTextColor;
    }
    return _kindLabel;
}
 
-(void)setDelegate:(id<UniversalCollectionViewCellDataDelegate>)delegate{
    TSInviteFriendsModel *item = [delegate universalCollectionViewCellModel:self.indexPath];
    self.imgView.image = KImageMake(item.imageName);
    self.kindLabel.text = item.title;
}

@end
