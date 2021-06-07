//
//  SSSupplementaryElement.h
//  SSBaseTemplate
//
//  Created by 陈结 on 2021/5/12.
//

#import "SSLayoutElement.h"

typedef NS_ENUM(NSInteger, SSLayoutZIndex){
    SSLayoutZIndexBackground    = -9999, //最底层（头部 Item 底部）的下方
    SSLayoutZIndexBackOfItem    = -1,    //Item的下方
    SSLayoutZIndexOfAuto        = 0,     //自动悬浮可能会覆盖
    SSLayoutZIndexFrontOfItem   = 1,     //Item的上方
    SSLayoutZIndexFrontAlways   = 9999   //最最上方
};

NS_ASSUME_NONNULL_BEGIN

@interface SSSupplementaryElement : SSLayoutElement

/// 该Item的大小（纵向-高度 横向-宽度）
@property(nonatomic, assign) CGFloat elementSize;
/// 视图层级
@property(nonatomic, assign) SSLayoutZIndex zIndex;
/// 内边距（Header Footer受影响 Background不受影响）<可以为正值（向内偏移），也可以为负值（向外偏移）>
@property(nonatomic, assign) UIEdgeInsets edgeInsets;
/// Element类型（Header Footer Background等）
@property(nonatomic, copy, readonly) NSString *elementKind;
/// 是否自适应高度（仅当垂直布局时使用）
@property(nonatomic, assign) BOOL autoHeight;
/// 配置ReusableView数据
@property(nonatomic, copy) void (^configureElementDataAutoHeight)(UICollectionReusableView *view);


/// 创建SSSupplementaryElement对象
/// @param elementSize 该Element大小（纵向-高度 横向-宽度）
/// @param viewClass 视图的类
+(instancetype)elementWithElementSize:(CGFloat)elementSize
                            viewClass:(Class)viewClass;


/// 创建SSSupplementaryElement对象
/// @param elementSize 该Element大小（纵向-高度 横向-宽度）
/// @param viewClass 视图的类
/// @param reuseIdentifier 复用标识符
+(instancetype)elementWithElementSize:(CGFloat)elementSize
                            viewClass:(Class)viewClass
                      reuseIdentifier:(NSString *)reuseIdentifier;


/// 获取扩展视图
/// @param collectionView collectionView
/// @param indexPath indexPath
-(UICollectionReusableView *)dequeueReusableViewWithCollection:(UICollectionView *)collectionView
                                                     indexPath:(NSIndexPath *)indexPath;

/// 更新ElementSize
/// @param collectionView collectionView
/// @param indexPath indexPath
/// @param maxWidth 宽
-(void)updateHeightWithCollection:(UICollectionView *)collectionView
                        indexPath:(NSIndexPath *)indexPath
                         maxWidth:(CGFloat)maxWidth;

@end

NS_ASSUME_NONNULL_END
