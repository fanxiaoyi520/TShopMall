//
//  TSSelectorViewController.m
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/25.
//

#import "TSSelectorViewController.h"
#import "TSSelectorCell.h"
#import "UIView+Plugin.h"
#import "TSMineDataController.h"

@interface TSSelectorViewController ()<UITableViewDelegate,UITableViewDataSource,TSSelectorDelegate>

@property (nonatomic ,strong) UIView *bgView;
@property (nonatomic ,strong) UITableView *selectorTableView;
@property (nonatomic ,strong) TSMineDataController *dataController;
@property (nonatomic ,strong) NSArray *dataList;
@end

@implementation TSSelectorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self.view addSubview:self.bgView];
    self.bgView.frame = CGRectMake(0, 117, kScreenWidth, kScreenHeight-117);
    [self.bgView jaf_customFilletRectCorner:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(12, 12)];
    
    TSSelectorHeader *headerView = [[TSSelectorHeader alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 56)];
    [headerView jaf_customFilletRectCorner:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(12, 12)];
    headerView.kDelegate = self;
    [self.bgView addSubview:headerView];
    
    [self.bgView addSubview:self.selectorTableView];
    self.selectorTableView.frame = CGRectMake(0, headerView.bottom, kScreenWidth, self.bgView.height-headerView.height);
    TSSelectorCellHeader *headerCellView = [[TSSelectorCellHeader alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 50)];
    self.selectorTableView.tableHeaderView = headerCellView;

    
    @weakify(self);
    [self.dataController fetchQueryBankDataComplete:^(BOOL isSucess) {
        @strongify(self);
        if (isSucess) {
            self.dataList = self.dataController.addBankCardBackArray;
            [self.selectorTableView reloadData];
        }
    }];
}

// MARK: UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataList || self.dataList.count > 0)
        return self.dataList.count;
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid" forIndexPath:indexPath];
    if ([cell isKindOfClass:UITableViewCell.class]) {
        TSSelectorCell *selCell = (TSSelectorCell *)cell;
        [selCell setModel:self.dataList[indexPath.row]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self dismissViewControllerAnimated:YES completion:nil];
    if (self.selectBankBlock) {
        self.selectBankBlock(self.dataList[indexPath.row]);
    }
}

// MARK: TSSelectorDelegate
- (void)selectorHeaderCloseAction:(id _Nullable)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// MARK: get
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = KWhiteColor;
    }
    return _bgView;
}

- (UITableView *)selectorTableView {
    if (!_selectorTableView) {
        _selectorTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _selectorTableView.delegate = self;
        _selectorTableView.dataSource = self;
        _selectorTableView.showsVerticalScrollIndicator = NO;
        _selectorTableView.showsHorizontalScrollIndicator = NO;
        _selectorTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_selectorTableView registerClass:TSSelectorCell.class forCellReuseIdentifier:@"cellid"];
        
    }
    return _selectorTableView;
}

- (TSMineDataController *)dataController {
    if (!_dataController) {
        _dataController = [[TSMineDataController alloc] init];
    }
    return _dataController;
}
@end
