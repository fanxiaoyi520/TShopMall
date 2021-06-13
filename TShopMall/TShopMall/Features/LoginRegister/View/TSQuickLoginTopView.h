//
//  TSQuickLoginTopView.h
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TSQuickLoginTopViewDelegate <NSObject>

- (void)quickLogin;

- (void)otherLogin;

@end

@interface TSQuickLoginTopView : UIView
/** 代理 */
@property (nonatomic, weak) id<TSQuickLoginTopViewDelegate> quickDelegate;
/** 手机号 */
@property(nonatomic, copy) NSString *phoneNumber;

//- (void)setPhoneNumer:(NSString *)phoneNumber;

@end

NS_ASSUME_NONNULL_END
