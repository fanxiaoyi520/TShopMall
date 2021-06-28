//
//  TSHomePageBaseCell.h
//  TShopMall
//
//  Created by sway on 2021/6/11.
//

#import <UIKit/UIKit.h>
#import "TSHomePageCellViewModel.h"
#import "KVOController.h"
#import "TSHomePageBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSHomePageBaseCell : UITableViewCell
@property (nonatomic, weak) UITableView *cellSuperViewTableView;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) TSHomePageCellViewModel *viewModel;
- (void)setupUI;
- (void)tableviewReloadCell;
@end

NS_ASSUME_NONNULL_END
