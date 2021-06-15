//
//  TSHomePageContainerScrollView.h
//  TShopMall
//
//  Created by sway on 2021/6/14.
//

#import <UIKit/UIKit.h>
#import "TSHomePageContainerViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSHomePageContainerScrollView : UIScrollView
@property (nonatomic, strong) TSHomePageContainerViewModel *viewModel;
@end

NS_ASSUME_NONNULL_END
