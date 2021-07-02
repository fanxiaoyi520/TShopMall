//
//  TSAddBankCardCell.h
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/25.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol TSAddBankCardDelegate <NSObject>
@optional
- (void)addBankCardInputInfoTextFieldAction:(UITextField *)textField;
- (void)addBankCardInputInfoTextFieldEditingDidBeginAction:(UITextField *)textField;
- (void)addBankCardfuncAction:(id _Nullable)sender;
- (void)addBankCardFooterSureAction:(id _Nullable)sender;
@end
@interface TSAddBankCardCell : UITableViewCell

@property (nonatomic ,assign) id<TSAddBankCardDelegate> kDelegate;
- (void)setModel:(id _Nullable)model indexPath:(NSIndexPath *)indexPath;
@end


@interface TSAddBankCardHeader : UIView
- (void)setModel:(id _Nullable)model;
@end

@interface TSAddBankCardFooter : UIView
@property (nonatomic ,strong) UIButton *sureBtn;
- (void)setModel:(id _Nullable)model;
@property (nonatomic ,assign) id<TSAddBankCardDelegate> kDelegate;
@end

NS_ASSUME_NONNULL_END
