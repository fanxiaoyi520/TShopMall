//
//  TSCheckedView.h
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/10.
//

#import <UIKit/UIKit.h>

@class TSAgreementModel;

NS_ASSUME_NONNULL_BEGIN

@protocol TSCheckedViewDelegate <NSObject>
/** 跳转到协议页面 */
- (void)goToH5WithAgreementModel:(TSAgreementModel *)agreementModel;
/** 勾选按钮的事件 */
- (void)checkedAction:(BOOL)isChecked;

@end

@interface TSCheckedView : UIView
/** 代理 */
@property (nonatomic, weak) id<TSCheckedViewDelegate> delegate;
/** 是否勾选并同意协议 */
@property(nonatomic, assign, getter=isChecked) BOOL checked;
/** 协议信息  */
@property(nonatomic, strong) NSArray<TSAgreementModel *> *agreementModels;

@end

NS_ASSUME_NONNULL_END
