//
//  TSMeasureCell.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/10.
//

#import "TSMeasureCell.h"
#import "TSCategoryContentModel.h"
#import "TSGridButtonCollectionView.h"

@interface TSMeasureCell()
@property(nonatomic, strong) TSGridButtonCollectionView *collectionView;


@end

@implementation TSMeasureCell

-(void)setupUI{
    [self.contentView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(0);
        make.left.equalTo(self.contentView).offset(16);
        make.right.equalTo(self.contentView).offset(-16);
        make.bottom.equalTo(self.contentView).offset(-16).priorityLow();
    }];
}

- (void)setData:(id)data{
    [super setData:data];
    TSCategoryContentModel *model = (TSCategoryContentModel *)data;
    NSArray *twoLevel = model.TwoLevel;
    
    self.collectionView.items = twoLevel;
    [self.collectionView reloadData];
    [self tableviewReloadCell];

}

#pragma mark - Getter
- (TSGridButtonCollectionView *)collectionView {
    if (!_collectionView) {
        UIEdgeInsets padding = UIEdgeInsetsMake(0, 0, 0, 0);
        _collectionView = [[TSGridButtonCollectionView alloc] initWithFrame:CGRectZero items:nil ColumnSpacing:30 rowSpacing:24 itemsHeight:84 rows:0 columns:3 padding:padding clickedBlock:^(id selectItem, NSInteger index) {
            NSDictionary *model = (NSDictionary *)selectItem;
            NSString *uri = [[TSServicesManager sharedInstance].uriHandler configUriWithTypeValue:model[@"typeValue"] objectValue:model[@"objectValue"]];

            [[TSServicesManager sharedInstance].uriHandler openURI:uri];
            NSLog(@"uri:%@",uri);
        }];
        _collectionView.collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.configCustomView = ^UIView *(NSDictionary *model, NSIndexPath *indexPath) {
            UIView *contetView = [UIView new];
            UILabel *nameLabel = [UILabel new];
            nameLabel.textAlignment = NSTextAlignmentCenter;
            nameLabel.font = [UIFont systemFontOfSize:12];
            nameLabel.textColor = KHexColor(@"#2D3132");
            nameLabel.text = model[@"TwoLevelTitle"];
            [contetView addSubview:nameLabel];

            [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(contetView);
                make.height.equalTo(@18);
                make.bottom.equalTo(contetView);
            }];

            UIImageView *imageView = [UIImageView new];
            [imageView sd_setImageWithURL:[NSURL URLWithString:model[@"TwoLevelImg"]]];
            [contetView addSubview:imageView];

            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.equalTo(contetView);
                make.height.equalTo(contetView.mas_width);
            }];
            
            return contetView;
        };
    }
    return _collectionView;
}
@end
