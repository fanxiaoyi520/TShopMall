//
//  TSSearchView.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/12.
//

#import "TSSearchView.h"
#import "TSSearchTextView.h"
#import "TSSearchBaseCell.h"
#import "TSSearchHeaderView.h"
#import "TSSearchKeyViewModel.h"
#import "TSRecomendModel.h"

@interface TSSearchView()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) TSSearchTextView *textView;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UICollectionView *collectionView;
@end

@implementation TSSearchView

- (void)cancelAction{
    [self.controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)setSections:(NSArray<TSSearchSection *> *)sections{
    _sections = sections;
    [self.collectionView reloadData];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self endEditing:YES];
}

#pragma mark -- UICollectionViewDataSource --
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
    TSSearchBaseCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:row.cellIdentifier forIndexPath:indexPath];
    cell.obj = row.obj;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    TSSearchSection *section = self.sections[indexPath.section];
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        [collectionView registerClass:NSClassFromString(section.headerIdentifier) forSupplementaryViewOfKind:kind withReuseIdentifier:section.headerIdentifier];
        TSSearchHeaderView *view = (TSSearchHeaderView *)[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:section.headerIdentifier forIndexPath:indexPath];
        view.str = section.headerTitle;
        
        __weak typeof(self) weakSelf = self;
        view.deleteAction = ^(NSString *title) {
            [TSSearchKeyViewModel clearHistorySearchKeys];
            NSMutableArray *a = [NSMutableArray arrayWithArray:weakSelf.sections];
            [a removeObjectAtIndex:indexPath.section];
            weakSelf.sections = a;
        };
        return view;
    }
    [collectionView registerClass:NSClassFromString(section.footerIdentifier) forSupplementaryViewOfKind:kind withReuseIdentifier:section.footerIdentifier];
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:section.footerIdentifier forIndexPath:indexPath];
    return view;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    TSSearchSection *searchSection = self.sections[section];
    return CGSizeMake(kScreenWidth - KRateW(32.0), searchSection.headerHeight);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    TSSearchSection *searchSection = self.sections[section];
    return CGSizeMake(kScreenWidth - KRateW(32.0), searchSection.footerHeight);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    TSSearchBaseCell *cell = (TSSearchBaseCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if ([cell.obj isKindOfClass:[TSSearchKeyViewModel class]]) {
        TSSearchKeyViewModel *vm = cell.obj;
        self.textView.textField.text = vm.keywords;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.controller performSelector:@selector(goToGoodsList:) withObject:vm.keywords];
        });
    }
    if ([cell.obj isKindOfClass:[TSRecomendModel class]]) {
        TSRecomendGoods *obj = cell.obj;
        [self.controller performSelector:@selector(recomentGoodsSelected:) withObject:obj.goodsUuid];
    }
    if ([cell.obj isKindOfClass:[TSRecomendGoods class]]) {
        TSRecomendGoods *obj = cell.obj;
        NSString *uri = [[TSServicesManager sharedInstance].uriHandler configUriWithTypeValue:@"Goods" objectValue:obj.uuid];
        [[TSServicesManager sharedInstance].uriHandler openURI:uri];
    }
}

- (void)layoutSubviews{
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(KRateW(16.0));
        make.top.equalTo(self.mas_top).offset(GK_SAFEAREA_TOP + KRateW(4.0));
        make.height.mas_equalTo(KRateW(32.0));
        make.width.mas_equalTo(KRateW(296.0));
    }];
    
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-KRateW(16.0));
        make.centerY.equalTo(self.textView);
        make.height.mas_equalTo(KRateW(24.0));
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.top.equalTo(self.textView.mas_bottom).offset(KRateW(22.0));
    }];
}

-(UICollectionView *)collectionView{
    if (_collectionView) {
        return _collectionView;
    }
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.estimatedItemSize = CGSizeMake(20, KRateW(24.0));
    flowLayout.minimumLineSpacing = KRateW(16.0);
    flowLayout.minimumInteritemSpacing  = KRateW(8.0);
    flowLayout.scrollDirection =  UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, KRateW(16.0), 0, KRateW(16.0));
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.collectionView.backgroundColor = UIColor.whiteColor;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.collectionView];
    [self forceItemAlignmentLeft];
    
    return self.collectionView;
}

- (void)forceItemAlignmentLeft{
    SEL sel = NSSelectorFromString(@"_setRowAlignmentsOptions:");
    if ([self.collectionView.collectionViewLayout respondsToSelector:sel]) {
        ((void(*)(id,SEL,NSDictionary*)) objc_msgSend)(self.collectionView.collectionViewLayout,sel, @{@"UIFlowLayoutCommonRowHorizontalAlignmentKey":@(NSTextAlignmentLeft),@"UIFlowLayoutLastRowHorizontalAlignmentKey" : @(NSTextAlignmentLeft),@"UIFlowLayoutRowVerticalAlignmentKey" : @(NSTextAlignmentCenter)});
    }
}

- (TSSearchTextView *)textView{
    if (_textView) {
        return _textView;
    }
    self.textView = [TSSearchTextView new];
    [self addSubview:self.textView];
    __weak typeof(self) weakSelf = self;
     self.textView.startSearch = ^(NSString *key) {
         [weakSelf.controller performSelector:@selector(goToGoodsList:) withObject:key];
    };
    
    return self.textView;
}

- (UIButton *)cancelBtn{
    if (_cancelBtn) {
        return _cancelBtn;
    }
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtn.titleLabel.font = KRegularFont(16.0);
    [self.cancelBtn setTitleColor:KHexColor(@"#E64C3D") forState:UIControlStateNormal];
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.cancelBtn];
    
    return self.cancelBtn;
}

- (void)goToGoodsList:(id)list{}
- (void)recomentGoodsSelected:(TSRecomendModel *)recomend{}

@end
