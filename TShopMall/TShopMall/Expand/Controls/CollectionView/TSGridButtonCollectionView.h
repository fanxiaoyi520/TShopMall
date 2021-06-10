//
//  TSGridButtonCollectionView.h
//  TSPaaS
//
//  Created by sway on 2020/9/16.
//

#import <UIKit/UIKit.h>

@class TSGridButtonCollectionView;
#import "TSGridButtonCollectionViewCell.h"

typedef void(^TSGridButtonDidSelectedBlock)(id selectItem, NSInteger index);
typedef UIView *(^TSGridButtonConfigCustomViewBlock)(id model, NSIndexPath * indexPath);

@interface TSGridButtonCollectionView : UIView
@property (nonatomic, copy)     TSGridButtonDidSelectedBlock   clickedBlock;
@property (nonatomic, copy)     void(^scrollViewDidScrollBlock)(UIScrollView *scrollView);
@property (nonatomic, copy) void(^cellwillDisplayBlock)(id model, UICollectionViewCell *cell,NSIndexPath *indexPath);
@property (nonatomic, copy) void(^cellDidEndDisplayingBlock)(id model, UICollectionViewCell *cell,NSIndexPath *indexPath);
@property (nonatomic, strong)   UICollectionView   * collectionView;
@property (nonatomic, strong)   NSArray            * items;
@property (nonatomic, assign)   CGFloat            viewHeight;
@property (nonatomic, assign)   CGFloat            buttonBorderWidth;
@property (nonatomic, assign)   CGFloat            buttonCornerRadius;
@property (nonatomic, strong)   UIFont             *buttonFont;
@property (nonatomic, strong)   UIFont             *buttonSelectedFont;

@property (nonatomic, assign)   BOOL               adjustsFontSizeToFitWidth;
@property (nonatomic, assign)   BOOL               needDefaultSelectedColor;

@property (nonatomic, strong)   UIColor            * buttonTextColor;
@property (nonatomic, strong)   UIColor            * buttonTextSelectedColor;
@property (nonatomic, strong)   UIColor            * buttonBackgroundColor;
@property (nonatomic, strong)   UIColor            * buttonBackgroundSelectedColor;
@property (nonatomic, strong)   UIColor            * buttonBorderColor;
@property (nonatomic, strong)   UIColor            * buttonBorderSelectedColor;

///自定义cell的样式
@property (nonatomic, copy)     TSGridButtonConfigCustomViewBlock   configCustomView;

///如果以frame初始化，则height为固定的
- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items ColumnSpacing:(CGFloat)columnSpacing rowSpacing:(CGFloat)rowSpacing  itemsHeight:(CGFloat)height rows:(int)rows columns:(int)columns padding:(UIEdgeInsets)padding clickedBlock:(TSGridButtonDidSelectedBlock)clickedBlock;

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items ColumnSpacing:(CGFloat)columnSpacing rowSpacing:(CGFloat)rowSpacing  itemsSize:(CGSize)size rows:(int)rows padding:(UIEdgeInsets)padding clickedBlock:(TSGridButtonDidSelectedBlock)clickedBlock;

- (void)reloadData;

@end


