//
//  TSGoodDetailSkuView.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/21.
//

#import "TSGoodDetailSkuView.h"
#import "TSProductHeaderView.h"
#import "TSGoodDetailReusableHeaderView.h"
#import "TSProductCollectionViewCell.h"
#import "TSProductFooterView.h"
#import "TSCollectionViewLeftAlignedLayout.h"

@interface TSGoodDetailSkuView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/// 头
@property(nonatomic, strong) TSProductHeaderView *headerView;
/// 中间CollectionView
@property (nonatomic, strong) UICollectionView *collectionView;
/// 尾
@property(nonatomic, strong) TSProductFooterView *footerView;

@end

@implementation TSGoodDetailSkuView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    
    [self addSubview:self.headerView];
    
    __weak __typeof(self)weakSelf = self;
    [self.headerView setCloseBlock:^{
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf.delegate goodDetailSkuViewCloseClick:strongSelf];
            
    }];
//    [self addSubview:self.collectionView];
    [self addSubview:self.footerView];
    
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.height.mas_equalTo(300);
    }];
    
    [self.footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(136);
    }];
    
    self.footerView.cartBlock = ^{
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf.delegate goodDetailSkuView:strongSelf addShoppingCartNum:strongSelf.headerView.num];
    };
    
    self.footerView.buyBlock = ^{
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf.delegate goodDetailSkuView:strongSelf buyImmediatelyNum:strongSelf.headerView.num];
    };
    
    self.headerView.buyNumChangeBlock = ^(NSString *buyNum) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf.delegate goodDetailSkuView:strongSelf numberChange:buyNum];
    };
    
//    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.equalTo(self);
//        make.top.equalTo(self.headerView.mas_bottom).offset(0);
//        make.bottom.equalTo(self.footerView.mas_top).offset(0);
//    }];
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TSProductCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"selectedAddressCell" forIndexPath:indexPath];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(100, 32);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(kScreenWidth - 39, 42);
}

-(UICollectionReusableView  *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        TSGoodDetailReusableHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                                        withReuseIdentifier:@"TSGoodDetailReusableHeaderView" forIndexPath:indexPath];
        return headerView;
    }
    return nil;
}

#pragma mark  - UIcollectionDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

}

#pragma mark - Getter
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        TSCollectionViewLeftAlignedLayout *layout = [[TSCollectionViewLeftAlignedLayout alloc]init];
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        layout.minimumLineSpacing = 10;
        layout.minimumInteritemSpacing = 10;
        layout.sectionInset = UIEdgeInsetsMake(0, 15, 0, 15);
        _collectionView  = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate  = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:[TSProductCollectionViewCell class] forCellWithReuseIdentifier:@"selectedAddressCell"];
        [_collectionView registerClass:[TSGoodDetailReusableHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"TSGoodDetailReusableHeaderView"];
    }
    return _collectionView;
}

-(TSProductHeaderView *)headerView{
    if (!_headerView) {
        _headerView = [[TSProductHeaderView alloc] init];
    }
    return _headerView;
}

-(TSProductFooterView *)footerView{
    if (!_footerView) {
        _footerView = [[TSProductFooterView alloc] init];
    }
    return _footerView;
}

-(void)setPurchaseModel:(TSGoodDetailItemPurchaseModel *)purchaseModel{
    _purchaseModel = purchaseModel;
    _headerView.purchaseModel = purchaseModel;
}

@end
