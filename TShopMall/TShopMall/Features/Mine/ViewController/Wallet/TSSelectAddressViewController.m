//
//  TSSelectAddressViewController.m
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/7/1.
//

#import "TSSelectAddressViewController.h"
#import "TSSelectorCell.h"
#import "UIView+Plugin.h"
#import "TSMineDataController.h"
#import "TSProvinceListModel.h"
#import "TSSelectProvincesCitiesCell.h"
#import "UILabel+size.h"
#import "TSWalletAreaIndexView.h"

@interface TSSelectAddressViewController ()<UITableViewDelegate,UITableViewDataSource,TSSelectorCellAddressDelegate>

@property (nonatomic ,strong) UIView *bgView;
@property (nonatomic ,strong) UITableView *selectorTableView;
@property (nonatomic ,strong) TSMineDataController *dataController;
@property (nonatomic ,strong) NSArray *dataList;
@property (nonatomic ,strong) NSMutableDictionary *mDic;
@property (nonatomic ,strong) TSSelectorCellAddressHeader *headerCellView;
@property (nonatomic ,strong) TSSelectorAddressHeader *headerView;
@property (nonatomic ,strong) NSMutableDictionary *transmitDic;
@property (nonatomic, strong) TSWalletAreaIndexView *indexView;

@end

@implementation TSSelectAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.transmitDic = [NSMutableDictionary dictionary];
    [self.transmitDic setValue:@"" forKey:@"bankAddressProvince"];
    [self.transmitDic setValue:@"" forKey:@"bankAddressProvinceCode"];
    [self.transmitDic setValue:@"" forKey:@"bankAddressCity"];
    [self.transmitDic setValue:@"" forKey:@"bankAddressCityCode"];
    
    [self.view addSubview:self.bgView];
    self.bgView.frame = CGRectMake(0, 117, kScreenWidth, kScreenHeight-117);
    [self.bgView jaf_customFilletRectCorner:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(12, 12)];
    
    TSSelectorAddressHeader *headerView = [[TSSelectorAddressHeader alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 56)];
    [headerView jaf_customFilletRectCorner:UIRectCornerTopRight | UIRectCornerTopLeft cornerRadii:CGSizeMake(12, 12)];
    headerView.kDelegate = self;
    [self.bgView addSubview:headerView];
    self.headerView = headerView;
    
    TSSelectorCellAddressHeader *headerCellView = [[TSSelectorCellAddressHeader alloc] initWithFrame:CGRectMake(0, headerView.bottom, kScreenWidth, 0)];
    headerCellView.kDelegate = self;
    self.headerCellView = headerCellView;
    self.headerCellView.hidden = YES;
    [self.bgView addSubview:headerCellView];
    
    [self.bgView addSubview:self.selectorTableView];
    self.selectorTableView.frame = CGRectMake(0, headerCellView.bottom, kScreenWidth, self.bgView.height-headerView.height);
    
    self.mDic = [NSMutableDictionary dictionary];
    @weakify(self);
    [self.dataController fetchGetAllProvinceDataComplete:^(BOOL isSucess) {
        @strongify(self);
        if (isSucess) {
            self.mDic = [self handleData:self.dataController.provinceListArray];
            self.dataList = [self reqDiction:self.mDic];
            self.indexView.indexs = [self.mDic allKeys];
            [self.selectorTableView reloadData];
        }
    }];
}

- (NSMutableDictionary *)handleData:(NSArray <TSProvinceListModel *>*)array {
    NSMutableDictionary *mDic = [NSMutableDictionary new];
    for (TSProvinceListModel *model in array) {
        // 将中文转换为拼音
        NSString *name = nil;
        if (model.provinceName) {
            name = model.provinceName;
        } else {
            name = model.cityName;
        }
        NSString *cityMutableString = [NSMutableString stringWithString:name];
        CFStringTransform((__bridge CFMutableStringRef)cityMutableString, NULL, kCFStringTransformMandarinLatin, NO);
        CFStringTransform((__bridge CFMutableStringRef)cityMutableString, NULL, kCFStringTransformStripCombiningMarks, NO);
        // 拿到首字母作为key
        NSString *firstLetter = [[cityMutableString uppercaseString] substringToIndex:1];
        // 检查是否有firstLetter对应的分组存在, 有的话直接把city添加到对应的分组中
        // 没有的话, 新建一个以firstLetter为key的分组

        if ([mDic objectForKey:firstLetter]) {
            NSMutableArray * mCityArray = mDic[firstLetter];
            if (mCityArray) {
                [mCityArray addObject:model];
                mDic[firstLetter] = mCityArray;
            }else{
                mDic[firstLetter] = [NSMutableArray arrayWithArray:@[model]];
            }
        }else{
            [mDic setObject:[NSMutableArray arrayWithArray:@[model]] forKey:firstLetter];
        }
    }
    return mDic;
}

//通过取出字典的所有key值，利用sortedArrayUsingComparator进行降序排序
- (NSArray *)reqDiction:(NSDictionary *)dict{
    NSArray *allKeyArray = [dict allKeys];
    NSArray *afterSortKeyArray = [allKeyArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSComparisonResult resuest = [obj1 compare:obj2];  //[obj1 compare:obj2]：升序
        return resuest;
    }];
    NSMutableArray *valueArray = [NSMutableArray array];
    for (NSString *sortsing in afterSortKeyArray) {
        NSString *valueString = [dict objectForKey:sortsing];
        [valueArray addObject:valueString];
    }
    return afterSortKeyArray;
}

// MARK: UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.dataList || self.dataList.count > 0)
        return self.dataList.count;
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataList || self.dataList.count > 0) {
        NSString *titles = self.dataList[section];
        NSArray *array = self.mDic[titles];
        return array.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellid = [NSString stringWithFormat:@"cellid%ld%ld",indexPath.section,indexPath.row];
    TSSelectProvincesCitiesCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[TSSelectProvincesCitiesCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid withIndexPath:indexPath];
    }
    NSString * titles = self.dataList[indexPath.section];
    [cell setModel:self.mDic[titles][indexPath.row] titles:titles];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return .01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [UIView new];
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == self.dataList.count-1)
        return .01;
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = KWhiteColor;
    UIView *lineView = [UIView new];
    lineView.backgroundColor = KHexAlphaColor(@"#2D3132", .1);
    lineView.frame = CGRectMake(16, 0, kScreenWidth-32, 1);
    [view addSubview:lineView];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSString * titles = self.dataList[indexPath.section];
    TSProvinceListModel *model = self.mDic[titles][indexPath.row];
    
    if (model.provinceName) {
        [self.transmitDic setValue:model.provinceName forKey:@"bankAddressProvince"];
        [self.transmitDic setValue:model.uuid forKey:@"bankAddressProvinceCode"];
        
        //**************************UI设置**************************//
        self.headerCellView.hidden = NO;
        self.headerCellView.frame = CGRectMake(0, self.headerView.bottom, kScreenWidth, 50);
        self.selectorTableView.top = self.headerCellView.bottom;
        
        [self.headerCellView.oneTitleBtn setTitle:model.provinceName forState:UIControlStateNormal];
        self.headerCellView.oneTitleBtn.width = [UILabel labelWidthWithText:model.provinceName height:22 font:KRegularFont(14)];
        [self.headerCellView.oneTitleBtn setTitleColor:KHexColor(@"#2D3132") forState:UIControlStateNormal];
        self.headerCellView.secondTitleBtn.hidden = NO;
        //**************************UI设置**************************//

        self.dataController.provinceListModel = model;
        @weakify(self);
        [self.dataController fetchGetAllCityByProvinceUuidDataComplete:^(BOOL isSucess) {
            @strongify(self);
            if (isSucess) {
                self.mDic = [self handleData:self.dataController.provinceListArray];
                self.dataList = [self reqDiction:self.mDic];
                self.indexView.indexs = [self.mDic allKeys];
                [self.selectorTableView reloadData];
            }
        }];
    } else {
        [self.transmitDic setValue:model.cityName forKey:@"bankAddressCity"];
        [self.transmitDic setValue:model.uuid forKey:@"bankAddressCityCode"];
        if (self.selectAddressBlock) {
            self.selectAddressBlock(self.transmitDic);
        }
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

// MARK: TSSelectorCellAddressDelegate
- (void)selectorCellAddressHeaderAction:(id _Nullable)sender {
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == 100) {
        //**************************UI设置**************************//
        self.headerCellView.secondTitleBtn.hidden = YES;
        //**************************UI设置**************************//
        
        @weakify(self);
        [self.dataController fetchGetAllProvinceDataComplete:^(BOOL isSucess) {
            @strongify(self);
            if (isSucess) {
                self.mDic = [self handleData:self.dataController.provinceListArray];
                self.dataList = [self reqDiction:self.mDic];
                self.indexView.indexs = [self.mDic allKeys];
                [self.selectorTableView reloadData];
            }
        }];
        return;
    }
}

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
        _selectorTableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _selectorTableView.delegate = self;
        _selectorTableView.dataSource = self;
        _selectorTableView.showsVerticalScrollIndicator = NO;
        _selectorTableView.showsHorizontalScrollIndicator = NO;
        _selectorTableView.backgroundColor = KWhiteColor;
        _selectorTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _selectorTableView;
}

- (TSWalletAreaIndexView *)indexView{
    if (_indexView) {
        return _indexView;
    }
    self.indexView = [TSWalletAreaIndexView new];
    [self.view addSubview:self.indexView];
    
    __weak typeof(self) weakSelf = self;
    self.indexView.indexChanged = ^(NSInteger index) {
        [weakSelf.selectorTableView scrollToRow:0 inSection:index atScrollPosition:UITableViewScrollPositionTop animated:YES];
    };
    
    return self.indexView;
}

- (TSMineDataController *)dataController {
    if (!_dataController) {
        _dataController = [[TSMineDataController alloc] init];
    }
    return _dataController;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self.indexView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view.mas_right).offset(-KRateW(16.0));
        make.centerY.equalTo(self.selectorTableView);
        make.height.mas_equalTo(KRateW(390.0));
        make.width.mas_equalTo(72.0);
    }];
}

@end

