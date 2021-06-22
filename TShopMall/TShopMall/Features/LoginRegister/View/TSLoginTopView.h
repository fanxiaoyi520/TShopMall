//
//  TSLoginTopView.h
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TSLoginTopViewDelegate <NSObject>

- (void)goToRegister;

- (void)login;

- (void)sendCode;

@end

@interface TSLoginTopView : UIView

/** 代理 */
@property (nonatomic, weak) id<TSLoginTopViewDelegate> delegate;

- (void)setCodeButtonTitleAndColor:(NSString *)codeTitle isResend:(BOOL)isResend;
/** 获取输入的手机号 */
- (NSString *)getPhoneNumber;
/** 获取输入的验证码 */
- (NSString *)getCode;
/** 关闭键盘 */
- (void)closeKeyboard;
@end

NS_ASSUME_NONNULL_END
