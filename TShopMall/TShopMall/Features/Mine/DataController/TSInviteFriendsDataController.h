//
//  TSInviteFriendsDataController.h
//  TShopMall
//
//  Created by 林伟 on 2021/7/1.
//

#import "TSBaseDataController.h"
#import "TSInviteFriendsSectionModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TSInviteFriendsDataController : TSBaseDataController
//全局参数
@property (nonatomic ,assign)NSInteger pageNo;

@property (nonatomic, strong, readonly) NSMutableArray <TSInviteFriendsSectionModel *> *sections;

@property(nonatomic,copy) void(^updateUI)(void);

@property (nonatomic, strong) NSString *inviteCode;

@property (nonatomic, assign) BOOL showAll;
//
-(void)configureDataSource:(void(^)(void))complete;
@end

NS_ASSUME_NONNULL_END
