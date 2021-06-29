//
//  TSHomePageContainerHeaderView.h
//  TShopMall
//
//  Created by sway on 2021/6/11.
//

#import <UIKit/UIKit.h>
#import <JXCategoryView/JXCategoryView.h>
#import "TSCategoryGroupViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSHomePageContainerHeaderView : UITableViewHeaderFooterView
@property (nonatomic, strong) TSCategoryGroupViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
