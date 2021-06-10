//
//  TSUniversalFlowLayout.h
//  TSale
//
//  Created by 陈洁 on 2020/12/8.
//  Copyright © 2020 TCL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TSUniversalFlowLayout;

@protocol UniversalFlowLayoutDelegate <NSObject>

@required
///cell高
- (CGFloat)collectionView:(UICollectionView *_Nullable)collectionView
                   layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
  heightForRowAtIndexPath:(NSIndexPath *_Nullable)indexPath
                itemWidth:(CGFloat)itemWidth;

@optional

/// 是否有headerView
- (BOOL)collectionView:(UICollectionView *_Nullable)collectionView
                layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
  hasHeaderReusableView:(NSIndexPath *_Nullable)indexPath;

/// 是否有装饰视图
- (BOOL)collectionView:(UICollectionView *_Nullable)collectionView
                layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
hasDecorateReusableView:(NSIndexPath *_Nullable)indexPath;

/// 装饰视图标识
-(NSString *)docorateViewIdentifier:(NSIndexPath *)section;

///每个区装饰视图的边距
- (UIEdgeInsets)collectionView:(UICollectionView *_Nullable)collectionView
                        layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
insetForDecorateReusableViewAtSection:(NSInteger)section;

///headerSize
- (CGSize)collectionView:(UICollectionView *_Nullable)collectionView
                  layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
referenceSizeForHeaderInSection:(NSInteger)section;

/// 是否有footerView
- (BOOL)collectionView:(UICollectionView *_Nullable)collectionView
                layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
  hasFooterReusableView:(NSIndexPath *_Nullable)indexPath;

///footerSize
- (CGSize)collectionView:(UICollectionView *_Nullable)collectionView
                  layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
referenceSizeForFooterInSection:(NSInteger)section;

///每个区的边距 top botton 通过spacingWithLastSection设置
- (UIEdgeInsets)collectionView:(UICollectionView *_Nullable)collectionView
                        layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section;

///每个区多少列
- (NSInteger)collectionView:(UICollectionView *_Nullable)collectionView
                     layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
      columnNumberAtSection:(NSInteger )section;

///每个区行距
- (NSInteger)collectionView:(UICollectionView *_Nullable)collectionView
                     layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
lineSpacingForSectionAtIndex:(NSInteger)section;

///每个item之间的左右间距
- (CGFloat)collectionView:(UICollectionView *_Nullable)collectionView
                   layout:(TSUniversalFlowLayout*_Nullable)collectionViewLayout
interitemSpacingForSectionAtIndex:(NSInteger)section;

///本区区头和上个区区尾的间距
- (CGFloat)collectionView:(UICollectionView *_Nullable)collectionView
                   layout:(TSUniversalFlowLayout*_Nullable)collectionViewLayout
spacingWithLastSectionForSectionAtIndex:(NSInteger)section;

-(void)collectionViewContentHeight:(CGFloat)contentHeight;

@end

@interface TSUniversalFlowLayout : UICollectionViewLayout

@property (nonatomic, weak) id<UniversalFlowLayoutDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
