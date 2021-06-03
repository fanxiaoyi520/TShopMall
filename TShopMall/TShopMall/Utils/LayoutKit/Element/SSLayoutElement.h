//
//  SSLayoutElement.h
//  SSBaseTemplate
//
//  Created by 陈结 on 2021/5/12.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SSLayoutElement : NSObject<NSCopying>

/// 复用Id
@property(nonatomic, copy) NSString *reuseIdentifier;
/// 视图类
@property(nonatomic, weak) Class viewClass;

/// 创建SSLayoutElement对象
/// @param viewClass 视图的类
+(instancetype)elementWithClass:(Class)viewClass;

/// 创建SSLayoutElement对象
/// @param viewClass 视图的类
/// @param reuseIdentifier 复用标识符
+(instancetype)elementWithClass:(Class)viewClass reuseIdentifier:(NSString *)reuseIdentifier;

/// 注册UICollectionView Cell或者SupplementaryView
/// @param collectionView collectionView
-(void)registerElementWithCollectionView:(UICollectionView *)collectionView;

@end

NS_ASSUME_NONNULL_END
