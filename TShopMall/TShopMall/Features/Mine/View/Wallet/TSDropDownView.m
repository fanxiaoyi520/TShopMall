//
//  TSDropDownView.m
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/30.
//

#import "TSDropDownView.h"
#import "TSBranchCardModel.h"

@interface TSDropDownCell : UITableViewCell

@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UIView *lineView;

- (void)setModel:(id _Nullable)model;
@end

@implementation TSDropDownCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self jaf_layoutSubView];
    }
    return self;
}

- (void)jaf_layoutSubView {
    [self.contentView addSubview:self.titleLab];
    [self.contentView addSubview:self.lineView];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(16);
        make.width.mas_equalTo(kScreenWidth-32);
        make.height.mas_equalTo(22);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(32);
        make.left.equalTo(self).offset(16);
        make.left.equalTo(self).offset(-16);
        make.width.mas_equalTo(kScreenWidth-32);
        make.height.mas_equalTo(1);
    }];
}

// MARK: model
- (void)setModel:(id _Nullable)model {
    if (!model) return;
    TSBranchCardModel *kModel = model;
    _titleLab.text = kModel.bankFullName;
}

// MARK: get
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.textColor = KHexColor(@"#2D3132");
        _titleLab.font = KRegularFont(14);
        _titleLab.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLab;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = KHexColor(@"##E6E6E6");
    }
    return _lineView;
}
@end

@interface TSDropDownView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,strong) UITableView *searchTableView;
@property (nonatomic ,strong) NSArray *dataList;
@end

@implementation TSDropDownView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self jaf_layoutSubView];
    }
    return self;
}

- (void)jaf_layoutSubView {
    [self addSubview:self.searchTableView];
    self.searchTableView.frame = CGRectMake(0, 0, self.width, self.height);
}

// MARK: model
- (void)setModel:(id _Nullable)model {
    self.dataList = [NSMutableArray arrayWithArray:(NSArray *)model];
    
    [self.searchTableView reloadData];
}

// MARK: get
- (UITableView *)searchTableView {
    if (!_searchTableView) {
        _searchTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _searchTableView.delegate = self;
        _searchTableView.dataSource = self;
        _searchTableView.showsVerticalScrollIndicator = NO;
        _searchTableView.showsHorizontalScrollIndicator = NO;
        _searchTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_searchTableView registerClass:TSDropDownCell.class forCellReuseIdentifier:@"cellid"];
    }
    return _searchTableView;
}

// MARK: UITableViewDelegate & UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataList || self.dataList.count>0)
        return self.dataList.count;
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellid" forIndexPath:indexPath];
    if ([cell isKindOfClass:TSDropDownCell.class]) {
        TSDropDownCell *kCell = (TSDropDownCell *)cell;
        [kCell setModel:self.dataList[indexPath.row]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 33;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (self.selectBranchBlock) {
        self.selectBranchBlock(self.dataList[indexPath.row]);
    }
}
@end

