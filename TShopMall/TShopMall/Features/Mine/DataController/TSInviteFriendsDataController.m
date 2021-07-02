//
//  TSInviteFriendsDataController.m
//  TShopMall
//
//  Created by 林伟 on 2021/7/1.
//

#import "TSInviteFriendsDataController.h"
#import "TSInviteFriendsDataModel.h"
@interface TSInviteFriendsDataController()
@property (nonatomic, strong) NSMutableArray <TSInviteFriendsSectionModel *> *sections;

@end

@implementation TSInviteFriendsDataController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _pageNo = 1;
        _isNoMore = NO;
        _showAll = NO;
    }
    return self;
}

- (void)configureDataSource{
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
        if (self.inviteCode.length > 0) {
        section.dataSource = [NSMutableArray arrayWithObject:self.inviteCode];
        }
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
        section.rowsCount = self.recordList.count;
        section.dataSource = self.recordList;
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

 
// MARK: API
- (void)fetchInvitationCode {
    NSMutableDictionary *body = [NSMutableDictionary dictionary];
     
    body[@"mobile"] = [TSGlobalManager shareInstance].currentUserInfo.user.phone ;
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kCustomerInvitationCode
                                                               requestMethod:YTKRequestMethodGET
                                                       requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:NSDictionary.dictionary
                                                                 requestBody:body
                                                              needErrorToast:YES];
    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
            NSDictionary *data = request.responseModel.data;
            self.inviteCode = [data stringForkey:@"invitationCode"];
            [self configureDataSource];
            if (self.updateUI) {
                self.updateUI();
            }
        }
       
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (self.updateUI) {
            self.updateUI();
        }
    }];
}

- (void)fetchInvitationRecord{
    NSMutableDictionary *body = [NSMutableDictionary dictionary];
     
    body[@"salesmanUuid"] = _salesmanUuid;
    body[@"time"] = self.showAll ? @"2" : @"1"; //今日：1，全部：2
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kSalesmanInvitationRecord
                                                               requestMethod:YTKRequestMethodGET
                                                       requestSerializerType:YTKRequestSerializerTypeHTTP responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:NSDictionary.dictionary
                                                                 requestBody:body
                                                              needErrorToast:YES];
    [request startWithCompletionBlockWithSuccess:^(__kindof SSBaseRequest * _Nonnull request) {
        
         
            NSDictionary *data = request.responseModel.data;
            TSInviteFriendsResult *result = [TSInviteFriendsResult yy_modelWithDictionary:data];
            if (self.pageNo == 1) {
                self.recordList = [NSMutableArray arrayWithArray:result.records];
            } else {
                [self.recordList appendObjects:result.records];
            }
            self.isNoMore = result.total == self.recordList.count;
        [self configureDataSource];
        if (self.updateUI) {
            self.updateUI();
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (self.updateUI) {
            self.updateUI();
        }
    }];
}



#pragma mark setter
 
- (void)setShowAll:(BOOL)showAll {
    _showAll = showAll;
    [self fetchInvitationRecord];
}
@end
