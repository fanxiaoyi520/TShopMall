//
//  TSHomePageBaseCell.h
//  TShopMall
//
//  Created by sway on 2021/6/11.
//

#import <UIKit/UIKit.h>
#import "TSHomePageCellViewModel.h"
#import "TSTableViewBaseCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSHomePageBaseCell : TSTableViewBaseCell
@property (nonatomic, strong) TSHomePageCellViewModel *viewModel;
@end

NS_ASSUME_NONNULL_END
