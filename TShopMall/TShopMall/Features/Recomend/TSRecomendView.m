//
//  TSRecomendView.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/22.
//

#import "TSRecomendView.h"
#import "TSRecomendDataController.h"
#import "TSUniversalFlowLayout.h"
#import "TSRecomendCell.h"

@interface TSRecomendView()<UICollectionViewDelegate, UICollectionViewDataSource, UniversalFlowLayoutDelegate>{
    NSArray<TSRecomendSection *> *sections;
}
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) TSRecomendDataController *dataCon;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) PageType type;
@property (nonatomic, copy) void(^finished)(void);
@property (nonatomic, copy) void(^goodsSelected)(NSString *);
@end

@implementation TSRecomendView

+ (TSRecomendView *)configRecomendViewWithType:(PageType)type layoutFinished:(void (^)(void))layoutFinished goodsSelected:(void (^)(NSString *))goodsSelected{
    TSRecomendView *view = [TSRecomendView new];
    view.type = type;
    view.finished = layoutFinished;
    view.goodsSelected = goodsSelected;
    view.backgroundColor = [UIColor clearColor];
    [view startFetchDatas];
    return view;
}

- (void)startFetchDatas{
    self.dataCon.pageType = self.type;
    __weak typeof(self) weakSelf = self;
    [self.dataCon fetchRecomentDatas:^{
        self->sections = [self.dataCon congifSections];
        [weakSelf updateFrame];
        [weakSelf.collectionView reloadData];
    }];
}

- (void)updateDateWithType:(PageType)type goodsSelected:(void (^)(NSString *))goodsSelected{
    self.dataCon.pageType = type;
    self.goodsSelected =  goodsSelected;
    __weak typeof(self) weakSelf = self;
    [self.dataCon fetchRecomentDatas:^{
        self->sections = [self.dataCon congifSections];
        [weakSelf updateFrame];
        [weakSelf.collectionView reloadData];
    }];
}

- (void)updateFrame{
//    self.backgroundColor = KHexColor(self.dataCon.pageInfo.backgroundColor);
    self.title.textAlignment = self.dataCon.recomend.listStyle==2? NSTextAlignmentCenter:NSTextAlignmentLeft;
    self.title.frame = CGRectMake(KRateW(16.0), 0, kScreenWidth - KRateW(32.0), KRateW(56.0));
    CGFloat heigt = self.dataCon.rowSize.height * [sections lastObject].rows.count;
    if (self.dataCon.recomend.listStyle == 5) {
        NSInteger rows = [sections lastObject].rows.count;
        heigt = (self.dataCon.rowSize.height + KRateW(8.0)) * (rows / 2 + rows % 2);
        self.title.textAlignment = NSTextAlignmentCenter;
    }
    self.collectionView.frame = CGRectMake(0, KRateW(56.0), kScreenWidth, heigt);
    self.frame = CGRectMake(0, 0, kScreenWidth, self.collectionView.bottom + KRateW(16.0));
    [self.superview layoutSubviews];
    if (self.finished){
        self.finished();
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return sections.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return sections[section].rows.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TSRecomendSection *section = sections[indexPath.section];
    TSRecomendRow *row = section.rows[indexPath.row];
    Class className = NSClassFromString(row.identify);
    [collectionView registerClass:[className class] forCellWithReuseIdentifier:row.identify];
    TSRecomendCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:row.identify forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.obj = row.obj;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TSRecomendGoods *goods = self.dataCon.recomend.goodsList[indexPath.row];
    self.goodsSelected(goods.goodsUuid);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath{
    return nil;
}

#pragma mark - UniversalCollectionViewCellDataDelegate
-(id)universalCollectionViewCellModel:(NSIndexPath *)indexPath{
    TSRecomendSection *section = sections[indexPath.section];
    return section.rows[indexPath.row];
}

#pragma mark - UniversalFlowLayoutDelegate
- (CGFloat)collectionView:(UICollectionView *_Nullable)collectionView
                   layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
  heightForRowAtIndexPath:(NSIndexPath *_Nullable)indexPath
                itemWidth:(CGFloat)itemWidth{
    TSRecomendSection *section = sections[indexPath.section];
    TSRecomendRow *row = section.rows[indexPath.row];
    return row.cellHeight;
}

- (BOOL)collectionView:(UICollectionView *_Nullable)collectionView
                layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
 hasHeaderReusableView:(NSIndexPath *_Nullable)indexPath{
    return sections[indexPath.section].hasHeader;
}

-(BOOL)collectionView:(UICollectionView *)collectionView
               layout:(TSUniversalFlowLayout *)collectionViewLayout
hasDecorateReusableView:(NSIndexPath *)indexPath{
    return sections[indexPath.section].hasDecorate;
}

-(NSString *)docorateViewIdentifier:(NSIndexPath *)indexPath{
    return sections[indexPath.section].docorateIdentify;
}

- (UIEdgeInsets)collectionView:(UICollectionView *_Nullable)collectionView
                        layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
insetForDecorateReusableViewAtSection:(NSInteger)section{
    return sections[section].decorateInset;
}

- (CGSize)collectionView:(UICollectionView *_Nullable)collectionView
                  layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section{
    return sections[section].headerSize;
}

- (BOOL)collectionView:(UICollectionView *_Nullable)collectionView
                layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
 hasFooterReusableView:(NSIndexPath *_Nullable)indexPath{
    return sections[indexPath.section].hasFooter;
}

- (CGSize)collectionView:(UICollectionView *_Nullable)collectionView
                  layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
referenceSizeForFooterInSection:(NSInteger)section{
    return sections[section].footerSize;
}

- (UIEdgeInsets)collectionView:(UICollectionView *_Nullable)collectionView
                        layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section{
    return sections[section].sectionInset;
}

- (NSInteger)collectionView:(UICollectionView *_Nullable)collectionView
                     layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
      columnNumberAtSection:(NSInteger )section{
    return sections[section].column;
}

- (NSInteger)collectionView:(UICollectionView *_Nullable)collectionView
                     layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
lineSpacingForSectionAtIndex:(NSInteger)section{
    return sections[section].lineSpacing;
}

- (CGFloat)collectionView:(UICollectionView *_Nullable)collectionView
                   layout:(TSUniversalFlowLayout*_Nullable)collectionViewLayout
interitemSpacingForSectionAtIndex:(NSInteger)section{
    return sections[section].interitemSpacing;
}

- (CGFloat)collectionView:(UICollectionView *_Nullable)collectionView
                   layout:(TSUniversalFlowLayout*_Nullable)collectionViewLayout
spacingWithLastSectionForSectionAtIndex:(NSInteger)section{
    return sections[section].spacingWithLastSection;
}

-(UICollectionView *)collectionView{
    if (_collectionView) {
        return _collectionView;
    }
    TSUniversalFlowLayout *flowLayout = [[TSUniversalFlowLayout alloc]init];
    flowLayout.delegate = self;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                         collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = UIColor.clearColor;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.collectionView];
    
    return self.collectionView;
}

- (UILabel *)title{
    if (_title) {
        return _title;
    }
    self.title = [UILabel new];
    self.title.text = @"热门推荐";
    self.title.font = KFont(PingFangSCMedium, 16.0);
    self.title.textColor = KHexColor(@"#2D3132");
    [self addSubview:self.title];
    
    return self.title;
}

- (TSRecomendDataController *)dataCon{
    if (_dataCon){
        return _dataCon;
    }
    self.dataCon = [TSRecomendDataController new];
    
    return self.dataCon;
}

@end
