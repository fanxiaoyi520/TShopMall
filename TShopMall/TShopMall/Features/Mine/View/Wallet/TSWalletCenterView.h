//
//  TSWalletCenterView.h
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/24.
//

#import <UIKit/UIKit.h>
#import "TSWalletModel.h"

NS_ASSUME_NONNULL_BEGIN
@protocol TSWalletCenterViewDelegate <NSObject>
@optional
- (void)walletCenterMineIncomeAction:(id _Nullable)sender;
- (void)walletBindingCardAction:(id _Nullable)sender;
@end

@interface TSWalletCenterView : UIImageView
- (instancetype)initWithModel:(TSWalletModel *)model;
@property (nonatomic ,assign) id <TSWalletCenterViewDelegate> kDelegate;
@end

NS_ASSUME_NONNULL_END
