//
//  TSMineImageTextCell.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/11.
//

#import "TSMineImageTextCell.h"

@interface TSMineImageTextCell()

@property(nonatomic, strong) UIImageView *imgView;
@property(nonatomic, strong) UILabel *kindLabel;

@end

@implementation TSMineImageTextCell

-(void)fillCustomContentView{
    self.contentView.backgroundColor = UIColor.whiteColor;
    
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.kindLabel];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(15);
        make.width.height.mas_equalTo(32);
        make.centerX.equalTo(self.contentView);
    }];
    
    [self.kindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgView.mas_bottom).offset(6);
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(18);
    }];
}

#pragma mark - Getter
-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
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
    TSMineSectionOrderItemModel *item = [delegate universalCollectionViewCellModel:self.indexPath];
    self.imgView.image = KImageMake(item.imageName);
    self.kindLabel.text = item.title;
}

@end
