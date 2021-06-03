//
//  SSLayoutBaseSection.h
//  SSBaseTemplate
//
//  Created by 陈结 on 2021/5/13.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SSLayoutHandleType) {
    SSLayoutHandleTypeReLayout,         //重新计算（重新布局该分组）
    SSLayoutHandleTypeOnlyChangeOffset, //只是分组偏移高度改变（Section X Y偏移高度）
    SSLayoutHandleTypeAppend            //追加布局
};

typedef NS_ENUM(NSInteger, SSLayoutDirection) {
    SSLayoutDirectionVertical,          //垂直布局
    SSLayoutDirectionHorizontal         //水平布局
};

typedef NS_ENUM(NSInteger, SSLayoutItemDirection) {
    SSLayoutItemDirectionLeftTop,       //水平左边开始，垂直上面开始
    SSLayoutItemDirectionRightBottom    //水平右边开始，垂直下面开始
};

typedef NS_ENUM(NSInteger, SSLayoutLongMove) {
    SSLayoutLongMoveItem,               //方格布局时，长按哪里，该cell的中心点就会跟着移动
    SSLayoutLongMoveTable               //列表布局时，上下移动，X不动
};

NS_ASSUME_NONNULL_BEGIN

@class SSLayoutHeader,SSLayoutFooter,SSLayoutBackground,SSCollectionViewLayoutAttributes;

@interface SSLayoutBaseSection : NSObject

/// 布局方向
@property(nonatomic, assign) SSLayoutDirection direction;
/// 重新布局
@property(nonatomic, assign) SSLayoutHandleType handleType;
/// 长按移动的方式
@property(nonatomic, assign) SSLayoutLongMove moveType;

/// 显示隐藏
@property(nonatomic, assign, getter = isHidden) BOOL hidden;
/// 仅当布局生效之后才有值
@property(nonatomic, weak) UICollectionView *collectionView;
/// 仅当布局生效之后才有值
@property(nonatomic, strong)NSIndexPath *indexPath;
/// 是否需要重新计算 设置为NO 布局会重新计算
@property(nonatomic, assign) BOOL hasHandle;
/// 重新计算从哪一个开始
@property(nonatomic, assign) NSInteger handleItemStart;
/// Section偏移量
@property(nonatomic, assign) CGFloat changeOffset;
/// 分组偏移高度
@property(nonatomic, assign) CGFloat sectionOffset;
/// 分组大小  纵向-高度  横向-宽度
@property(nonatomic, assign) CGFloat sectionSize;
/// 分组内边距
@property(nonatomic, assign) UIEdgeInsets sectionInset;
/// cell行间距
@property(nonatomic, assign) CGFloat lineSpace;
/// cell间距
@property(nonatomic, assign) CGFloat itemSpace;
/// cell列数  纵向-列数   横向-行数
@property(nonatomic, assign) NSInteger column;
/// 每一列的高度缓存
@property(nonatomic, strong) NSMutableDictionary *columnSizes;
/// 每一个分组的item个数  默认返回itemDatas.count
@property(nonatomic, assign) NSInteger itemCount;
/// cell数据数组
@property(nonatomic, strong) NSMutableArray *itemDatas;
/// 是否可以长按移动排序该分组  默认No  需配合SSCollectionView的enableLongPressDrag使用
@property(nonatomic, assign)BOOL canLongPressExchange;
/// 第一个Item的Y值  横向纵向有区别
@property(nonatomic, assign, readonly) CGFloat firstItemStartY;
/// 第一个Item的X值  横向纵向有区别
@property(nonatomic, assign, readonly) CGFloat firstItemStartX;

/// 分组头部
@property(nonatomic, strong) SSLayoutHeader *header;
/// 分组尾部
@property(nonatomic, strong) SSLayoutFooter *footer;
/// 分组背景
@property(nonatomic, strong) SSLayoutBackground *background;

@property(nonatomic, strong) SSCollectionViewLayoutAttributes *backgroundAttributes;
@property(nonatomic, strong) SSCollectionViewLayoutAttributes *headerAttributes;
@property(nonatomic, strong) SSCollectionViewLayoutAttributes *footerAttributes;
@property(nonatomic, strong) NSArray <SSCollectionViewLayoutAttributes *> *itemsAttributes;

/// 某一个item是否可以移动替换
@property(nonatomic, copy) BOOL(^canLongPressExchangeItem)(id section, NSInteger item);


/// 配置一下Attributes
@property(nonatomic, copy) void(^configureCellLayoutAttributes)(id section, UICollectionViewLayoutAttributes *attributes, NSInteger item);
/// 配置头部的block
@property(nonatomic, copy) void(^configureHeaderData)(SSLayoutBaseSection *section, UICollectionReusableView *header);
/// 配置底部的block
@property(nonatomic, copy) void(^configureFooterData)(SSLayoutBaseSection *section, UICollectionReusableView *footer);
/// 配置背景的block
@property(nonatomic, copy) void(^configureBackground)(SSLayoutBaseSection *section, UICollectionReusableView *background);
/// 配置Cell的block
@property(nonatomic, copy) void(^configureCellData)(SSLayoutBaseSection *section, UICollectionViewCell *cell, NSInteger item);

/// cell点击事件
@property(nonatomic, copy) void(^clickCellBlock)(SSLayoutBaseSection *section, NSInteger item, NSDictionary *params);
/// cell中按钮等点击事件
@property(nonatomic, copy) void(^clickCellButtonBlock)(SSLayoutBaseSection *section, NSInteger item, NSDictionary *params);


/// 创建SSLayoutBaseSection对象
/// @param inset section内边距
/// @param itemSpace cell间距
/// @param lineSpace 行间距
/// @param column 列
+(instancetype)sectionWithSectionInset:(UIEdgeInsets)inset
                              itemSpace:(CGFloat)itemSpace
                              lineSpace:(CGFloat)lineSpace
                                 column:(NSInteger)column;


/// 标记某一个改变  即将刷新该分组的大小  主要用于动态分组
/// @param index 序列号
-(void)markChangeAt:(NSInteger)index;

/// 重新布局
-(void)handleLayout;

/// 判断是否在section组内
/// @param rect 被包含rect
-(BOOL)intersectsRect:(CGRect)rect;

/// 布局header
-(void)prepareHeader;
/// 布局footer
-(void)prepareFooter;
/// 布局cell
-(void)prepareItems;
/// 布局背景视图
-(void)prepareBackground;

/// rect包含attributes
/// @param rect rect
-(NSArray *)showLayoutAttributesInRect:(CGRect)rect;

/// 头部布局信息
-(UICollectionViewLayoutAttributes *)showHeaderLayout;

/// 根据index计算出该布局对象
/// @param index cell在section中的位置
-(SSCollectionViewLayoutAttributes *)getItemAttributesWithIndex:(NSInteger)index;

/// 判断是否只改变偏移量
-(BOOL)prepareLayoutItemsIsOlnyChangeOffset;

/// 获取最小高度的列
-(NSInteger)getMinHeightColumn;

/// 获取最高高度的列
-(CGFloat)getColumnMaxHeight;

/// 重置所有列的高度缓存
-(void)resetcolumnSizes;

/// 交叉布局时单一sention的大小
-(CGFloat)crossSingleSectionSize;

/// 修改数据源
/// @param index 原来位置
/// @param toIndex 替换位置
-(void)exchangeObjectAtIndex:(NSInteger)index toIndex:(NSInteger)toIndex;

/// 获取复用cell
/// @param indexPath indexPath
- (UICollectionViewCell *)dequeueReusableCellForIndexPath:(NSIndexPath *)indexPath;

/// 获取复用cell
/// @param indexPath indexPath
/// @param collectionView collectionView
- (UICollectionViewCell *)dequeueReusableCellForIndexPath:(NSIndexPath *)indexPath collectionView:(UICollectionView *)collectionView;

/// 注册所有Sections对应cell
- (void)registerCells;

/// 注册所有Sections对应cell
/// @param collectionView collectionView
- (void)registerCellsWithCollectionView:(UICollectionView *)collectionView;

/// 刷新整个section
- (void)reload;

/// 刷新section中的一个cell
/// @param item indexPath.row
- (void)reloadItem:(NSInteger)item;

@end

NS_ASSUME_NONNULL_END
