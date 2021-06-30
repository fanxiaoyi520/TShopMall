//
//  TSRankMonthViewController.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/17.
//

#import "TSRankMonthViewController.h"
#import "TSTableViewBaseCell.h"
#import "TSRankHeaderView.h"
#import "TSPersonalRankView.h"

@interface TSRankMonthViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) TSPersonalRankView * personalRankView;

@end

@implementation TSRankMonthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gk_navigationBar.hidden = YES;
    self.view.backgroundColor = KGrayColor;
}

-(void)fillCustomView{
//    CGFloat bottom = self.view.ts_safeAreaInsets.bottom + 56 + GK_TABBAR_HEIGHT + GK_STATUSBAR_NAVBAR_HEIGHT + 5;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.personalRankView];
//    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view.mas_left).with.offset(0);
//        make.right.equalTo(self.view.mas_right).with.offset(0);
//        make.top.equalTo(self.view.mas_top).with.offset(0.5);
//        make.bottom.equalTo(self.view.mas_bottom).with.offset(-bottom);
//    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(self.personalRankView);
    }];
    
    [self.personalRankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.height.offset(KRateH(70));
        make.bottom.equalTo(self.view).offset(- GK_TABBAR_HEIGHT - GK_STATUSBAR_NAVBAR_HEIGHT - KRateH(42));
    }];
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataController.coronalSections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataController.coronalSections[section].items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TSRankSectionItemModel *item = self.dataController.coronalSections[indexPath.section].items[indexPath.row];
    Class className = NSClassFromString(item.identify);
    [tableView registerClass:[className class] forCellReuseIdentifier:item.identify];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:item.identify forIndexPath:indexPath];
    if ([cell isKindOfClass:TSTableViewBaseCell.class]) {
        TSTableViewBaseCell *contentCell = (TSTableViewBaseCell *)cell;
        contentCell.indexPath = indexPath;
        contentCell.cellSuperViewTableView = self.tableView;
        contentCell.data = item;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    TSRankSectionItemModel *item = self.dataController.coronalSections[indexPath.section].items[indexPath.row];
//    return item.cellHeight;
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    TSRankSectionModel *sectionModel = self.dataController.coronalSections[section];
    if (sectionModel.hasHeader) {
        Class className = NSClassFromString(sectionModel.headerIdentify);
//        [tableView registerClass:[className class] forHeaderFooterViewReuseIdentifier:sectionModel.headerIdentify];
        UIView *headerView = [[className alloc] init];
        
        return headerView;
    }
    
    UIView *view = [UIView new];
    UIView *tempView = [UIView new];
    [view addSubview:tempView];
    [tempView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
        make.height.equalTo(@.2).priorityLow();
    }];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    TSRankSectionModel *sectionModel = self.dataController.coronalSections[section];
    if (sectionModel.hasHeader) {
        return sectionModel.headerSize.height;
    }
    return CGFLOAT_MIN;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}

#pragma mark - Action
- (void)refreshHeaderDataMehtod {
    [self.tableView.mj_header endRefreshing];
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
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, KRateH(70), 0);
        _tableView.mj_header = header;
        if (@available(iOS 11.0, *)) {
            _tableView.estimatedRowHeight = 200;
            _tableView.estimatedSectionHeaderHeight = 20;
            _tableView.estimatedSectionFooterHeight = 1;
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}

- (void)setDataController:(TSRankDataController *)dataController{
    _dataController = dataController;
    [self.tableView reloadData];
}

- (TSPersonalRankView *)personalRankView {
    if (!_personalRankView) {
        _personalRankView = [TSPersonalRankView new];
    }
    return _personalRankView;
}

@end
