//
//  TSCheckedView.h
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TSCheckedViewDelegate <NSObject>
/** 跳转到服务协议页面 */
- (void)goToServiceProtocol;
/** 跳转到隐私政策页面 */
- (void)goToPrivatePolicy;
/** 跳转到注册协议页面 */
- (void)goToRegisterProtocol;
/** 勾选按钮的事件 */
- (void)checkedAction:(BOOL)isChecked;

@end

@interface TSCheckedView : UIView
/** 代理 */
@property (nonatomic, weak) id<TSCheckedViewDelegate> delegate;
/** 是否勾选并同意协议 */
@property(nonatomic, assign, getter=isChecked) BOOL checked;

@end

NS_ASSUME_NONNULL_END
