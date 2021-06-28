//
//  TSInviteFriendsHeader.h
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class TSHeaderShareSubView;
@class TSHeaderInvitationSubView;
@class TSHeaderIntroduceSubView;
@class TSHeaderCellView;

@protocol TSInviteFriendsDelegate <NSObject>
@optional
- (void)inviteFriendsShareAction:(id _Nullable)sender;
- (void)inviteFriendsFuncAction:(id _Nullable)sender;
- (void)inviteFriendsInvitationAction:(id _Nullable)sender;
@end

@interface TSInviteFriendsHeader : UITableViewHeaderFooterView
@property (nonatomic ,assign) id<TSInviteFriendsDelegate> kDelegate;
- (void)setModel:(id _Nullable)model;
@end

@interface TSInviteFriendsCell : UITableViewCell
@property (nonatomic ,assign) id<TSInviteFriendsDelegate> kDelegate;
- (void)setModel:(id _Nullable)model;
@end

@interface TSHeaderShareSubView : UIView
@property (nonatomic ,assign) id<TSInviteFriendsDelegate> kDelegate;
@end

@interface TSHeaderInvitationSubView : UIImageView
@property (nonatomic ,assign) id<TSInviteFriendsDelegate> kDelegate;
@end

@interface TSHeaderIntroduceSubView : UIView
@property (nonatomic ,assign) id<TSInviteFriendsDelegate> kDelegate;
@end

@interface TSHeaderCellView : UIView
@property (nonatomic ,assign) id<TSInviteFriendsDelegate> kDelegate;
@end
NS_ASSUME_NONNULL_END
