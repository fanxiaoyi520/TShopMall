//
//  TSCategoryContainerViewController.h
//  TShopMall
//
//  Created by  on 2021/6/29.
//

#import "TSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN
@class TSCategoryContainerViewController;
@protocol TSCategoryContainerDataSource <NSObject>
@required
- (NSInteger)numberOfContentsInContainerView:(TSCategoryContainerViewController *)viewController;
- (UIView *)viewForContainerViewController:(TSCategoryContainerViewController *)viewController;

@end
@interface TSCategoryContainerViewController : TSBaseViewController
@property (nonatomic, weak) id<TSCategoryContainerDataSource> dataSource;
- (void)showContentAtPage:(NSInteger)page;

@end

NS_ASSUME_NONNULL_END
