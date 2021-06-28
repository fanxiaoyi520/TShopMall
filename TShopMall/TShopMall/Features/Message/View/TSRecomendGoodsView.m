//
//  TSRecomendGoodsView.m
//  TShopMall
//
//  Created by sway on 2021/6/27.
//

#import "TSRecomendGoodsView.h"
#import "TSGridGoodsCollectionView.h"

@interface TSRecomendGoodsView()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) TSGridGoodsCollectionView *collectionView;

@end
@implementation TSRecomendGoodsView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
    }];
    
    [self addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10).priorityLow();
        make.left.bottom.equalTo(self);
        make.width.equalTo(@(kScreenWidth));
    }];
    
}

- (CGFloat)height{
    return self.collectionView.collectionView.contentSize.height;
}

- (void)setItems:(NSArray *)items{
    _items = items;
    self.collectionView.items = items;
    [self.collectionView reloadData];
    
    [self.collectionView.collectionView layoutIfNeeded];
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(self.collectionView.collectionView.contentSize.height));
    }];
    [self.collectionView layoutIfNeeded];
}

- (void)getRecommendListWithType:(NSString *)type success:(void (^ _Nullable)(NSArray * _Nullable))success{
    [[TSServicesManager sharedInstance].bestSellingRecommendService getRecommendListWithType:type success:^(NSArray<id<TSRecomendGoodsProtocol>> * _Nullable list) {
        self.items = list;
        success(list);
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [UILabel new];
        _titleLabel.textColor = KBlackColor;
        _titleLabel.font = KFont(PingFangSCRegular, 16);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"热销推荐";
    }
    return _titleLabel;
}

- (TSGridGoodsCollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[TSGridGoodsCollectionView alloc] initWithFrame:CGRectZero items:nil ColumnSpacing:8 rowSpacing:8 itemsHeight:282 rows:0 columns:2 padding:UIEdgeInsetsMake(0, 16, 16, 16) clickedBlock:^(id  _Nonnull selectItem, NSInteger index) {
            
        }];
        _collectionView.collectionView.backgroundColor = KGrayColor;
    }
    return _collectionView;
}
@end
