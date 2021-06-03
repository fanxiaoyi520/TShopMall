//
//  SSLayoutCrossSection.h
//  SSBaseTemplate
//
//  Created by 陈结 on 2021/5/17.
//

#import "SSLayoutBaseSection.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSLayoutCrossSection : SSLayoutBaseSection

/// 布局方向
@property(nonatomic, assign, readonly) SSLayoutDirection crossDirection;

@property(nonatomic, assign) BOOL autoMaxSiza;

@property(nonatomic, assign) CGFloat size;

@property(nonatomic, assign) BOOL canReuseCell;

@property(nonatomic, assign, readonly) CGFloat maxContentWidth;

@property(nonatomic, strong) NSMutableArray <SSLayoutBaseSection *> *sections;

@property(nonatomic, copy) void (^crossSectionDidScroll)(UICollectionView *collectionView, SSLayoutCrossSection *crossSection);
@property(nonatomic, copy) void (^configureCollectionView)(UICollectionView *collectionView, SSLayoutCrossSection *hSection);

+(instancetype)sectionAutoWithSection:(SSLayoutBaseSection *)section;

@end

NS_ASSUME_NONNULL_END
