//
//  TSInviteFriendsDataModel.h
//  TShopMall
//
//  Created by 林伟 on 2021/7/2.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSInviteFriendsDataModel : NSObject

@end

@interface TSInviteFriendsList : NSObject
@property (nonatomic, copy) NSString *customerName; //用户名称
@property (nonatomic, copy) NSString *userProfileUrl; //用户头像地址
@property (nonatomic, copy) NSString *mobile;
@end

@interface TSInviteFriendsResult : NSObject
@property (nonatomic, strong) NSArray<TSInviteFriendsList *> *records;
@property (nonatomic, assign) NSInteger total;
@end






NS_ASSUME_NONNULL_END
