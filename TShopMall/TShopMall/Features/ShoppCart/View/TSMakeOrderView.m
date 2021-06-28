//
//  TSMakeOrderView.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/16.
//

#import "TSMakeOrderView.h"
#import "TSMakeOrderBaseCell.h"

@interface TSMakeOrderView()<UITableViewDelegate, UITableViewDataSource>{
    
}
@end

@implementation TSMakeOrderView

- (instancetype)init{
    if (self == [super init]) {
        self.delegate = self;
        self.dataSource = self;
        [self configTable];
    }
    return self;
}

- (void)setSections:(NSMutableArray<TSMakeOrderSection *> *)sections{
    _sections = sections;
    [self reloadData];
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
    TSMakeOrderBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:row.cellIdentifier];
    cell.obj = row.obj;
    cell.delegate = self.controller;
    cell.indexPath = indexPath;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:NSClassFromString(@"TSMakeOrderAddressCell")] ||
        [cell isKindOfClass:NSClassFromString(@"TSMakeOrderAddressTipsCell")]) {
        [self.controller performSelector:@selector(gotoSelectedAddress)];
    }
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
    return header;
}

- (void)configTable{
    self.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.1)];
    self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, KRateW(10.0))];
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.backgroundColor = KHexColor(@"#F4F4F4");
    self.delegate = self;
    self.dataSource = self;
    self.showsVerticalScrollIndicator = NO;
}

- (void)gotoSelectedAddres{}
@end
