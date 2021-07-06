//
//  TSPayPasswordInputView.h
//  TShopMall
//
//  Created by edy on 2021/7/3.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TSPayPasswordInputViewDelegate <NSObject>

- (void)inputDoneActionWithPwd:(NSString *)pwd;

@end

@interface TSPasswordShowButton : UIButton

@end


@interface TSPayPasswordInputView : UIView
/** 代理  */
@property(nonatomic, weak) id<TSPayPasswordInputViewDelegate> delegate;
/** 获取输入的密码 */
- (NSString *)getInputPassword;
/** 调起键盘 */
- (void)showKeyboard;
/** 清理密码输入框 */
- (void)clear;

@end

NS_ASSUME_NONNULL_END
