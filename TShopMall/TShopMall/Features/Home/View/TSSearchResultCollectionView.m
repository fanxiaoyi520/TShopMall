//
//  TSSearchResultCollectionView.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/21.
//

#import "TSSearchResultCollectionView.h"
#import "TSSearchResultCell.h"

@interface TSSearchResultCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource>

@end

@implementation TSSearchResultCollectionView


- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    if (self == [super initWithFrame:frame collectionViewLayout:layout]) {
        self.backgroundColor = KHexColor(@"#F4F4F5");
        self.delegate = self;
        self.dataSource = self;
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sections.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.sections[section].rows.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TSSearchRow *row = self.sections[indexPath.section].rows[indexPath.row];
    Class className = NSClassFromString(row.cellIdentifier);
    [collectionView registerClass:[className class] forCellWithReuseIdentifier:row.cellIdentifier];
    TSSearchResultCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:row.cellIdentifier forIndexPath:indexPath];
    cell.obj = row.obj;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    TSSearchSection *section = self.sections[indexPath.section];
    [collectionView registerClass:NSClassFromString(section.headerIdentifier) forSupplementaryViewOfKind:kind withReuseIdentifier:section.headerIdentifier];
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:section.headerIdentifier forIndexPath:indexPath];
    return view;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    TSSearchRow *row = self.sections[indexPath.section].rows[indexPath.row];
    return row.rowSize;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    TSSearchSection *searchSection = self.sections[section];
    return CGSizeMake(kScreenWidth, searchSection.headerHeight);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    TSSearchSection *searchSection = self.sections[section];
    return CGSizeMake(kScreenWidth, searchSection.footerHeight);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TSSearchRow *row = self.sections[indexPath.section].rows[indexPath.row];
//    TSGoodListViewModel *vm = (TSGoodListViewModel *)row.obj;
//    TSMakeOrderController *con = [TSMakeOrderController new];
//    [self.navigationController pushViewController:con animated:YES];
}

@end
