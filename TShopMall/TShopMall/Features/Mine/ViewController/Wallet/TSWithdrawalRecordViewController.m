//
//  TSWithdrawalRecordViewController.m
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/24.
//

#import "TSWithdrawalRecordViewController.h"
#import "TSWithdrawalRecordCell.h"
#import "TSMineDataController.h"

@interface TSWithdrawalRecordViewController ()<UITableViewDelegate,UITableViewDataSource,TSWithdrawalRecordHeaderDelegate>

@property (nonatomic ,strong) UITableView *recordTableView;
@property (nonatomic ,strong) TSWithdrawalRecordHeader *headerView;

@property (nonatomic ,strong) TSMineDataController *dataController;

@end

@implementation TSWithdrawalRecordViewController
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.gk_navTitle = @"提现记录";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    @weakify(self);
    self.dataController.pageNo = 1;
    self.dataController.requestMethod = Ordinary;
    [self.dataController fetchWithdrawalRecordDataComplete:^(BOOL isSucess) {
        @strongify(self);
        if (isSucess) {
            [self.headerView setModel:nil];
            [self.recordTableView reloadData];
        }
    }];
}

- (void)fillCustomView {
    [self.view addSubview:self.headerView];
    self.headerView.frame = CGRectMake(0, GK_STATUSBAR_NAVBAR_HEIGHT, kScreenWidth, 56);

    [self.view addSubview:self.recordTableView];
    self.recordTableView.frame = CGRectMake(0, self.headerView.bottom, kScreenWidth, kScreenHeight - self.headerView.bottom);
}

// MARK: UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataController.withdrawalRecordArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid" forIndexPath:indexPath];
    if ([cell isKindOfClass:TSWithdrawalRecordCell.class]) {
        TSWithdrawalRecordCell *recordCell = (TSWithdrawalRecordCell *)cell;
        recordCell.selectionStyle = UITableViewCellSelectionStyleNone;
        if(self.dataController.withdrawalRecordArray.count>0)
            [recordCell setModel:self.dataController.withdrawalRecordArray[indexPath.row]];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 211;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return .01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

// MARK: TSWithdrawalRecordHeaderDelegate
- (void)withdrawalRecordHeaderBtnAction:(id)sender {
    UIButton *btn = (UIButton *)sender;
    self.recordTableView.mj_footer.state = MJRefreshStateIdle;
    [self.recordTableView  scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    self.dataController.status = btn.tag - 10;
    self.dataController.pageNo = 1;
    self.dataController.requestMethod = Ordinary;
    [self.dataController fetchWithdrawalRecordDataComplete:^(BOOL isSucess) {
        if (isSucess) {
            [self.headerView setModel:nil];
            [self.recordTableView reloadData];
        }
    }];
}

// MARK: 刷新
- (void)mjHeadreRefresh {
    self.dataController.pageNo = 1;
    self.dataController.status = self.dataController.status;
    self.dataController.requestMethod = Refresh;
    @weakify(self);
    [self.dataController fetchWithdrawalRecordDataComplete:^(BOOL isSucess) {
        @strongify(self);
        if (isSucess) {
            [self.recordTableView.mj_header endRefreshing];
            [self.recordTableView reloadData];
        }
    }];
}

- (void)mjFooterRefresh {
    self.dataController.pageNo++;
    self.dataController.status = self.dataController.status;
    self.dataController.requestMethod = Load;
    @weakify(self);
    [self.dataController fetchWithdrawalRecordDataComplete:^(BOOL isSucess) {
        @strongify(self);
        if (isSucess) {
            [self.recordTableView.mj_header endRefreshing];
            [self.recordTableView.mj_footer endRefreshing];
            if (self.dataController.pageNo==1) [self.recordTableView.mj_footer endRefreshingWithNoMoreData];
            [self.recordTableView reloadData];
        }
    }];
}

// MARK: get
- (UITableView *)recordTableView {
    if (!_recordTableView) {
        _recordTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _recordTableView.showsVerticalScrollIndicator = NO;
        _recordTableView.showsHorizontalScrollIndicator = NO;
        _recordTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _recordTableView.delegate = self;
        _recordTableView.dataSource = self;
        _recordTableView.backgroundColor = [UIColor clearColor];
        _recordTableView.backgroundView = nil;
        [_recordTableView registerClass:[TSWithdrawalRecordCell class] forCellReuseIdentifier:@"cellid"];
        RefreshGifHeader *header = [RefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(mjHeadreRefresh)];
        _recordTableView.mj_header = header;

        RefreshGifFooter *footer = [RefreshGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(mjFooterRefresh)];
        self.recordTableView.mj_footer = footer;
        self.recordTableView.mj_footer.hidden = NO;
        
    }
    return _recordTableView;
}

-(TSMineDataController *)dataController{
    if (!_dataController) {
        _dataController = [[TSMineDataController alloc] init];
    }
    return _dataController;
}
    
- (TSWithdrawalRecordHeader *)headerView {
    if (!_headerView) {
        _headerView = [[TSWithdrawalRecordHeader alloc] init];
        _headerView.backgroundColor = KWhiteColor;
        _headerView.kDelegate = self;
    }
    return _headerView;
}

@end

