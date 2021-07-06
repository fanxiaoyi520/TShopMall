//
//  TSWalletHeaderView.h
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/23.
//

#import <UIKit/UIKit.h>
#import "TSMyIncomeModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol TSWalletHeaderViewDelegate <NSObject>

@optional
- (void)walletHeaderEyeAction:(UIButton *)sender;
- (void)walletHeaderWithdrawalRecordAction:(id _Nullable)sender;
@end
@interface TSWalletHeaderView : UIImageView
- (instancetype)initWithModel:(TSMyIncomeModel *)model;
//- (void)setModel:(TSMyIncomeModel *)model;
@property (nonatomic ,assign) id <TSWalletHeaderViewDelegate> kDelegate;
@end



@protocol TSWalletCellViewDelegate <NSObject>

- (void)walletCellViewIsBindingAction:(id _Nullable)sender;
@end
@interface TSWalletCellView : UIView
- (instancetype)initWithModel:(TSMyIncomeModel *)model;
@property (nonatomic ,strong) UILabel *cardNumberLab;
//- (void)setModel:(TSMyIncomeModel *)model;
@property (nonatomic, assign)id <TSWalletCellViewDelegate> kDelegate;
@end

NS_ASSUME_NONNULL_END
