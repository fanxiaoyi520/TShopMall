//
//  TSInviteFriendsDataController.m
//  TShopMall
//
//  Created by 林伟 on 2021/7/1.
//

#import "TSInviteFriendsDataController.h"

@interface TSInviteFriendsDataController()
@property (nonatomic, strong) NSMutableArray <TSInviteFriendsSectionModel *> *sections;
@end

@implementation TSInviteFriendsDataController

- (void)configureDataSource:(void(^)(void))complete{
    self.sections = [NSMutableArray array];
    //滚动图
    {
        TSInviteFriendsSectionModel *section = [[TSInviteFriendsSectionModel alloc] init];
        section.rowsCount = 1;
        section.cellHeight = 284;
        section.column = 1;
        section.identify = @"TSInviteFriendsPhotoCell";
        [self.sections addObject:section];
    }
    
  //分享
    {
        NSMutableArray *items = [NSMutableArray array];
        NSArray *titles = @[@"朋友圈分享",@"微信分享",@"生成海报"];
        NSArray *images = @[@"mine_wxpyq",@"mine_wxfx",@"mine_schb"];
        
        for (int i = 0; i < titles.count; i++) {
            NSString *title = titles[i];
            NSString *image = images[i];
            TSInviteFriendsModel *item = [[TSInviteFriendsModel alloc] init];
            item.title = title;
            item.imageName = image;
            [items addObject:item];
        }
        TSInviteFriendsSectionModel *section = [[TSInviteFriendsSectionModel alloc] init];
        section.dataSource = items;
        section.rowsCount = items.count;
        section.cellHeight = 87;
        section.column = 3;
        section.identify = @"TSInviteFriendsShareCell";
        section.sectionInset = UIEdgeInsetsMake(0, 16, 0, 16);
        section.hasDecorate = YES;
        section.docorateIdentify = @"TSUniversalAllCornersDecorationView";
        section.decorateInset = UIEdgeInsetsMake(0, 16, 0, 16);
        section.spacingWithLastSection = 16;
        [self.sections addObject:section];
    }
    
    // 邀请码
    {
        TSInviteFriendsSectionModel *section = [[TSInviteFriendsSectionModel alloc] init];
        section.rowsCount = 1;
        section.column = 1;
        section.cellHeight = 56;
        section.identify = @"TSInviteFriendsInvitationCell";
        section.sectionInset = UIEdgeInsetsMake(0, 16, 0, 16);
        section.hasDecorate = YES;
        section.docorateIdentify = @"TSUniversalAllCornersDecorationView";
        section.decorateInset = UIEdgeInsetsMake(0, 16, 0, 16);
        section.spacingWithLastSection = 12;
        [self.sections addObject:section];
        
    }
    
    // 邀请流程
    {
        
        NSMutableArray *items = [NSMutableArray array];
        NSArray *titles = @[@"分享链接或海报给好友",@"好友通过分享下载APP",@"注册时填写邀请码"];
        NSArray *images = @[@"mall_mine_shareIntro1",@"mall_mine_shareIntro2",@"mall_mine_shareIntro3"];
        
        for (int i = 0; i < titles.count; i++) {
            NSString *title = titles[i];
            NSString *image = images[i];
            TSInviteFriendsModel *item = [[TSInviteFriendsModel alloc] init];
            item.title = title;
            item.imageName = image;
            [items addObject:item];
        }

        TSInviteFriendsSectionModel *section = [[TSInviteFriendsSectionModel alloc] init];
        section.rowsCount = items.count;
        section.dataSource = items;
        section.cellHeight = 131;
        section.identify = @"TSInviteFriendsIntroduceCell";
        section.footerSize = CGSizeMake(0, 55);
        section.hasDecorate = YES;
        section.docorateIdentify = @"TSUniversalAllCornersDecorationView";
        section.decorateInset = UIEdgeInsetsMake(0, 16, 0, 16);
        section.column = 3;
        section.spacingWithLastSection = 12;
        section.sectionInset = UIEdgeInsetsMake(0, 16, 0, 16);
        [self.sections addObject:section];
        
    }
    
    // 邀请记录
    {
        TSInviteFriendsSectionModel *section = [[TSInviteFriendsSectionModel alloc] init];
        section.rowsCount = 3;
        section.cellHeight = 45;
        section.identify = @"TSInviteFriendsCell";
        section.headerIdentify = @"TSInviteFriendsHeader";
        section.hasHeader = YES;
        section.hasDecorate = YES;
        section.docorateIdentify = @"TSUniversalAllCornersDecorationView";
        section.decorateInset = UIEdgeInsetsMake(0, 16, 0, 16);
        section.headerSize = CGSizeMake(0, 92);
        section.sectionInset = UIEdgeInsetsMake(0, 16, 0, 16);
        section.column = 1;
        section.spacingWithLastSection = 12;
       [self.sections addObject:section];
    }
    
}

 



#pragma mark setter
 
- (void)setShowAll:(BOOL)showAll {
    _showAll = showAll;
    if (_updateUI != nil) {
        _updateUI();
    }
}
@end
