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
}
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) UILabel *locationTips;
@property (nonatomic, strong) UIButton *locationBtn;
@property (nonatomic, strong) UILabel *locationAddress;
@property (nonatomic, strong) TSAreaView *areaView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) TSAreaIndexView *indexView;
@end

@implementation TSAreaCard

- (instancetype)init{
    if (self == [super init]) {
        self.backgroundColor = UIColor.whiteColor;
        self.layer.cornerRadius = KRateW(8.0);
        self.layer.masksToBounds = YES;
//        [self layoutView];
        [self updateLocationAddress];
        self.areaView.proviceBtn.str = @"init";
        self.areaView.cityBtn.hidden = YES;
    }
    return self;
}

- (void)updateLocationAddress{
    self.title.text = @"请选择所在地区";
    self.locationTips.text = @"定位到的地址";
    
    [TSLocationManager defaultManager].startLocation(^(CLPlacemark *placemark, NSError *error) {
        if (error) {
            self.locationAddress.text = @"定位失败";
            return;
        } else {
            NSString *city = placemark.locality.length==0? placemark.administrativeArea:placemark.locality;
            NSString *area = placemark.subLocality;
            NSString *street = placemark.thoroughfare;
            NSString *subStreet = placemark.subThoroughfare;
            self.locationAddress.text = [NSString stringWithFormat:@"%@%@%@%@", city, area, street, subStreet];
        }
    });
}

- (void)areaViewItemTapped:(UITapGestureRecognizer *)tapGes{
    currentType = tapGes.view.tag;
    NSString *belongUuid = @"";
    if (currentType == 1) {
        belongUuid = self.city.belongUuid;
    } else if (currentType == 2){
        belongUuid = self.area.belongUuid;
    } else if (currentType == 3){
        belongUuid = self.street.belongUuid;
    }
    [self.delegate reloadDataWiteType:tapGes.view.tag uuid:belongUuid];
    if (currentType == 0) {
        self.areaView.cityBtn.str = @"";
        self.areaView.areaBtn.str = @"";
        self.areaView.streetBtn.str = @"";
        self.city = nil;
        self.area = nil;
        self.street = nil;
        self.areaView.cityBtn.hidden = YES;
        self.areaView.areaBtn.hidden = YES;
        self.areaView.streetBtn.hidden = YES;
    } else if (currentType == 1) {
        self.areaView.areaBtn.str = @"";
        self.areaView.streetBtn.str = @"";
        self.area = nil;
        self.street = nil;
        self.areaView.areaBtn.hidden = YES;
        self.areaView.streetBtn.hidden = YES;
    } else {
        self.areaView.streetBtn.str = @"";
        self.street = nil;
        self.areaView.streetBtn.hidden = YES;
    }
}

- (void)setDatas:(NSDictionary<NSString *,NSArray *> *)datas{
    _datas = datas;
    [self.tableView reloadData];
    self.indexView.indexs = [datas allKeys];
    if ([datas allKeys].count == 0) {
        TSEmptyAlertView.new.alertInfo(@"网络异常, 请刷新", @"刷新").alertImage(@"alert_net_error").show(self.tableView, @"top", ^{
            [self.delegate reloadData];
        });
    } else {
        [TSEmptyAlertView hideInView: self.tableView];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.datas.allKeys.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datas[self.datas.allKeys[section]].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TSAreaModel *model = self.datas[self.datas.allKeys[indexPath.section]][indexPath.row];
    TSAreaCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TSAreaCell"];
    cell.mark.hidden = indexPath.row;
    cell.areaModel = model;
    cell.mark.text = [self.datas allKeys][indexPath.section];
    cell.des.text = model.currentShowName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TSAreaModel *model = self.datas[self.datas.allKeys[indexPath.section]][indexPath.row];
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
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return KRateW(45.0);
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return KRateW(10.0);
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UITableViewHeaderFooterView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [UITableViewHeaderFooterView new];
}

- (void)layoutSubviews{
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
    
    [self.locationTips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.title);
        make.top.equalTo(self.title.mas_bottom).offset(KRateW(8.0));
        make.height.mas_equalTo(KRateW(22.0));
    }];
    
    [self.locationBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.locationTips.mas_bottom).offset(KRateW(8.0));
        make.width.height.mas_equalTo(KRateW(20.0));
        make.left.equalTo(self.locationTips.mas_left);
    }];
    
    [self.locationAddress mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.locationBtn);
        make.left.equalTo(self.locationBtn.mas_right).offset(KRateW(8.0));
        make.height.mas_equalTo(KRateW(22.0));
    }];
    
    [self.areaView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(KRateW(16.0));
        make.right.equalTo(self.mas_right).offset(-KRateW(16.0));
        make.top.equalTo(self.locationAddress.mas_bottom).offset(24.0);
        make.height.mas_equalTo(KRateW(24.0));
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(self.mas_bottom);
        make.top.equalTo(self.areaView.mas_bottom).offset(KRateW(12.0));
    }];
    
    [self.indexView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-KRateW(16.0));
        make.centerY.equalTo(self.tableView);
        make.height.mas_equalTo(KRateW(390.0));
        make.width.mas_equalTo(72.0);
    }];
}

- (void)hideCard{}

- (UILabel *)title{
    if (_title) {
        return _title;
    }
    self.title = [UILabel new];
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
    [self.closeBtn addTarget:self.controller action:@selector(hideCard) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.closeBtn];
    
    return self.closeBtn;
}

- (UILabel *)locationTips{
    if (_locationTips) {
        return _locationTips;
    }
    self.locationTips = [UILabel new];
    self.locationTips.font = KRegularFont(14.0);
    self.locationTips.textColor = [KHexColor(@"#2D3132") colorWithAlphaComponent:0.6];
    [self addSubview:self.locationTips];
    
    return self.locationTips;
}

- (UIButton *)locationBtn{
    if (_locationBtn) {
        return _locationBtn;
    }
    self.locationBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.locationBtn setBackgroundImage:KImageMake(@"address_located") forState:UIControlStateNormal];
    [self.locationBtn addTarget:self action:@selector(updateLocationAddress) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.locationBtn];
    
    return self.locationBtn;
}

- (UILabel *)locationAddress{
    if (_locationAddress) {
        return _locationAddress;
    }
    self.locationAddress = [UILabel new];
    self.locationAddress.font = KRegularFont(14.0);
    self.locationAddress.textColor = KHexColor(@"#2D3132");
    [self addSubview:self.locationAddress];
    
    return self.locationAddress;
}

- (TSAreaView *)areaView{
    if (_areaView) {
        return _areaView;
    }
    self.areaView = [TSAreaView new];
    [self addSubview:self.areaView];
    [self.areaView.proviceBtn addTarget:self selector:@selector(areaViewItemTapped:)];
    [self.areaView.cityBtn addTarget:self selector:@selector(areaViewItemTapped:)];
    [self.areaView.areaBtn addTarget:self selector:@selector(areaViewItemTapped:)];
    [self.areaView.streetBtn addTarget:self selector:@selector(areaViewItemTapped:)];
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
        
    return self.tableView;
}

- (TSAreaIndexView *)indexView{
    if (_indexView) {
        return _indexView;
    }
    self.indexView = [TSAreaIndexView new];
    [self addSubview:self.indexView];
    
    __weak typeof(self) weakSelf = self;
    self.indexView.indexChanged = ^(NSInteger index) {
        [weakSelf.tableView scrollToRow:0 inSection:index atScrollPosition:UITableViewScrollPositionTop animated:YES];
    };
    
    return self.indexView;
}
@end


@implementation TSAreaView

- (void)dealloc{
    [self.proviceBtn removeObserver:self forKeyPath:@"text" context:nil];
    [self.cityBtn removeObserver:self forKeyPath:@"text" context:nil];
    [self.areaBtn removeObserver:self forKeyPath:@"text" context:nil];
    [self.streetBtn removeObserver:self forKeyPath:@"text" context:nil];
}

- (instancetype)init{
    if (self == [super init]) {
        [self.proviceBtn addObserver:self forKeyPath:@"text" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
        [self.cityBtn addObserver:self forKeyPath:@"text" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
        [self.areaBtn addObserver:self forKeyPath:@"text" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
        [self.streetBtn addObserver:self forKeyPath:@"text" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
        self.proviceBtn.text = @"";
        self.showsHorizontalScrollIndicator = NO;
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
//    self.cityBtn.hidden = !self.proviceBtn.str.length;
//    self.areaBtn.hidden = !self.cityBtn.str.length;
//    self.streetBtn.hidden = !self.areaBtn.str.length;
    if (object == self.proviceBtn && self.proviceBtn.str.length != 0) {
        self.cityBtn.str = @"init";
        self.cityBtn.hidden = NO;
        self.areaBtn.hidden = YES;
        self.streetBtn.hidden = YES;
    }
    if (object == self.cityBtn && self.cityBtn.str.length != 0) {
        self.areaBtn.str = @"init";
        self.areaBtn.hidden = NO;
        self.streetBtn.hidden = YES;
    }
    if (object == self.areaBtn && self.areaBtn.str.length != 0) {
        self.streetBtn.str = @"init";
        self.streetBtn.hidden = NO;
    }
}

- (void)updateString:(NSString *)string type:(NSInteger)type{
    if (type == 0) {
        self.proviceBtn.str = string;
    } else if (type == 1) {
        self.cityBtn.str = string;
    } else if (type == 2) {
        self.areaBtn.str = string;
    } else {
        self.streetBtn.str = string;
    }
}

- (void)layoutSubviews{
    [self.proviceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
    }];
    
    [self.cityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.proviceBtn);
        make.left.equalTo(self.proviceBtn.mas_right).offset(KRateW(12.0));
    }];
    
    [self.areaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.proviceBtn);
        make.left.equalTo(self.cityBtn.mas_right).offset(KRateW(12.0));
    }];
    
    [self.streetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.proviceBtn);
        make.left.equalTo(self.areaBtn.mas_right).offset(KRateW(12.0));
        make.right.equalTo(self.mas_right).priorityHigh();
    }];
    
//    [self layoutIfNeeded];
//    self.contentSize = CGSizeMake(self.streetBtn.x+self.streetBtn.width, 0);
}

- (TSAreaLable *)proviceBtn{
    if (_proviceBtn) {
        return _proviceBtn;
    }
    self.proviceBtn = [TSAreaLable new];
    self.proviceBtn.tag = 0;
    self.proviceBtn.placeholder = @"选择省份";
    [self addSubview:self.proviceBtn];
    
    return self.proviceBtn;
}

- (TSAreaLable *)cityBtn{
    if (_cityBtn) {
        return _cityBtn;
    }
    self.cityBtn = [TSAreaLable new];
    self.cityBtn.tag = 1;
    self.cityBtn.placeholder = @"选择市区";
    [self addSubview:self.cityBtn];
    
    return self.cityBtn;
}

- (TSAreaLable *)areaBtn{
    if (_areaBtn) {
        return _areaBtn;
    }
    self.areaBtn = [TSAreaLable new];
    self.areaBtn.tag = 2;
    self.areaBtn.placeholder = @"选择区/县";
    [self addSubview:self.areaBtn];
    
    return self.areaBtn;
}

- (TSAreaLable *)streetBtn{
    if (_streetBtn) {
        return _streetBtn;
    }
    self.streetBtn = [TSAreaLable new];
    self.streetBtn.tag = 3;
    self.streetBtn.placeholder = @"选择街道";
    [self addSubview:self.streetBtn];
    
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


@implementation TSAreaLable
- (instancetype)init{
    if (self == [super init]) {
        self.text = @"";
        self.font = KFont(PingFangSCMedium, 14.0);
        
        [self addObserver:self forKeyPath:@"str" options:NSKeyValueObservingOptionNew context:nil];
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if (self.str.length == 0 || [self.str isEqualToString:@"init"]) {
        self.text = self.placeholder;
        self.textColor = KHexColor(@"#E64C3D");
    } else {
        self.textColor = KHexColor(@"#2D3132");
        self.text = self.str;
        self.hidden = NO;
    }
}

- (void)addTarget:(id)target selector:(SEL)selector{
    self.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
    tapGes.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tapGes];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    return NO;
}

@end


@implementation TSAreaIndexView

- (instancetype)init{
    if (self == [super init]) {
        [self layouView];
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
    for (UIButton *btn in self.bgView.subviews) {
        if (btn.tag == sender.tag) {
            btn.selected = YES;
        } else {
            btn.selected = NO;
        }
    }
    self.lastTag = sender.tag;
    [self updateIndeImgae:sender.tag];
    self.indeDes.text = self.indexs[sender.tag];
}

- (void)configIndexUI{
    for (UIView *view in self.bgView.subviews) {
        [view removeFromSuperview];
    }
    [self.bgView layoutIfNeeded];
    CGFloat h = self.bgView.height / self.indexs.count;
    self.btnHeight = h;
    for (NSInteger i=0; i<self.indexs.count; i++) {
        UIButton *btn = [UIButton new];
        [btn setTitleColor:[KHexColor(@"#333333") colorWithAlphaComponent:0.6] forState:UIControlStateNormal];
        [btn setTitleColor:KHexColor(@"#333333") forState:UIControlStateSelected];
        btn.titleLabel.font = KRegularFont(8.0);
        [btn setTitle:self.indexs[i] forState:UIControlStateNormal];
        [self.bgView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.bgView);
            make.top.equalTo(self.bgView.mas_top).offset(h * i);
            make.height.mas_equalTo(h);
        }];
        btn.tag = i;
        [btn addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)bgViewPanGestureAction:(UIPanGestureRecognizer *)panGes{
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    [self handleTouch:touch];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self defaultUI];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    UITouch *touch = [touches anyObject];
    [self handleTouch:touch];
}

- (void)handleTouch:(UITouch *)touch{
    CGPoint point = [touch locationInView:self];
    CGFloat availableX = self.frame.size.width - KRateW(16.0);
    if (point.x >= availableX) {
        self.indeImg.hidden = NO;
        self.indeImg.alpha = 1;
        NSInteger index = point.y / self.btnHeight;
        NSString *str = self.indexs[index];
        self.indeDes.text = str;
        [self updateBtnStatus:index];
        [self updateIndeImgae:index];
        if (self.indexChanged) {
            self.indexChanged(index);
        }
    } else {
        [self performSelector:@selector(defaultUI) afterDelay:2.3];
    }
}

- (void)defaultUI{
    [UIView animateWithDuration:0.4 animations:^{
        self.indeImg.alpha = 0;
    } completion:^(BOOL finished) {
        self.indeImg.hidden = YES;
    }];
    
    for (UIButton *btn in self.bgView.subviews) {
        btn.selected = NO;
    }
}

- (void)updateBtnStatus:(NSInteger)index{
    if (self.lastTag == index) return;
    self.lastTag = index;
    for (UIButton *btn in self.bgView.subviews) {
        if (btn.tag == index) {
            btn.selected = YES;
        } else {
            btn.selected = NO;
        }
    }
}

- (void)updateIndeImgae:(NSInteger)index{
    [UIView animateWithDuration:0.3 animations:^{
        [self.indeImg mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.bgView.mas_top).offset(self.btnHeight * (index + 1) - self.btnHeight/2.0);
        }];
        [self layoutSubviews];
    }];
}

- (void)layouView{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self);
        make.width.mas_equalTo(KRateW(16.0));
    }];
    
    [self.indeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView.mas_left).offset(-KRateW(8.0));
        make.width.mas_equalTo(KRateW(44.0));
        make.height.mas_equalTo(KRateW(36.0));
        make.centerY.equalTo(self.bgView.mas_top).offset(self.btnHeight);
    }];
    
    [self.indeDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.indeImg.mas_centerX).offset(-KRateW(3.0));
        make.top.bottom.equalTo(self.indeImg);
    }];
}

- (UIView *)bgView{
    if (_bgView) {
        return _bgView;
    }
    self.bgView = [UIView new];
    self.bgView.layer.cornerRadius = KRateW(8.0);
    self.bgView.layer.masksToBounds = YES;
    self.bgView.backgroundColor = KHexColor(@"#EAEAEA");
    [self addSubview:self.bgView];
    self.bgView.userInteractionEnabled = NO;
    
    return self.bgView;
}

- (UIImageView *)indeImg{
    if (_indeImg) {
        return _indeImg;
    }
    self.indeImg = [UIImageView new];
    self.indeImg.hidden = YES;
    self.indeImg.image = KImageMake(@"address_index_bg");
    [self addSubview:self.indeImg];
    
    return self.indeImg;
}

- (UILabel *)indeDes{
    if (_indeDes) {
        return _indeDes;
    }
    self.indeDes = [UILabel new];
    self.indeDes.font = KFont(PingFangSCMedium, 24.0);
    self.indeDes.textColor = KHexColor(@"#FFFFFF");
    [self.indeImg addSubview:self.indeDes];
    
    return self.indeDes;
}

@end
