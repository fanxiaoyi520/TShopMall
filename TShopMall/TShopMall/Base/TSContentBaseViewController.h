//
//  TSContentBaseViewController.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/17.
//

#import "TSBaseViewController.h"
#import <JXCategoryView/JXCategoryView.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSContentBaseViewController : TSBaseViewController<JXCategoryListContainerViewDelegate>

/// 分页标题数组
@property (nonatomic, strong) NSArray *titles;
/// 分页菜单视图
@property (nonatomic, strong) JXCategoryBaseView *categoryView;
/// 列表容器视图
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;

/// 分页菜单视图
- (JXCategoryBaseView *)preferredCategoryView;

/// 分页菜单视图高
- (CGFloat)preferredCategoryViewHeight;

@end

NS_ASSUME_NONNULL_END
