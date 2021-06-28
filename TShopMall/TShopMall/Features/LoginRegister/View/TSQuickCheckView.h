//
//  TSQuickCheckView.h
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TSAgreementModel;

@protocol TSQuickCheckViewDelegate <NSObject>

- (void)openAuthenticationProtocol;

- (void)openServiceProtocol;

- (void)openPrivateProtocol;

- (void)goToH5WithAgreementModel:(TSAgreementModel *)agreementModel;

@end

@interface TSQuickCheckView : UIView
/** 代理 */
@property (nonatomic, weak) id<TSQuickCheckViewDelegate> delegate;
/** 是否勾选并同意协议 */
@property(nonatomic, assign, getter=isChecked) BOOL checked;
/** 协议信息  */
@property(nonatomic, strong) NSArray<TSAgreementModel *> *agreementModels;

@end

NS_ASSUME_NONNULL_END
