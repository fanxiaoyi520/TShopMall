//
//  TSHomePageCategoryCell.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/8.
//

#import "TSHomePageCategoryCell.h"
#import "TSGridButtonCollectionView.h"
#import "TSHomePageCategoryViewModel.h"
#import "TSHomePageBaseModel.h"
@interface TSHomePageCategoryCell()
@property(nonatomic, strong) TSGridButtonCollectionView *collectionView;
@end

@implementation TSHomePageCategoryCell

-(void)setupUI{
    self.contentView.backgroundColor = KGrayColor;
    [self.contentView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(12);
        make.left.equalTo(self.contentView).offset(16);
        make.right.equalTo(self.contentView).offset(-16);
        make.bottom.equalTo(self.contentView).offset(-12);
    }];
}

- (void)setViewModel:(TSHomePageCellViewModel *)viewModel{
    [(TSHomePageCategoryViewModel *)viewModel getCategoryData];
    __weak typeof(self) weakSelf = self;
    [self.KVOController observe:viewModel keyPath:@"categoryDatas" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
          NSArray *data = change[@"new"];
          if (data.count > 0) {
              weakSelf.datas  = data;
          }
      }];
}

- (void)setDatas:(NSArray<TSHomePageBaseModel *> *)datas{
    [super setDatas:datas];
    _collectionView.items = datas;
    [_collectionView reloadData];
}

#pragma mark - Getter
- (TSGridButtonCollectionView *)collectionView {
    if (!_collectionView) {
        UIEdgeInsets padding = UIEdgeInsetsMake(13, 13, 16, 13);
        _collectionView = [[TSGridButtonCollectionView alloc] initWithFrame:CGRectZero items:nil ColumnSpacing:23 rowSpacing:17 itemsHeight:68 rows:2 columns:5 padding:padding clickedBlock:^(id selectItem, NSInteger index) {
            
        }];
        _collectionView.clipsToBounds = YES;
        _collectionView.layer.cornerRadius = 8;
        _collectionView.collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.configCustomView = ^UIView *(TSHomePageBaseModel *model, NSIndexPath *indexPath) {
            UIView *contetView = [UIView new];
            UILabel *nameLabel = [UILabel new];
            nameLabel.textAlignment = NSTextAlignmentCenter;
            nameLabel.font = [UIFont systemFontOfSize:12];
            nameLabel.textColor = KHexColor(@"#2D3132");
            nameLabel.text = model.title;
            [contetView addSubview:nameLabel];
            
            [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.equalTo(contetView);
                make.height.equalTo(@18);
                make.bottom.equalTo(contetView);
            }];
            
            UIImageView *imageView = [UIImageView new];
            imageView.image = [UIImage imageNamed:model.imageUrl];
            [contetView addSubview:imageView];
            
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.right.top.equalTo(contetView);
                make.bottom.equalTo(nameLabel.mas_top).offset(-6);
            }];
            
            return contetView;
        };
    }
    return _collectionView;
}
@end
