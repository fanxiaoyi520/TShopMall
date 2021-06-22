//
//  TSRegisterTopView.h
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TSRegisterTopViewDelegate <NSObject>

- (void)registerAction;

- (void)sendCode;

- (void)inputDoneAction;

@end

@interface TSRegisterTopView : UIView
/** 代理 */
@property (nonatomic, weak) id<TSRegisterTopViewDelegate> delegate;

- (void)setCodeButtonTitleAndColor:(NSString *)codeTitle isResend:(BOOL)isResend;
/** 获取输入的手机号 */
- (NSString *)getPhoneNumber;
/** 获取输入的验证码 */
- (NSString *)getCode;
/** 注册按钮的可点击与不可点击的设置 */
- (void)setRegisterBtnEnable: (BOOL)isEnable;
/** 关闭键盘 */
- (void)closeKeyboard;

- (NSString *)getInvitationCode;
@end

NS_ASSUME_NONNULL_END
