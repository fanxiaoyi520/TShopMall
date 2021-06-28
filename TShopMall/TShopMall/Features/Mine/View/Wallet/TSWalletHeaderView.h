//
//  TSWalletHeaderView.h
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/23.
//

#import <UIKit/UIKit.h>
#import "TSWalletModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol TSWalletHeaderViewDelegate <NSObject>

@optional
- (void)walletHeaderEyeAction:(UIButton *)sender;
- (void)walletHeaderWithdrawalRecordAction:(id _Nullable)sender;
@end
@interface TSWalletHeaderView : UIImageView

@property (nonatomic ,assign) id <TSWalletHeaderViewDelegate> kDelegate;

- (void)setModel:(TSWalletModel *)model;
@end



@protocol TSWalletCellViewDelegate <NSObject>

- (void)walletCellViewIsBindingAction:(id _Nullable)sender;
@end
@interface TSWalletCellView : UIView

@property (nonatomic, assign)id <TSWalletCellViewDelegate> kDelegate;
@end

NS_ASSUME_NONNULL_END
