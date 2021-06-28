//
//  TSWithdrawalRecordCell.h
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/24.
//

#import <UIKit/UIKit.h>
#import "TSWithdrawalRecordModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSWithdrawalRecordCell : UITableViewCell

- (void)setModel:(TSWithdrawalRecordModel * _Nullable)model;
@end



@protocol TSWithdrawalRecordHeaderDelegate <NSObject>
@optional
- (void)withdrawalRecordHeaderBtnAction:(id _Nullable)sender;
@end

@interface TSWithdrawalRecordHeader : UIView

@property (nonatomic ,assign) id<TSWithdrawalRecordHeaderDelegate> kDelegate;
- (void)setModel:(id _Nullable)model;
@end
NS_ASSUME_NONNULL_END
