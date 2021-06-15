//
//  TSMeasureCell.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/10.
//

#import "TSMeasureCell.h"
#import "TSCategorySectionModel.h"

@interface TSMeasureCell()

@property(nonatomic, strong) UIImageView *imgView;
@property(nonatomic, strong) UILabel *kindLabel;

@end

@implementation TSMeasureCell

-(void)fillCustomContentView{
    self.contentView.backgroundColor = UIColor.clearColor;
    
    [self.contentView addSubview:self.imgView];
    [self.contentView addSubview:self.kindLabel];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(4);
        make.width.height.mas_equalTo(64);
        make.centerX.equalTo(self.contentView);
    }];
    
    [self.kindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imgView.mas_bottom).offset(8);
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(18);
    }];
}

#pragma mark - Getter
-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.backgroundColor = KGrayColor;
    }
    return _imgView;
}
-(UILabel *)kindLabel{
    if (!_kindLabel) {
        _kindLabel = [[UILabel alloc] init];
        _kindLabel.font = KRegularFont(12);
        _kindLabel.textAlignment = NSTextAlignmentCenter;
        _kindLabel.textColor = KTextColor;
        _kindLabel.text = @"";
    }
    return _kindLabel;
}

-(void)setDelegate:(id<UniversalCollectionViewCellDataDelegate>)delegate{
    TSCategorySectionKindItemModel *item = [delegate universalCollectionViewCellModel:self.indexPath];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:item.TwoLevelImg] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            
    }];
    self.kindLabel.text = item.TwoLevelTitle;
}

@end
