//
//  TSDetailShareView.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/22.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol TSDetailShareViewDelegate <NSObject>
- (void)shareViewView:(UIView *)view closeClick:(UIButton *)sender;
- (void)shareViewView:(UIView *)view shareFriendsAction:(UIButton *)sender;
- (void)shareViewView:(UIView *)view sharePYQAction:(UIButton *)sender;
- (void)shareViewView:(UIView *)view downloadAction:(UIButton *)sender;


@end
@interface TSDetailShareView : UIView
@property (nonatomic, weak) id<TSDetailShareViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
