//
//  TSMakeOrderBaseCell.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/17.
//

#import <UIKit/UIKit.h>

@protocol TSMakeOrderCellDelegate <NSObject>
- (void)operationForChangeDelivery;
- (void)operationForChangeBill;
@end

@interface TSMakeOrderBaseCell : UITableViewCell
@property (nonatomic, strong) id obj;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, weak) id<TSMakeOrderCellDelegate> delegate;
- (void)layoutView;
- (void)configUI;
@end

