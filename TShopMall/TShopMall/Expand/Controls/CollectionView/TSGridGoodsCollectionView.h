//
//  TSGridGoodsCollectionView.h
//  TShopMall
//
//  Created by sway on 2021/6/27.
//

#import <UIKit/UIKit.h>
#import "TSCollectionViewMeanWidthLayout.h"

NS_ASSUME_NONNULL_BEGIN
typedef void(^TSGridGoodsCollectionViewDidSelectedBlock)(id selectItem, NSInteger index);

@interface TSGridGoodsCollectionView : UIView
@property (nonatomic, strong, readonly) TSCollectionViewMeanWidthLayout *layout;
@property (nonatomic, strong)   UICollectionView   * collectionView;
@property (nonatomic, strong)   NSArray            * items;
@property (nonatomic, copy)     TSGridGoodsCollectionViewDidSelectedBlock   clickedBlock;
- (instancetype)initWithFrame:(CGRect)frame items:(NSArray * _Nullable)items ColumnSpacing:(CGFloat)columnSpacing rowSpacing:(CGFloat)rowSpacing  itemsHeight:(CGFloat)height rows:(int)rows columns:(int)columns padding:(UIEdgeInsets)padding clickedBlock:(TSGridGoodsCollectionViewDidSelectedBlock)clickedBlock;
- (void)reloadData;
@end

NS_ASSUME_NONNULL_END
