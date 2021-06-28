//
//  TSProductDetailImageCell.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/15.
//

#import "TSProductDetailImageCell.h"
#import "TSGoodDetailItemModel.h"

@interface TSProductDetailImageCell()

@property (nonatomic, strong) UIImageView *imgView;

@end

@implementation TSProductDetailImageCell

-(void)fillCustomContentView{
    self.contentView.backgroundColor = UIColor.clearColor;
    
    [self.contentView addSubview:self.imgView];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

#pragma mark - Getter
-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.backgroundColor = UIColor.clearColor;
        _imgView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _imgView;
}

-(void)setDelegate:(id<UniversalCollectionViewCellDataDelegate>)delegate{
    TSGoodDetailItemImageModel *item = (TSGoodDetailItemImageModel *)[delegate universalCollectionViewCellModel:self.indexPath];
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:item.imgUrl]];
    
}

@end
