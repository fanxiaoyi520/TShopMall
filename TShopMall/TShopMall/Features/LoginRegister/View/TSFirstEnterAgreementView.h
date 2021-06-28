//
//  TSFirstEnterAgreementView.h
//  TShopMall
//
//  Created by edy on 2021/6/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class TSAgreementModel;

@protocol TSFirstEnterAgreementViewDelegate <NSObject>

- (void)goToH5WithAgreementModel:(TSAgreementModel *)agreementModel;

@end

@interface TSFirstEnterAgreementView : UIView
/** 代理  */
@property(nonatomic, weak) id<TSFirstEnterAgreementViewDelegate> delegate;

- (void)showInView:(UIView *)view;

@end

NS_ASSUME_NONNULL_END
