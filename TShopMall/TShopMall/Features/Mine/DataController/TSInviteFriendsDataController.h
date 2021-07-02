//
//  TSInviteFriendsDataController.h
//  TShopMall
//
//  Created by 林伟 on 2021/7/1.
//

#import "TSBaseDataController.h"
#import "TSInviteFriendsSectionModel.h"
NS_ASSUME_NONNULL_BEGIN
//@protocol <#protocol name#> <NSObject>
//
//<#methods#>
//
//@end
@interface TSInviteFriendsDataController : TSBaseDataController
//全局参数
@property (nonatomic ,assign)NSInteger pageNo;
//没有更多数据
@property (nonatomic ,assign)BOOL isNoMore;
@property (nonatomic, strong, readonly) NSMutableArray <TSInviteFriendsSectionModel *> *sections;

@property(nonatomic,copy) void(^updateUI)(void);

@property (nonatomic, strong) NSMutableArray *recordList;

@property (nonatomic, strong) NSString *inviteCode;

@property (nonatomic, assign) BOOL showAll;

@property(nonatomic,strong) NSString *salesmanUuid;
//
-(void)configureDataSource;
//
- (void)fetchInvitationCode;

- (void)fetchInvitationRecord;
@end

NS_ASSUME_NONNULL_END
