//
//  TSInviteFriendsSectionModel.h
//  TShopMall
//
//  Created by 林伟 on 2021/7/1.
//

#import "TSUniversalSectionModel.h"
#import "TSUniversaItemModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TSInviteFriendsSectionModel : TSUniversalSectionModel
/// 头标题
@property (nonatomic, copy) NSString *headerName;
///
@property (nonatomic, strong) NSMutableArray *dataSource;
/// cell唯一标识
@property (nonatomic, copy) NSString *identify;
/// cell高
@property (nonatomic, assign) CGFloat cellHeight;
//
@property (nonatomic, assign) NSInteger rowsCount;
@end

@interface TSInviteFriendsModel : NSObject

@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *imageName;
@end
NS_ASSUME_NONNULL_END
