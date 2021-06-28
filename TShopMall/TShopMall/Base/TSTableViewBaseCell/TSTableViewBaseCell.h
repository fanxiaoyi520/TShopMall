//
//  TSTableViewBaseCell.h
//  TShopMall
//
//  Created by  on 2021/6/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSTableViewBaseCell : UITableViewCell
@property (nonatomic, weak) UITableView *cellSuperViewTableView;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) id data;

- (void)setupUI;
- (void)tableviewReloadCell;
@end

NS_ASSUME_NONNULL_END
