//
//  TSHomePageContainerCell.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/8.
//

#import <UIKit/UIKit.h>
#import "TSHomePageBaseCell.h"
#import "TSHomePageContainerGroup.h"
#import "YBNestViews.h"
NS_ASSUME_NONNULL_BEGIN

@interface TSHomePageContainerCell : TSHomePageBaseCell
@property (nonatomic, strong) YBNestContainerView *containerView;
@property (nonatomic, assign) CGFloat containerHeight;

@end

NS_ASSUME_NONNULL_END
