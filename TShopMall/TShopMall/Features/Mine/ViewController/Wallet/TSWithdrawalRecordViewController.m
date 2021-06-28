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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.gk_navTitle = @"提现记录";
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.dataController fetchWithdrawalRecordDataComplete:^(BOOL isSucess) {
        if (isSucess) {
            [self.headerView setModel:self.dataController.withdrawalRecordModel];
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
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid" forIndexPath:indexPath];
    if ([cell isKindOfClass:TSWithdrawalRecordCell.class]) {
        TSWithdrawalRecordCell *recordCell = (TSWithdrawalRecordCell *)cell;
        recordCell.selectionStyle = UITableViewCellSelectionStyleNone;
        [recordCell setModel:self.dataController.withdrawalRecordModel];
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
    [self.recordTableView  scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
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

