//
//  TSInviteFriendsViewController.m
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/27.
//
#define HEADERVIEW_HEIGHT (400+286+56+43)
#import "TSInviteFriendsViewController.h"
#import "TSInviteFriendsHeader.h"

@interface TSInviteFriendsViewController ()<UITableViewDelegate,UITableViewDataSource,TSInviteFriendsDelegate>

@property (nonatomic ,strong) UITableView *friendsTableView;
@end

@implementation TSInviteFriendsViewController
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.gk_navTitle = @"邀请好友";
    
}

- (void)fillCustomView {
    [self.view addSubview:self.friendsTableView];
    self.friendsTableView.frame = CGRectMake(0, GK_STATUSBAR_NAVBAR_HEIGHT, kScreenWidth, kScreenHeight-GK_STATUSBAR_NAVBAR_HEIGHT);
    
    TSInviteFriendsHeader *view = [[TSInviteFriendsHeader alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, HEADERVIEW_HEIGHT)];
    view.kDelegate = self;
    [view setModel:nil];
    self.friendsTableView.tableHeaderView = view;
}

// MARK: UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid" forIndexPath:indexPath];
    if ([cell isKindOfClass:TSInviteFriendsCell.class]) {
        TSInviteFriendsCell *friendsCell = (TSInviteFriendsCell *)cell;
        [friendsCell setModel:nil];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return .01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return .01;
}

// MARK: TSInviteFriendsDelegate
- (void)inviteFriendsShareAction:(id)sender {//邀请微信好友
    NSLog(@"邀请好友");
}

- (void)inviteFriendsFuncAction:(id _Nullable)sender {//朋友，微信分享，生成海报
    NSLog(@"分享");
}

- (void)inviteFriendsInvitationAction:(id _Nullable)sender {//今日，全部邀请
    NSLog(@"今日邀请");
}

// MARK: get
- (UITableView *)friendsTableView {
    if (!_friendsTableView) {
        _friendsTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _friendsTableView.showsVerticalScrollIndicator = NO;
        _friendsTableView.showsHorizontalScrollIndicator = NO;
        _friendsTableView.delegate = self;
        _friendsTableView.dataSource = self;
        _friendsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_friendsTableView registerClass:TSInviteFriendsCell.class forCellReuseIdentifier:@"cellid"];
    }
    return _friendsTableView;
}

@end
