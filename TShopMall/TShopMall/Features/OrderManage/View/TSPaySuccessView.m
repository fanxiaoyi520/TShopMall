//
//  TSPaySuccessView.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/28.
//

#import "TSPaySuccessView.h"
#import "TSPaySuccessBaseCell.h"

@interface TSPaySuccessView()<UICollectionViewDelegate, UICollectionViewDataSource>

@end

@implementation TSPaySuccessView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{
    if (self == [super initWithFrame:frame collectionViewLayout:layout]) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

- (void)setSections:(NSArray<TSPaySuccessSection *> *)sections{
    _sections = sections;
    [self reloadData];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat progress = offsetY / GK_STATUSBAR_NAVBAR_HEIGHT;
    NSString *alphe = [NSString stringWithFormat:@"%@", progress];
    [self.con performSelector:@selector(changeNaviBarBgAlpha:) withObject:alphe];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.sections.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.sections[section].items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TSPaySuccessItem *item = self.sections[indexPath.section].items[indexPath.row];
    Class className = NSClassFromString(item.identify);
    [collectionView registerClass:[className class] forCellWithReuseIdentifier:item.identify];
    TSPaySuccessBaseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:item.identify forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.obj = item.obj;
    cell.theDelegate = self.con;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section != 0) {
        TSPaySuccessItem *item = self.sections[indexPath.section].items[indexPath.row];
        [self.con performSelector:@selector(recomendGoodsTapped:) withObject:item.obj];
    }
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath{
    TSPaySuccessSection *section = self.sections[indexPath.section];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        Class className = NSClassFromString(section.headerIdentify);
        [collectionView registerClass:[className class]
           forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                  withReuseIdentifier:section.headerIdentify];
        UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:section.headerIdentify forIndexPath:indexPath];
        return header;
    }
    Class className = NSClassFromString(section.footerIdentify);
    [collectionView registerClass:[className class]
       forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
              withReuseIdentifier:section.footerIdentify];
    UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:section.footerIdentify forIndexPath:indexPath];
    return footer;
}

#pragma mark - UniversalCollectionViewCellDataDelegate
-(id)universalCollectionViewCellModel:(NSIndexPath *)indexPath{
    return self.sections[indexPath.section].items[indexPath.row].obj;
}

#pragma mark - UniversalFlowLayoutDelegate
- (CGFloat)collectionView:(UICollectionView *_Nullable)collectionView
                   layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
  heightForRowAtIndexPath:(NSIndexPath *_Nullable)indexPath
                itemWidth:(CGFloat)itemWidth{
    return self.sections[indexPath.section].items[indexPath.row].cellHeight;
}

- (BOOL)collectionView:(UICollectionView *_Nullable)collectionView
                layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
 hasHeaderReusableView:(NSIndexPath *_Nullable)indexPath{
    return self.sections[indexPath.section].hasHeader;
}

-(BOOL)collectionView:(UICollectionView *)collectionView
               layout:(TSUniversalFlowLayout *)collectionViewLayout
hasDecorateReusableView:(NSIndexPath *)indexPath{
   return self.sections[indexPath.section].hasDecorate;
}

-(NSString *)docorateViewIdentifier:(NSIndexPath *)section{
   return @"";
}

- (UIEdgeInsets)collectionView:(UICollectionView *_Nullable)collectionView
                        layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
insetForDecorateReusableViewAtSection:(NSInteger)section{
    return self.sections[section].decorateInset;
}

- (CGSize)collectionView:(UICollectionView *_Nullable)collectionView
                  layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section{
   return self.sections[section].headerSize;
}

- (BOOL)collectionView:(UICollectionView *_Nullable)collectionView
                layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
 hasFooterReusableView:(NSIndexPath *_Nullable)indexPath{
   return self.sections[indexPath.section].hasFooter;
}

- (CGSize)collectionView:(UICollectionView *_Nullable)collectionView
                  layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
referenceSizeForFooterInSection:(NSInteger)section{
    return self.sections[section].footerSize;
}

- (UIEdgeInsets)collectionView:(UICollectionView *_Nullable)collectionView
                        layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section{
    return self.sections[section].sectionInset;
}

- (NSInteger)collectionView:(UICollectionView *_Nullable)collectionView
                     layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
      columnNumberAtSection:(NSInteger )section{
    return self.sections[section].column;
}

- (NSInteger)collectionView:(UICollectionView *_Nullable)collectionView
                     layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
lineSpacingForSectionAtIndex:(NSInteger)section{
    return self.sections[section].lineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *_Nullable)collectionView
                   layout:(TSUniversalFlowLayout*_Nullable)collectionViewLayout
interitemSpacingForSectionAtIndex:(NSInteger)section{
    return self.sections[section].interitemSpacing;
}

- (CGFloat)collectionView:(UICollectionView *_Nullable)collectionView
                   layout:(TSUniversalFlowLayout*_Nullable)collectionViewLayout
spacingWithLastSectionForSectionAtIndex:(NSInteger)section{
    return self.sections[section].spacingWithLastSection;
}


@end
