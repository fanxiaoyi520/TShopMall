//
//  TSHomePageCategoryCell.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/8.
//

#import "TSHomePageCategoryCell.h"
#import "TSGridButtonCollectionView.h"
#import "TSHomePageCategoryViewModel.h"
#import "UIImageView+WebCache.h"
#import "TSImageBaseModel.h"
@interface TSHomePageCategoryCell()
@property(nonatomic, strong) TSGridButtonCollectionView *collectionView;
@end

@implementation TSHomePageCategoryCell

-(void)setupUI{
    
    [super setupUI];
    
    [self.contentView addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(12);
        make.left.equalTo(self.contentView).offset(16);
        make.right.equalTo(self.contentView).offset(-16);
        make.bottom.equalTo(self.contentView).offset(-12).priorityLow();
    }];
    
}

- (void)setViewModel:(TSHomePageCellViewModel *)viewModel{
    [super setViewModel:viewModel];
    TSHomePageCategoryViewModel *categoryViewModel = (TSHomePageCategoryViewModel *)viewModel;
    if (!categoryViewModel.categoryDatas.count) {
        [categoryViewModel getCategoryData];
    }
    @weakify(self);
    [self.KVOController observe:categoryViewModel keyPath:@"categoryDatas" options:(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew) block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        @strongify(self)
        if (categoryViewModel.categoryDatas) {
            self.collectionView.items = categoryViewModel.categoryDatas;
            [self.collectionView reloadData];
        }
    }];
    
}

#pragma mark - Getter
- (TSGridButtonCollectionView *)collectionView {
    if (!_collectionView) {
        UIEdgeInsets padding = UIEdgeInsetsMake(13, 13, 16, 13);
        _collectionView = [[TSGridButtonCollectionView alloc] initWithFrame:CGRectZero items:nil ColumnSpacing:23 rowSpacing:17 itemsHeight:68 rows:2 columns:5 padding:padding clickedBlock:^(id selectItem, NSInteger index) {
            TSImageBaseModel *model = (TSImageBaseModel *)selectItem;
            [[TSServicesManager sharedInstance].uriHandler openURI:model.uri];
            NSLog(@"uri:%@",model.uri);
        }];
        _collectionView.clipsToBounds = YES;
        _collectionView.layer.cornerRadius = 8;
        _collectionView.collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.configCustomView = ^UIView *(TSImageBaseModel *model, NSIndexPath *indexPath) {
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
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.imageData.url]];
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
