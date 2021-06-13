//
//  TSLoginBottomView.h
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TSLoginBottomViewDelegate <NSObject>

- (void)goToWechat;

- (void)goToApple;

@end

@interface TSLoginBottomView : UIView

/** 代理 */
@property (nonatomic, weak) id<TSLoginBottomViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
