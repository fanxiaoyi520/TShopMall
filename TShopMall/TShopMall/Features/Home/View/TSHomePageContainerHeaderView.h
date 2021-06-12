//
//  TSHomePageContainerHeaderView.h
//  TShopMall
//
//  Created by sway on 2021/6/11.
//

#import <UIKit/UIKit.h>
#import "TSHomePageViewModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TSHomePageContainerHeaderView : UITableViewHeaderFooterView
@property (nonatomic, strong) TSHomePageViewModel *viewModel;

@end

NS_ASSUME_NONNULL_END
