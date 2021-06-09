//
//  TSCartSettleView.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/9.
//

#import <UIKit/UIKit.h>
#import "TSCartProtocol.h"

@interface TSCartSettleView : UIView
@property (nonatomic, weak) id<TSCartProtocol> delegate;

- (void)updateSettleViewStates:(BOOL)isEdit;

///更新全选按钮状态
- (void)updateSelBtnStatus:(BOOL)status;

///更新价格显示
- (void)updatePrice:(NSString *)price;

///根系结算按钮选中商品数量
- (void)updateSettleBtnText:(NSInteger)number;
@end

