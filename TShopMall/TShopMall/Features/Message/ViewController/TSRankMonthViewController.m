//
//  TSRankMonthViewController.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/17.
//

#import "TSRankMonthViewController.h"
#import "TSUniversalFlowLayout.h"
#import "TSUniversalCollectionViewCell.h"
#import "TSUniversalFooterView.h"
#import "TSUniversalHeaderView.h"

@interface TSRankMonthViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;

@end

@implementation TSRankMonthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navigationBar.hidden = YES;
    self.view.backgroundColor = KWhiteColor;
}

-(void)fillCustomView{
    CGFloat bottom = self.view.ts_safeAreaInsets.bottom + 56 + GK_TABBAR_HEIGHT + GK_STATUSBAR_NAVBAR_HEIGHT + 5;
//    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view.mas_left).with.offset(0);
//        make.right.equalTo(self.view.mas_right).with.offset(0);
//        make.top.equalTo(self.view.mas_top).with.offset(0.5);
//        make.bottom.equalTo(self.view.mas_bottom).with.offset(-bottom);
//    }];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
    }];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.coronalSections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.coronalSections[section].items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TSRankSectionItemModel *item = self.coronalSections[indexPath.section].items[indexPath.row];
    Class className = NSClassFromString(item.identify);
    [tableView registerClass:[className class] forCellReuseIdentifier:item.identify];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:item.identify forIndexPath:indexPath];
    if ([cell isKindOfClass:TSUniversalCollectionViewCell.class]) {
        TSUniversalCollectionViewCell *contentCell = (TSUniversalCollectionViewCell *)cell;
        contentCell.indexPath = indexPath;
//        contentCell.cellSuperViewTableView = self.tableView;
//        if ([cell isKindOfClass:TSHomePageContainerCell.class]) {
//            TSHomePageContainerCell *contentCell = (TSHomePageContainerCell *)cell;
//            if (contentCell.containerHeight == 0) {
//                contentCell.containerHeight = kScreenHeight - self.navBackgroundView.bottom - 48;
//            }
//            self.containerView = contentCell.containerView;
//        }
//        contentCell.viewModel = viewModel;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

#pragma mark - JXCategoryListContentViewDelegate
- (UIView *)listView{
    return self.view;
}

#pragma mark - Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        RefreshGifHeader *header = [RefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refreshHeaderDataMehtod)];
        header.indicatorStyle = IndicatorStyleWhite;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.rowHeight = UITableViewAutomaticDimension;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.mj_header = header;
        if (@available(iOS 11.0, *)) {
            _tableView.estimatedRowHeight = 200;
            _tableView.estimatedSectionHeaderHeight = 20;
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}

-(void)setCoronalSections:(NSMutableArray<TSRankSectionModel *> *)coronalSections{
    _coronalSections = coronalSections;
    [self.tableView reloadData];
}


@end
