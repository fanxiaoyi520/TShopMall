//
//  TSGoodDetailIntroduceCell.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/15.
//

#import "TSGoodDetailIntroduceCell.h"
#import "TSGoodDetailItemModel.h"

@interface TSGoodDetailIntroduceCell()

@property(nonatomic, strong) UIView *bgView;

/// 标题
@property(nonatomic, strong) UILabel *titleLabel;
/// 内容
@property(nonatomic, strong) UILabel *contentLabel;

@end



@implementation TSGoodDetailIntroduceCell

-(void)fillCustomContentView{
    self.contentView.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.contentLabel];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bgView).offset(8);
        make.left.equalTo(self.bgView).offset(16);
        make.right.equalTo(self.bgView).offset(-15);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(4);
        make.left.equalTo(self.bgView).offset(16);
        make.right.equalTo(self.bgView).offset(-15);
    }];
}

#pragma mark - Getter
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = UIColor.whiteColor;
        [_bgView setCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight radius:9];
        _bgView.clipsToBounds = YES;
    }
    return _bgView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = KRegularFont(16);
        _titleLabel.textColor = KTextColor;
        _titleLabel.numberOfLines = 2;
        _titleLabel.text = @"";
    }
    return _titleLabel;
}

-(UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.font = KRegularFont(14);
        _contentLabel.textColor = KHexAlphaColor(@"#2D3132", 0.4);
        _contentLabel.numberOfLines = 2;
        _contentLabel.text = @"";
    }
    return _contentLabel;
}

-(void)setDelegate:(id<UniversalCollectionViewCellDataDelegate>)delegate{
    TSGoodDetailItemHotModel *item = [delegate universalCollectionViewCellModel:self.indexPath];
    self.titleLabel.text = item.title;
    self.contentLabel.text = item.content;
}

@end
