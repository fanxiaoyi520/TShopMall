//
//  TSHomePageContainerCell.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/8.
//

#import <UIKit/UIKit.h>
#import "TSHomePageBaseCell.h"
#import "TSHomePageContainerGroup.h"
#import "TSHomePageContainerScrollView.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSHomePageContainerCell : TSHomePageBaseCell
//@property (nonatomic, strong) TSHomePageContainerGroup *currentGroup;
@property(nonatomic, strong) TSHomePageContainerScrollView *containerScrollView;

@end

NS_ASSUME_NONNULL_END
