//
//  TSGridButtonCollectionView.m
//  
//
//  Created by sway on 2020/9/16.
//

#import "TSGridButtonCollectionView.h"
#import "TSCollectionViewMeanWidthLayout.h"
#import <Masonry/Masonry.h>
#import "UIView+Extension.h"
#import "TSGridButtonCollectionViewCell.h"

@interface TSGridButtonCollectionView ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) TSCollectionViewMeanWidthLayout *layout;

@end
@implementation TSGridButtonCollectionView

#pragma mark init

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items ColumnSpacing:(CGFloat)columnSpacing rowSpacing:(CGFloat)rowSpacing  itemsHeight:(CGFloat)height rows:(int)rows columns:(int)columns padding:(UIEdgeInsets)padding clickedBlock:(TSGridButtonDidSelectedBlock)clickedBlock
{
    if (self = [super initWithFrame:frame]) {
        _items = items;
        _layout = [[TSCollectionViewMeanWidthLayout alloc] initWithColumnSpacing:columnSpacing rowSpacing:rowSpacing itemsHeight:height rows:rows columns:columns padding:padding];
        self.clickedBlock = clickedBlock;
        [self setUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items ColumnSpacing:(CGFloat)columnSpacing rowSpacing:(CGFloat)rowSpacing  itemsSize:(CGSize)size rows:(int)rows padding:(UIEdgeInsets)padding clickedBlock:(TSGridButtonDidSelectedBlock)clickedBlock{
    if (self = [super initWithFrame:frame]) {
        _items = items;
        _layout = [[TSCollectionViewMeanWidthLayout alloc] initWithColumnSpacing:columnSpacing rowSpacing:rowSpacing itemsSize:size rows:rows padding:padding];
        self.clickedBlock = clickedBlock;
        [self setUI];
    }
    return self;
}

- (void)setUI
{
    [self addSubview:self.collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

#pragma mark setter & getter
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[TSGridButtonCollectionViewCell class] forCellWithReuseIdentifier:@"TSGridButtonCollectionViewCell"];
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"customView"];
    }
    return _collectionView;
}

#pragma mark - UICollectionViewDelegate, UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.items.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath{
    if (_cellwillDisplayBlock) {
        self.cellwillDisplayBlock(self.items[indexPath.row], cell, indexPath);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingCell:(nonnull UICollectionViewCell *)cell forItemAtIndexPath:(nonnull NSIndexPath *)indexPath{
    if (_cellDidEndDisplayingBlock) {
        self.cellDidEndDisplayingBlock(self.items[indexPath.row], cell, indexPath);
    }
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_configCustomView) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"customView" forIndexPath:indexPath];
        while (cell.contentView.subviews.count) {
            [cell.contentView.subviews.lastObject removeFromSuperview];
        }
        UIView *customView = self.configCustomView(self.items[indexPath.row], indexPath);
        [cell.contentView addSubview:customView];
        [customView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(cell.contentView);
        }];
        return cell;
    }else{
        TSGridButtonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TSGridButtonCollectionViewCell" forIndexPath:indexPath];
        
        TSGridButtonItem *item = self.items[indexPath.row];
        [self cofingSystemColor:cell withModel:item];
        
        cell.layer.borderWidth = _buttonBorderWidth;
        if (_buttonCornerRadius) {
            cell.layer.cornerRadius = _buttonCornerRadius;
        }
        cell.title.font = _buttonFont?_buttonFont:[UIFont systemFontOfSize:14];
        cell.title.text = item.title;

        if (item.isSelected) {
            cell.title.font = _buttonSelectedFont?_buttonSelectedFont:_buttonFont?_buttonFont:[UIFont systemFontOfSize:14];
            [collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
        }
        return cell;
    }
    return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_configCustomView) {
        if (_clickedBlock) {
            self.clickedBlock(self.items[indexPath.row],indexPath.row);
        }
        
    }else{
        TSGridButtonCollectionViewCell *cell = (TSGridButtonCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];

        TSGridButtonItem *item = self.items[indexPath.row];
        if (item.isSelected) {
            if(_clickedBlock) {
                self.clickedBlock(item, indexPath.row);
            }
            return;
        }
      
        item.isSelected = !item.isSelected;
        
        cell.title.font = item.isSelected?_buttonSelectedFont?_buttonSelectedFont:_buttonFont?_buttonFont:[UIFont systemFontOfSize:14]:_buttonFont?_buttonFont:[UIFont systemFontOfSize:14];
        [self cofingSystemColor:cell withModel:item];
        
        if (_clickedBlock) {
            self.clickedBlock(item,indexPath.row);
        }
    }
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_configCustomView) {
        
    }else{
        TSGridButtonCollectionViewCell *cell = (TSGridButtonCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
        TSGridButtonItem *item = self.items[indexPath.row];
        item.isSelected = !item.isSelected;
        cell.title.font = item.isSelected?_buttonSelectedFont?_buttonSelectedFont:_buttonFont?_buttonFont:[UIFont systemFontOfSize:14]:_buttonFont?_buttonFont:[UIFont systemFontOfSize:14];
        [self cofingSystemColor:cell withModel:item];
    }
}

#pragma mark - Public Methods

#pragma mark - UICollectionViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.scrollViewDidScrollBlock) {
        self.scrollViewDidScrollBlock(scrollView);
    }
}

- (void)reloadData
{
    [_collectionView reloadData];
    if (self.viewHeight <= 0) {
        [_collectionView layoutIfNeeded];
        NSLog(@"%f",_collectionView.contentSize.height);
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(_collectionView.contentSize.height));
        }];
    }
    else {
        [self mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@(self.viewHeight));
        }];
    }
}

- (void)cofingSystemColor:(TSGridButtonCollectionViewCell *)cell withModel:(TSGridButtonItem *)item{
    cell.title.textColor = item.isSelected?_buttonTextSelectedColor?_buttonTextSelectedColor:[UIColor whiteColor]:_buttonTextColor?_buttonTextColor:[UIColor grayColor];
    cell.layer.borderColor = item.isSelected?_buttonBorderSelectedColor.CGColor?_buttonBorderSelectedColor.CGColor:[UIColor clearColor].CGColor:_buttonBorderColor.CGColor?_buttonBorderColor.CGColor:[UIColor grayColor].CGColor;
    cell.contentView.backgroundColor = item.isSelected?_buttonBackgroundSelectedColor?_buttonBackgroundSelectedColor:[UIColor grayColor]:_buttonBackgroundColor?_buttonBackgroundColor:[UIColor whiteColor];
    
}

@end


