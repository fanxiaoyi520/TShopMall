//
//  TSHomePageContainerCollectionView.h
//  TShopMall
//
//  Created by sway on 2021/6/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^TSHomePageContainerCollectionViewDidSelectedBlock)(id selectItem, NSInteger index);

@interface TSHomePageContainerCollectionView : UIView
@property (nonatomic, strong)   UICollectionView   * collectionView;
@property (nonatomic, strong)   NSArray            * items;
@property (nonatomic, copy)     TSHomePageContainerCollectionViewDidSelectedBlock   clickedBlock;

- (instancetype)initWithFrame:(CGRect)frame items:(NSArray *)items ColumnSpacing:(CGFloat)columnSpacing rowSpacing:(CGFloat)rowSpacing  itemsHeight:(CGFloat)height rows:(int)rows columns:(int)columns padding:(UIEdgeInsets)padding clickedBlock:(TSHomePageContainerCollectionViewDidSelectedBlock)clickedBlock;
- (void)reloadData;
@end

NS_ASSUME_NONNULL_END
