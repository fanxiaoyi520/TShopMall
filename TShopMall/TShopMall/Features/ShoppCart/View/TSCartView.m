//
//  TSCartView.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/8.
//

#import "TSCartView.h"
#import "TSCartCell.h"

@interface TSCartView()<UITableViewDelegate, UITableViewDataSource, TSCartProtocol>{
    
}
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation TSCartView

- (instancetype)init{
    if (self == [super init]) {
        if (@available(iOS 11.0, *)) {
            self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return self;
}

- (void)clearInvalideGoods{}
- (void)goodsSelectedStatusChanged{}
- (void)deleteGoods:(TSCart *)cart{};

- (void)goodsSelected:(TSCart *)cartModel indexPath:(NSIndexPath *)indexPath{
    self.sections[indexPath.section].rows[indexPath.row].obj = cartModel;
    [self.controller performSelector:@selector(goodsSelectedStatusChanged)];
}

- (void)checkGift:(TSCart *)cartModel{
    
}

- (void)goToShopping{
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.sections[section].rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TSCartGoodsRow *row = self.sections[indexPath.section].rows[indexPath.row];
    Class cla = NSClassFromString(row.cellIdentifier);
    [tableView registerClass:cla forCellReuseIdentifier:row.cellIdentifier];
    TSCartBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:row.cellIdentifier];
    cell.obj = row.obj;
    cell.delegate = self;
    cell.indexPath = indexPath;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TSCartGoodsRow *row = self.sections[indexPath.section].rows[indexPath.row];
    return row.rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    TSCartGoodsRow *row = self.sections[indexPath.section].rows[indexPath.row];
    return row.rowHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    TSCartGoodsSection *se = self.sections[section];
    return se.heightForFooter;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    TSCartGoodsSection *se = self.sections[section];
    return se.heightForHeader;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    TSCartGoodsSection *se = self.sections[section];
    Class cla = NSClassFromString(se.footerIdentifier);
    [tableView registerClass:cla forHeaderFooterViewReuseIdentifier:se.footerIdentifier];
    UITableViewHeaderFooterView *footer = [tableView dequeueReusableHeaderFooterViewWithIdentifier:se.footerIdentifier];
    return footer;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    TSCartGoodsSection *se = self.sections[section];
    Class cla = NSClassFromString(se.headerIdentifier);
    [tableView registerClass:cla forHeaderFooterViewReuseIdentifier:se.headerIdentifier];
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:se.headerIdentifier];
    if ([header isKindOfClass:[TSCartInvalidHeader class]]) {
        TSCartInvalidHeader *invalidHeader = (TSCartInvalidHeader *)header;
        [invalidHeader.clear addTarget:self.controller action:@selector(clearInvalideGoods) forControlEvents:UIControlEventTouchUpInside];
    }
    return header;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    TSCartGoodsRow *row = self.sections[indexPath.section].rows[indexPath.row];
    return row.canScrollEdit;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    TSCartGoodsRow *row = self.sections[indexPath.section].rows[indexPath.row];
    [self.controller performSelector:@selector(deleteGoods:) withObject:row.obj];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return @"删除";
}

- (void)layoutSubviews{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

- (UITableView *)tableView{
    if (_tableView) {
        return _tableView;
    }
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.1)];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, KRateW(10.0))];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = KHexColor(@"#F4F4F4");
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self addSubview:self.tableView];
    
    return self.tableView;
}

@end
