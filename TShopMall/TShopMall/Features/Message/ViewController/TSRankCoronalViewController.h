//
//  TSRankCoronalViewController.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/10.
//

#import "TSBaseViewController.h"
#import <JXCategoryView/JXCategoryView.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSRankCoronalViewController : TSBaseViewController<JXCategoryListContainerViewDelegate>

@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) JXCategoryBaseView *categoryView;
@property (nonatomic, strong) JXCategoryListContainerView *listContainerView;
@property (nonatomic, assign) BOOL isNeedIndicatorPositionChangeItem;

- (JXCategoryBaseView *)preferredCategoryView;
- (CGFloat)preferredCategoryViewHeight;

@end

NS_ASSUME_NONNULL_END
