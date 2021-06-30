//
//  TSRecommendCell.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/10.
//

#import "TSRecommendCell.h"
#import "TSCategoryContentModel.h"
#import "TSGridGoodsCollectionView.h"
#import "TSProductBaseModel.h"

@interface TSRecommendCell()
@property (nonatomic, strong) TSGridGoodsCollectionView *collectionView;

@end

@implementation TSRecommendCell

- (void)setupUI{
    [self.contentView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (void)setData:(id)data{
    [super setData:data];
    TSCategoryContentModel *model = (TSCategoryContentModel *)data;
    
//    NSArray *datas = 
//    
//    
//    TSProductBaseModel *model
//    self.collectionView.items =
}

- (TSGridGoodsCollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[TSGridGoodsCollectionView alloc] initWithFrame:CGRectZero items:nil ColumnSpacing:0 rowSpacing:0 itemsHeight:120 rows:0 columns:1 padding:UIEdgeInsetsMake(10, 16, 10, 16) clickedBlock:^(id  _Nonnull selectItem, NSInteger index) {
            
        }];
    }
    return _collectionView;
}
@end
