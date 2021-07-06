//
//  TSAreaCard.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/18.
//

#import "TSAreaCard.h"
#import "TSEmptyAlertView.h"
#import "TSLocationManager.h"

@interface TSAreaCard()<UITableViewDelegate, UITableViewDataSource>{
    NSInteger currentType;//0-省，1-市，2-区/县, 3-街道
    NSArray *keys;
}
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIButton *closeBtn;
//@property (nonatomic, strong) UILabel *locationTips;
//@property (nonatomic, strong) UIButton *locationBtn;
//@property (nonatomic, strong) UILabel *locationAddress;
@property (nonatomic, strong) TSAreaView *areaView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) TSAreaIndexView *indexView;
@property (nonatomic, strong) TSAreaIndexIndeView *indexIndeView;
@end

@implementation TSAreaCard

- (instancetype)init{
    if (self == [super init]) {
        self.backgroundColor = UIColor.whiteColor;
        self.layer.cornerRadius = KRateW(8.0);
        self.layer.masksToBounds = YES;
        [self updateLocationAddress];
        
        self.provice = [TSAreaModel new];
        self.city = [TSAreaModel new];
        self.area = [TSAreaModel new];
        self.street = [TSAreaModel new];
        
        [self layoutView];
    }
    return self;
}

- (void)updateLocationAddress{
//
//    self.locationTips.text = @"定位到的地址";
//    [TSLocationManager startLocation:^(NSString *address, NSError *error) {
//        if (error) {
//            self.locationAddress.text = @"定位失败";
//            return;
//        } else {
//            self.location = address;
//            self.locationAddress.text = address;
//        }
//    }];
}

- (void)areaViewItemTapped:(TSAreaButton *)sender{
    currentType = sender.tag;
    NSString *belongUuid = @"";
    if (currentType == 1) {
        belongUuid = self.city.belongUuid;
    } else if (currentType == 2){
        belongUuid = self.area.belongUuid;
    } else if (currentType == 3){
        belongUuid = self.street.belongUuid;
    }
    [self.delegate reloadDataWiteType:currentType uuid:belongUuid];
    [self.areaView changeUIOfAreaButtonTapped:currentType];
}

- (void)setDatas:(NSDictionary<NSString *,NSArray *> *)datas{
    _datas = datas;
    keys = [[datas allKeys] sortedArrayUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    self.indexView.indexs = keys;
    [self.tableView reloadData];
    if (keys.count == 0) {
        TSEmptyAlertView.new.alertInfo(@"未查询到数据, 请刷新", @"刷新").alertImage(@"alert_net_error").show(self.tableView, @"top", ^{
            [self.delegate reloadData];
        });
    } else {
        [TSEmptyAlertView hideInView: self.tableView];
    }
    
    [self.indexView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(KRateW(28.0) * keys.count);
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return keys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas[keys[section]].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *key = keys[indexPath.section];
    TSAreaModel *model = self.datas[key][indexPath.row];
    TSAreaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TSAreaCell"];
    cell.mark.hidden = indexPath.row;
    cell.areaModel = model;
    cell.mark.text = keys[indexPath.section];
    cell.des.text = model.currentShowName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *key = keys[indexPath.section];
    TSAreaModel *model = self.datas[key][indexPath.row];
    if (currentType == 0) {
        self.provice = model;
        currentType = 1;
    } else if (currentType == 1){
        self.city = model;
        currentType = 2;
    } else if (currentType == 2){
        self.area = model;
        currentType = 3;
    } else {
        self.street = model;
        currentType = 4;
    }
    //切换显示类型
    [self.areaView updateString:model.currentShowName type:currentType-1];
    [self.delegate reloadDataWiteType:currentType uuid:model.currentUUid];
    
    if (currentType == 4) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.delegate exit];
        });
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return KRateW(45.0);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (currentType == 0 && section == 0) {
        return KRateW(168.0);
    }
    return KRateW(10.0);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UITableViewHeaderFooterView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (currentType == 0 && section == 0) {
        TSAreaHotCityHeader *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TSAreaHotCityHeader"];
        header.hotCities = [TSAreaModel hotCities];
        __weak typeof(self) weakSelf = self;
        header.hotcitySeleted = ^(TSAreaModel *hotCity) {
            weakSelf.provice.uuid = hotCity.provinceUuid;
            weakSelf.provice.provinceName = hotCity.provinceName;
            [weakSelf.areaView updateString:hotCity.provinceName type:0];
            
            weakSelf.city.uuid = hotCity.uuid;
            weakSelf.city.cityName = hotCity.cityName;
            weakSelf.city.provinceUuid = hotCity.provinceUuid;
            self->currentType = 2;
            [weakSelf.areaView updateString:hotCity.cityName type:1];
            [weakSelf.delegate reloadDataWiteType:self->currentType uuid:hotCity.uuid];
        };
        return header;
    }
    return [UITableViewHeaderFooterView new];
}

- (void)layoutView{
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(KRateW(16.0));
        make.top.equalTo(self.mas_top).offset(KRateW(16.0));
        make.height.mas_equalTo(KRateW(22.0));
    }];
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-KRateW(16.0));
        make.width.height.mas_equalTo(KRateW(24.0));
        make.centerY.equalTo(self.title);
    }];
    
//    [self.locationTips mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.title);
//        make.top.equalTo(self.title.mas_bottom).offset(KRateW(8.0));
//        make.height.mas_equalTo(KRateW(22.0));
//    }];
//
//    [self.locationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.locationTips.mas_bottom).offset(KRateW(8.0));
//        make.width.height.mas_equalTo(KRateW(20.0));
//        make.left.equalTo(self.locationTips.mas_left);
//    }];
//
//    [self.locationAddress mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(self.locationBtn);
//        make.left.equalTo(self.locationBtn.mas_right).offset(KRateW(8.0));
//        make.right.equalTo(self.mas_right).offset(-KRateW(8.0));
////        make.height.mas_equalTo(KRateW(22.0));
//    }];
    
    [self.areaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(KRateW(16.0));
        make.right.equalTo(self.mas_right).offset(-KRateW(16.0));
        make.top.equalTo(self.title.mas_bottom).offset(24.0);
        make.height.mas_equalTo(KRateW(44.0));
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom);
        make.top.equalTo(self.areaView.mas_bottom).offset(KRateW(12.0));
    }];
    
    [self.indexView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-KRateW(16.0));
        make.centerY.equalTo(self.tableView);
        make.height.mas_equalTo(0);
        make.width.mas_equalTo(16.0);
    }];
    
    [self.indexIndeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.indexView.mas_left).offset(-KRateW(8.0));
        make.width.mas_equalTo(KRateW(44.0));
        make.height.mas_equalTo(KRateW(36.0));
        make.centerY.equalTo(self.indexView.mas_top);
    }];
}

- (void)hideCard{
    [self.controller performSelector:@selector(hideCard)];
}

- (UILabel *)title{
    if (_title) {
        return _title;
    }
    self.title = [UILabel new];
    self.title.text = @"请选择所在地区";
    self.title.font = KFont(PingFangSCMedium, 16.0);
    self.title.textColor = KHexColor(@"#333333");
    [self addSubview:self.title];
    
    return self.title;
}

- (UIButton *)closeBtn{
    if (_closeBtn) {
        return _closeBtn;
    }
    self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.closeBtn setBackgroundImage:KImageMake(@"general_close") forState:UIControlStateNormal];
    [self.closeBtn addTarget:self action:@selector(hideCard) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.closeBtn];
    
    return self.closeBtn;
}

//- (UILabel *)locationTips{
//    if (_locationTips) {
//        return _locationTips;
//    }
//    self.locationTips = [UILabel new];
//    self.locationTips.font = KRegularFont(14.0);
//    self.locationTips.textColor = [KHexColor(@"#2D3132") colorWithAlphaComponent:0.6];
//    [self addSubview:self.locationTips];
//
//    return self.locationTips;
//}
//
//- (UIButton *)locationBtn{
//    if (_locationBtn) {
//        return _locationBtn;
//    }
//    self.locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [self.locationBtn setBackgroundImage:KImageMake(@"address_located") forState:UIControlStateNormal];
//    [self.locationBtn addTarget:self action:@selector(updateLocationAddress) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:self.locationBtn];
//
//    return self.locationBtn;
//}
//
//- (UILabel *)locationAddress{
//    if (_locationAddress) {
//        return _locationAddress;
//    }
//    self.locationAddress = [UILabel new];
//    self.locationAddress.font = KRegularFont(14.0);
//    self.locationAddress.textColor = KHexColor(@"#2D3132");
//    self.locationAddress.numberOfLines = 0;
//    [self addSubview:self.locationAddress];
//
//    return self.locationAddress;
//}

- (TSAreaView *)areaView{
    if (_areaView) {
        return _areaView;
    }
    self.areaView = [TSAreaView new];
    [self addSubview:self.areaView];
    [self.areaView.proviceBtn addTarget:self action:@selector(areaViewItemTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.areaView.cityBtn addTarget:self action:@selector(areaViewItemTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.areaView.areaBtn addTarget:self action:@selector(areaViewItemTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.areaView.streetBtn addTarget:self action:@selector(areaViewItemTapped:) forControlEvents:UIControlEventTouchUpInside];
    return self.areaView;
}

- (UITableView *)tableView{
    if (_tableView) {
        return _tableView;
    }
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.1)];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 0.1)];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = KHexColor(@"#ffffff");
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self addSubview:self.tableView];
    
    [self.tableView registerClass:[TSAreaCell class] forCellReuseIdentifier:@"TSAreaCell"];
    [self.tableView registerClass:[TSAreaHotCityHeader class] forHeaderFooterViewReuseIdentifier:@"TSAreaHotCityHeader"];
        
    return self.tableView;
}

- (TSAreaIndexView *)indexView{
    if (_indexView) {
        return _indexView;
    }
    self.indexView = [TSAreaIndexView new];
    [self addSubview:self.indexView];
    
    __weak typeof(self) weakSelf = self;
    self.indexView.indexChanged = ^(NSInteger index, NSString *tag) {
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.indexIndeView.indeDes.text = tag;
            [weakSelf.indexIndeView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(weakSelf.indexView.mas_top).offset(KRateW(28.0) * (index + 1) - KRateW(28.0)/2.0);
            }];
            [weakSelf layoutSubviews];
        }];
        
        [weakSelf.tableView scrollToRow:0 inSection:index atScrollPosition:UITableViewScrollPositionTop animated:YES];
    };
    self.indexView.shouldShowIndeImg = ^(BOOL show) {
        [weakSelf.indexIndeView shouldShow:show];
    };
    
    return self.indexView;
}

- (TSAreaIndexIndeView *)indexIndeView{
    if (_indexIndeView) {
        return _indexIndeView;
    }
    self.indexIndeView = [TSAreaIndexIndeView new];
    self.indexIndeView.hidden = YES;
    [self addSubview:self.indexIndeView];
    
    return self.indexIndeView;
}

@end


@implementation TSAreaView

- (instancetype)init{
    if (self == [super init]) {
        self.areaBtns = [NSMutableArray array];
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

- (void)updateString:(NSString *)string type:(NSInteger)type{
    self.areaBtns[type].selectedTitle = string;
    for (NSInteger i=0; i<self.areaBtns.count; i++) {
        TSAreaButton *btn = self.areaBtns[i];
        if (i > type + 1) {
            btn.enabled = NO;
        }
        if (i == type + 1) {
            btn.enabled = YES;
        }
    }
}

- (void)changeUIOfAreaButtonTapped:(NSInteger)type{
    for (NSInteger i=0; i<self.areaBtns.count; i++) {
        TSAreaButton *btn = self.areaBtns[i];
        if (i > type) {
            btn.selected = NO;
            btn.enabled = NO;
        } else if (i == type) {
            btn.selected = NO;
        }
    }
}

- (void)layoutSubviews{
    [self.proviceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self);
        make.height.mas_equalTo(KRateW(44.0));
        make.width.mas_equalTo((kScreenWidth - KRateW(32.0) - KRateW(24.0))/ 4.0);
    }];
    
    [self.cityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.proviceBtn);
        make.left.equalTo(self.proviceBtn.mas_right).offset(KRateW(8.0));
        make.width.equalTo(self.proviceBtn);
    }];
    
    [self.areaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.proviceBtn);
        make.left.equalTo(self.cityBtn.mas_right).offset(KRateW(8.0));
        make.width.equalTo(self.proviceBtn);
    }];
    
    [self.streetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.proviceBtn);
        make.left.equalTo(self.areaBtn.mas_right).offset(KRateW(8.0));
//        make.right.equalTo(self.mas_right).priorityHigh();
        make.width.equalTo(self.proviceBtn);
    }];
}

- (TSAreaButton *)proviceBtn{
    if (_proviceBtn) {
        return _proviceBtn;
    }
    self.proviceBtn = [TSAreaButton new];
    self.proviceBtn.normalTitle = @"选择省份";
    self.proviceBtn.selected = NO;
    self.proviceBtn.enabled = YES;
    self.proviceBtn.tag = 0;
    [self addSubview:self.proviceBtn];
    
    [self.areaBtns addObject:self.proviceBtn];
    
    return self.proviceBtn;
}

- (TSAreaButton *)cityBtn{
    if (_cityBtn) {
        return _cityBtn;
    }
    self.cityBtn = [TSAreaButton new];
    self.cityBtn.normalTitle = @"选择市区";
    self.cityBtn.selected = NO;
    self.cityBtn.tag = 1;
    [self addSubview:self.cityBtn];
    [self.areaBtns addObject:self.cityBtn];
    
    return self.cityBtn;
}

- (TSAreaButton *)areaBtn{
    if (_areaBtn) {
        return _areaBtn;
    }
    self.areaBtn = [TSAreaButton new];
    self.areaBtn.normalTitle = @"选择区/县";
    self.areaBtn.selected = NO;
    self.areaBtn.tag = 2;
    [self addSubview:self.areaBtn];
    [self.areaBtns addObject:self.areaBtn];
    
    return self.areaBtn;
}

- (TSAreaButton *)streetBtn{
    if (_streetBtn) {
        return _streetBtn;
    }
    self.streetBtn = [TSAreaButton new];
    self.streetBtn.normalTitle = @"选择街道";
    self.streetBtn.selected = NO;
    self.streetBtn.tag = 3;
    [self addSubview:self.streetBtn];
    [self.areaBtns addObject:self.streetBtn];
    
    return self.streetBtn;
}

@end

@implementation TSAreaCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews{
    [self.mark mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(KRateW(20.0));
        make.top.bottom.equalTo(self.contentView);
    }];
    
    [self.des mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mark.mas_right).offset(KRateW(18.0));
        make.top.bottom.equalTo(self.contentView);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mark.mas_left);
        make.right.equalTo(self.contentView.mas_right).offset(-KRateW(16.0));
        make.top.equalTo(self.contentView.mas_top);
        make.height.mas_equalTo(0.33);
    }];
}

- (UILabel *)mark{
    if (_mark) {
        return _mark;
    }
    self.mark = [UILabel new];
    self.mark.font = KFont(PingFangSCMedium, 14.0);
    self.mark.textColor = KHexColor(@"#2D3132");
    [self.contentView addSubview:self.mark];
    
    return self.mark;
}

- (UILabel *)des{
    if (_des) {
        return _des;
    }
    self.des = [UILabel new];
    self.des.font = KRegularFont(14.0);
    self.des.textColor = KHexColor(@"#2D3132");
    [self.contentView addSubview:self.des];
    
    return self.des;
}

- (UIView *)line{
    if (_line) {
        return _line;
    }
    self.line = [UIView new];
    self.line.backgroundColor = KHexColor(@"#E6E6E6");
    [self.contentView addSubview:self.line];
    
    return self.line;
}
@end

@implementation TSAreaButton

- (instancetype)init{
    if (self == [super init]) {
        [self setTitleColor:KHexColor(@"#E64C3D") forState:UIControlStateNormal];
        [self setTitleColor:KHexColor(@"#2D3132") forState:UIControlStateSelected];
        [self setTitle:@"" forState:UIControlStateDisabled];
        self.titleLabel.font = KRegularFont(14.0);
        self.titleLabel.numberOfLines = 0;
        self.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
        
        self.enabled = NO;
    }
    return self;
}

- (void)setNormalTitle:(NSString *)normalTitle{
    [self setTitle:normalTitle forState:UIControlStateNormal];
}

- (void)setSelectedTitle:(NSString *)selectedTitle{
    self.selected = YES;
    [self setTitle:selectedTitle forState:UIControlStateSelected];
}

@end


@implementation TSAreaIndexView

- (instancetype)init{
    if (self == [super init]) {
        self.backgroundColor = KHexColor(@"#EAEAEA");
        self.layer.cornerRadius = KRateW(8.0);
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)setIndexs:(NSArray<NSString *> *)indexs{
    _indexs = indexs;
    self.hidden = !indexs.count;
    [self configIndexUI];
}

- (void)tapAction:(UIButton *)sender{
    if (sender.selected == YES) return;
    for (UIButton *btn in self.subviews) {
        if (btn.tag == sender.tag) {
            btn.selected = YES;
        } else {
            btn.selected = NO;
        }
    }
    self.lastTag = sender.tag;
    
    self.shouldShowIndeImg(YES);
    self.indexChanged(sender.tag, self.indexs[sender.tag]);
}

- (void)configIndexUI{
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
    CGFloat h = KRateW(28.0);
    for (NSInteger i=0; i<self.indexs.count; i++) {
        UIButton *btn = [UIButton new];
        [btn setTitleColor:[KHexColor(@"#333333") colorWithAlphaComponent:0.6] forState:UIControlStateNormal];
        [btn setTitleColor:KHexColor(@"#333333") forState:UIControlStateSelected];
        btn.titleLabel.font = KRegularFont(8.0);
        [btn setTitle:self.indexs[i] forState:UIControlStateNormal];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self.mas_top).offset(h * i);
            make.height.mas_equalTo(h);
        }];
        btn.tag = i;
        btn.userInteractionEnabled = NO;
        [btn addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    self.shouldShowIndeImg(YES);
    [self handleTouch:touch];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self defaultUI];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.6 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.shouldShowIndeImg(NO);
    });
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    [self handleTouch:touch];
}

- (void)handleTouch:(UITouch *)touch{
    CGPoint point = [touch locationInView:self];
    NSInteger index = point.y / KRateW(28.0);
    NSString *str = self.indexs[index];
    [self updateBtnStatus:index];
    self.indexChanged(index, str);
}

- (void)defaultUI{
    for (UIButton *btn in self.subviews) {
        btn.selected = NO;
    }
}

- (void)updateBtnStatus:(NSInteger)index{
    if (self.lastTag == index) return;
    self.lastTag = index;
    for (UIButton *btn in self.subviews) {
        if (btn.tag == index) {
            btn.selected = YES;
        } else {
            btn.selected = NO;
        }
    }
}

@end

@implementation TSAreaIndexIndeView

- (instancetype)init{
    if (self == [super init]) {
        self.image = KImageMake(@"address_index_bg");
    }
    return self;
}

- (void)shouldShow:(BOOL)show{
    self.alpha = show==YES? 0:1;
    [UIView animateWithDuration:0.4 animations:^{
        self.alpha = show==YES? 1:0;
    } completion:^(BOOL finished) {
        self.hidden = !show;
    }];
}

- (UILabel *)indeDes{
    if (_indeDes) {
        return _indeDes;
    }
    self.indeDes = [UILabel new];
    self.indeDes.font = KFont(PingFangSCMedium, 24.0);
    self.indeDes.textColor = KHexColor(@"#FFFFFF");
    [self addSubview:self.indeDes];
    [self.indeDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_centerX).offset(-KRateW(3.0));
        make.top.bottom.equalTo(self);
    }];
    
    return self.indeDes;
}


@end


@implementation TSAreaHotCityHeader

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithReuseIdentifier:reuseIdentifier]) {
        [self layoutView];
    }
    return self;
}

- (void)setHotCities:(NSArray<TSAreaModel *> *)hotCities{
    if (self.hotCities.count != 0) {
        return;
    }
    _hotCities = hotCities;
    [self setUpUI];
}

- (void)hotCityTapped:(UIButton *)sender{
    if (self.hotcitySeleted) {
        self.hotcitySeleted(self.hotCities[sender.tag]);
    }
}

- (void)setUpUI{
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            [view removeFromSuperview];
        }
    }
    self.userInteractionEnabled = YES;
    CGFloat width = (kScreenWidth - KRateW(32.0)) / 4.0;
    CGFloat height = KRateW(36.0);
    for (NSInteger i=0; i<self.hotCities.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i;
        btn.titleLabel.font = KRegularFont(14.0);
        [btn setTitleColor:KHexColor(@"#2D3132") forState:UIControlStateNormal];
        [self.contentView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_left).offset(width * (i % 4));
            make.width.mas_equalTo(width);
            make.height.mas_equalTo(height);
            make.top.equalTo(self.title.mas_bottom).offset(KRateH(7.0) + height * (i/4));
        }];
        [btn setTitle:self.hotCities[i].cityName forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(hotCityTapped:) forControlEvents:UIControlEventTouchUpInside];
    }
}


- (void)layoutView{
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(KRateW(16.0));
        make.height.mas_equalTo(KRateW(22.0));
        make.top.equalTo(self.contentView.mas_top).offset(KRateW(14.0));
    }];
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top);
        make.left.equalTo(self.contentView.mas_left).offset(KRateW(16.0));
        make.width.mas_equalTo(kScreenWidth - KRateW(32.0));
        make.height.mas_equalTo(0.36);
    }];
}

- (UILabel *)title{
    if (_title) {
        return _title;
    }
    self.title = [UILabel new];
    self.title.text = @"热门城市";
    self.title.font = KFont(PingFangSCMedium, 14.0);
    self.title.textColor = KHexColor(@"#2D3132");
    [self.contentView addSubview:self.title];
    
    return self.title;
}


- (UIView *)line{
    if (_line) {
        return _line;
    }
    self.line = [UIView new];
    self.line.backgroundColor = KHexColor(@"#E6E6E6");
    [self.contentView addSubview:self.line];
    
    return self.line;
}
@end
