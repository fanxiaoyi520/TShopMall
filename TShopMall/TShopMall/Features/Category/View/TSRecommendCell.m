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
    NSArray *temp = [NSArray yy_modelArrayWithClass:TSProductBaseModel.class json:model.goodsList];
    
    for (int i = 0; i < model.goodsList.count; i ++) {
        NSDictionary *dic = model.goodsList[i];
        TSProductBaseModel *model = temp[i];
        model.name = dic[@"productName"];
        model.pic = dic[@"imageUrl"];
    }
    
    self.collectionView.items = temp;
    [self.collectionView.collectionView layoutIfNeeded];
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(self.collectionView.collectionView.contentSize.height));
    }];
    [self tableviewReloadCell];
}

- (TSGridGoodsCollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[TSGridGoodsCollectionView alloc] initWithFrame:CGRectZero items:nil ColumnSpacing:0 rowSpacing:0 itemsHeight:120 rows:0 columns:1 padding:UIEdgeInsetsMake(0, 0, 0, 0) clickedBlock:^(id  _Nonnull selectItem, NSInteger index) {
            TSProductBaseModel *model = (TSProductBaseModel *)selectItem;
            NSString *uri = [[TSServicesManager sharedInstance].uriHandler configUriWithTypeValue:@"Goods" objectValue:model.uuid];
            [[TSServicesManager sharedInstance].uriHandler openURI:uri];
            NSLog(@"uri:%@",uri);
        }];
        _collectionView.collectionView.backgroundColor = KWhiteColor;
    }
    return _collectionView;
}
@end
