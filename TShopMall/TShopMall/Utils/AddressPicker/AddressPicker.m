//
//  AddressPicker.m
//  TCLPlus
//
//  Created by kobe on 2020/8/24.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import "AddressHeaderView.h"
#import "AddressPickerCell.h"
#import "AddressPickerHotCityHeaderView.h"
#import "AddressPickerIndexView.h"

#import "AddressPickerHotCityModel.h"
#import "AddressPickerModel.h"

#import "AddressPicker.h"
#import "Masonry.h"
#import "MineConst.h"
#import "Popover.h"

#import "NSString+Time.h"
#import "UIColor+Plugin.h"
#import "UIView+DefaultPageView.h"
#import "UIView+Extension.h"
#import "UIView+Plugin.h"

#define kAddressPickerWidth [UIScreen mainScreen].bounds.size.width
#define kAddressPickerHeight [UIScreen mainScreen].bounds.size.height
#define kTipMarginW 23
#define kDelayTime 0.25
#define kTopViewH 56
#define kAddressInfoViewH 48
#define kMargin 16
#define kItemH 20
#define kTipLabW (kAddressPickerWidth - kMargin * 2) / 4
#define kTipLabMaxW (kTCLScreenW - 2 * kMargin - 3 * kTipMarginW) / 4


@interface AddressPicker () <UITableViewDelegate, UITableViewDataSource, AddressPickerIndexViewDelegate>

@property (nonatomic, strong, nullable) UIView *backgroundView;
@property (nonatomic, strong, nullable) UIView *containerView;
@property (nonatomic, strong, nullable) CAShapeLayer *shapeLayer;
@property (nonatomic, strong, nullable) UIView *topView;
@property (nonatomic, strong, nullable) UILabel *tipLab;
@property (nonatomic, strong, nullable) UIImageView *deleteIcon;
@property (nonatomic, strong, nullable) UIView *addressInfoView;
@property (nonatomic, strong, nullable) UILabel *provinceLab;
@property (nonatomic, strong, nullable) UILabel *cityLab;
@property (nonatomic, strong, nullable) UILabel *areaLab;
@property (nonatomic, strong, nullable) UILabel *townLab;
@property (nonatomic, strong, nullable) UIView *bottomLine;
@property (nonatomic, strong, nullable) NSMutableArray *itemArrs;
@property (nonatomic, strong, nullable) UILabel *addressTip;
@property (nonatomic, strong, nullable) UITableView *tableView;

// IoT头部定位
@property (nonatomic, strong, nullable) AddressHeaderView *locationTopView;

@property (nonatomic, strong, nullable) NSDictionary *provinceDict;
@property (nonatomic, strong, nullable) NSDictionary *cityDict;
@property (nonatomic, strong, nullable) NSDictionary *areaDict;
@property (nonatomic, strong, nullable) NSDictionary *townDict;

@property (nonatomic, assign) BOOL isFetchProvince;
@property (nonatomic, assign) BOOL isFetchCity;
@property (nonatomic, assign) BOOL isFetchArea;
@property (nonatomic, assign) BOOL isFetchTown;

@property (nonatomic, strong, nullable) AddressPickerProvinceItemModel *selectedProvinceItemModel;
@property (nonatomic, strong, nullable) AddressPickerCityItemModel *selectedCityItemModel;
@property (nonatomic, strong, nullable) AddressPickerAreaItemModel *selectedAreaItemModel;
@property (nonatomic, strong, nullable) AddressPickerTownItemModel *selectedTownIteModel;

@property (nonatomic, strong, nullable) UIActivityIndicatorView *indicatorView;
@property (nonatomic, strong, nullable) AddressPickerIndexView *indexView;

@end


@implementation AddressPicker

static NSString *const addressPickerCellID = @"addressPickerCellID";
static NSString *const addressPickerHeaderViewID = @"addressPickerHeaderViewID";


#pragma mark - lazyLoad
- (UIView *)backgroundView {
    if (!_backgroundView) {
        _backgroundView = [UIView new];
        _backgroundView.frame = CGRectMake(0, 0, kAddressPickerWidth, kAddressPickerHeight);
        _backgroundView.backgroundColor = [UIColor colorWithHexString:@"#333333" alpha:0.5];
        UITapGestureRecognizer *tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapped:)];
        [_backgroundView addGestureRecognizer:tapGR];
    }
    return _backgroundView;
}


- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [UIView new];
        _containerView.frame = CGRectMake(0, kAddressPickerHeight, kAddressPickerWidth, kAddressPickerHeight - 117);
        _containerView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    }
    return _containerView;
}


- (UIView *)topView {
    if (!_topView) {
        _topView = [UIView new];
        _topView.frame = CGRectMake(0, 0, kAddressPickerWidth, kTopViewH);
    }
    return _topView;
}


- (UILabel *)tipLab {
    if (!_tipLab) {
        _tipLab = [UILabel new];
        _tipLab.frame = CGRectMake(kMargin, 0, kAddressPickerWidth - 60, kTopViewH);
        _tipLab.font = [UIFont systemFontOfSize:16 weight:UIFontWeightMedium];
        _tipLab.textColor = [UIColor colorWithHexString:@"#333333"];
        _tipLab.text = @"请选择所在地区";
    }
    return _tipLab;
}


- (UIImageView *)deleteIcon {
    if (!_deleteIcon) {
        _deleteIcon = [UIImageView new];
        _deleteIcon.frame = CGRectMake(kAddressPickerWidth - 40, 16, 24, 24);
        _deleteIcon.userInteractionEnabled = YES;
        _deleteIcon.image = [UIImage imageNamed:@"pickerAddressClose"];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDeleteIconGesture:)];
        [_deleteIcon addGestureRecognizer:tapGesture];
    }
    return _deleteIcon;
}


- (UIView *)addressInfoView {
    if (!_addressInfoView) {
        _addressInfoView = [UIView new];
        _addressInfoView.frame = CGRectMake(0, CGRectGetMaxY(_topView.frame), kAddressPickerWidth, 0);
    }
    return _addressInfoView;
}


- (UILabel *)addressTip {
    if (!_addressTip) {
        _addressTip = [UILabel new];
        _addressTip.frame = CGRectMake(kMargin, 0, kTipLabW, kAddressInfoViewH);
        _addressTip.frame = CGRectMake(0, 0, kAddressPickerWidth / 4, 52);
        _addressTip.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        _addressTip.text = @"请选择";
        _addressTip.textColor = [UIColor colorWithHexString:@"#E64C3D"];
    }
    return _addressTip;
}


- (UILabel *)provinceLab {
    if (!_provinceLab) {
        _provinceLab = [UILabel new];
        _provinceLab.frame = CGRectMake(kMargin, 0, kTipLabW, kAddressInfoViewH);
        _provinceLab.text = @"广东省";
        _provinceLab.numberOfLines = 2;
        _provinceLab.tag = 1;
        _provinceLab.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        _provinceLab.textColor = [UIColor colorWithHexString:@"#333333"];
        _provinceLab.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLabGesture:)];
        [_provinceLab addGestureRecognizer:tapGesture];
    }
    return _provinceLab;
}

- (UILabel *)cityLab {
    if (!_cityLab) {
        _cityLab = [UILabel new];
        _cityLab.frame = CGRectMake(kTipLabW * 1 + kMargin, 0, kTipLabW, kAddressInfoViewH);
        _cityLab.text = @"广东省";
        _cityLab.numberOfLines = 2;
        _cityLab.tag = 2;
        _cityLab.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        _cityLab.textColor = [UIColor colorWithHexString:@"#333333"];
        _cityLab.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLabGesture:)];
        [_cityLab addGestureRecognizer:tapGesture];
    }
    return _cityLab;
}


- (UILabel *)areaLab {
    if (!_areaLab) {
        _areaLab = [UILabel new];
        _areaLab.frame = CGRectMake(kTipLabW * 2 + kMargin, 0, kTipLabW, kAddressInfoViewH);
        _areaLab.text = @"广东省";
        _areaLab.numberOfLines = 2;
        _areaLab.tag = 3;
        _areaLab.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        _areaLab.textColor = [UIColor colorWithHexString:@"#333333"];
        _areaLab.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLabGesture:)];
        [_areaLab addGestureRecognizer:tapGesture];
    }
    return _areaLab;
}


- (UILabel *)townLab {
    if (!_townLab) {
        _townLab = [UILabel new];
        _townLab.frame = CGRectMake(kTipLabW * 3 + kMargin, 0, kTipLabW, kAddressInfoViewH);
        _townLab.text = @"广东省";
        _townLab.numberOfLines = 2;
        _townLab.tag = 4;
        _townLab.font = [UIFont systemFontOfSize:14 weight:UIFontWeightMedium];
        _townLab.textColor = [UIColor colorWithHexString:@"#333333"];
        _townLab.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapLabGesture:)];
        [_townLab addGestureRecognizer:tapGesture];
    }
    return _townLab;
}


- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [UIView new];
        _bottomLine.frame = CGRectMake(0, CGRectGetMaxY(_addressInfoView.frame), kAddressPickerWidth, 0.33);
        _bottomLine.backgroundColor = [UIColor colorWithHexString:@"#E6E6E6"];
    }
    return _bottomLine;
}


- (NSMutableArray *)itemArrs {
    if (!_itemArrs) {
        _itemArrs = [NSMutableArray array];
    }
    return _itemArrs;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 108, kTCLScreenW, kAddressPickerHeight - 108) style:UITableViewStyleGrouped];
        _tableView.frame = CGRectMake(0, CGRectGetMaxY(_bottomLine.frame), kTCLScreenW, kAddressPickerHeight - CGRectGetMaxY(_bottomLine.frame) - 117);
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
        _tableView.userInteractionEnabled = YES;
    }
    return _tableView;
}


- (UIActivityIndicatorView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicatorView.frame = CGRectMake(_containerView.frame.size.width / 2 - 50, _containerView.frame.size.height / 2 - 50, 100, 100);
        _indicatorView.hidden = YES;
    }
    return _indicatorView;
}


- (AddressPickerIndexView *)indexView {
    if (!_indexView) {
        _indexView = [AddressPickerIndexView new];
        _indexView.frame = CGRectMake(_containerView.right - 40, 104 + 40, 40, _containerView.height - 80 - 104);
        _indexView.delegate = self;
        __weak typeof(self) weakSelf = self;
        _indexView.indexBlock = ^(NSInteger index) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:index];
            [weakSelf.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
        };
    }
    return _indexView;
}


- (AddressHeaderView *)locationTopView {
    if (!_locationTopView) {
        _locationTopView = [[AddressHeaderView alloc] init];
        [_locationTopView.cancelBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    return _locationTopView;
}


#pragma mark - init
- (instancetype)initWithPickerType:(AddressPickerType)type {
    if (self = [super initWithFrame:CGRectZero]) {
        self.pickType = type;
        [self initUI];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}


#pragma mark - show and dismiss
- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.25 animations:^{
        self->_containerView.frame = CGRectMake(0, 117, kAddressPickerWidth, kAddressPickerHeight - 117);
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.25 animations:^{
        self->_containerView.frame = CGRectMake(0, kAddressPickerHeight, kAddressPickerWidth, kAddressPickerHeight - 117);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}


#pragma mark - initUI
- (void)initUI {
    self.frame = [UIScreen mainScreen].bounds;
    [self addSubview:self.backgroundView];
    [self addSubview:self.containerView];

    if (self.pickType && self.pickType == AddressPickerTypeIot) {
        [self.containerView addSubview:self.locationTopView];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectLocationTap:)];
        [self.locationTopView addGestureRecognizer:tap];
    } else {
        [_containerView addSubview:self.topView];
        [_topView addSubview:self.tipLab];
        [_topView addSubview:self.deleteIcon];
    }

    [_containerView addSubview:self.addressInfoView];
    [_addressInfoView addSubview:self.addressTip];
    [_addressInfoView addSubview:self.provinceLab];
    [_addressInfoView addSubview:self.cityLab];
    [_addressInfoView addSubview:self.areaLab];
    [_addressInfoView addSubview:self.townLab];

    [_containerView addSubview:self.bottomLine];
    [_containerView addSubview:self.tableView];
    [_containerView addSubview:self.indicatorView];
    [_containerView addSubview:self.indexView];

    self.isFetchProvince = YES;
    self.isFetchCity = NO;
    self.isFetchArea = NO;
    self.isFetchTown = NO;

    _provinceLab.hidden = YES;
    _cityLab.hidden = YES;
    _areaLab.hidden = YES;
    _townLab.hidden = YES;


    [self fethchProvince:NO];
    [_tableView registerClass:[AddressPickerCell class] forCellReuseIdentifier:addressPickerCellID];
    [_tableView registerClass:[AddressPickerHotCityHeaderView class] forHeaderFooterViewReuseIdentifier:addressPickerHeaderViewID];
    if ([_tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [_tableView setSeparatorInset:UIEdgeInsetsZero];
    }

    if ([_tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [_tableView setLayoutMargins:UIEdgeInsetsZero];
    }
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}


- (void)layoutSubviews {
    [super layoutSubviews];

    //    _backgroundView.frame = CGRectMake(0, 0, kAddressPickerWidth, kAddressPickerHeight);

    if (self.pickType && self.pickType == AddressPickerTypeIot) {
        CGFloat locationTopViewH = 76;
        self.addressInfoView.frame = CGRectMake(0, locationTopViewH, kAddressPickerWidth, 0);

        CGFloat labW = (kAddressPickerWidth - 32) / 4;
        self.addressTip.frame = CGRectMake(16, 0, labW, 48);
        self.provinceLab.frame = CGRectMake(16, 0, labW, 48);
        self.cityLab.frame = CGRectMake(labW * 1 + 16, 0, labW, 48);
        self.areaLab.frame = CGRectMake(labW * 2 + 16, 0, labW, 48);
        self.townLab.frame = CGRectMake(labW * 3 + 16, 0, labW, 48);

        self.bottomLine.frame = CGRectMake(0, CGRectGetMaxY(_addressInfoView.frame), kAddressPickerWidth, 0.33);
        _tableView.frame = CGRectMake(0, CGRectGetMaxY(_bottomLine.frame), kTCLScreenW, kAddressPickerHeight - CGRectGetMaxY(_bottomLine.frame) - 117);
        self.indicatorView.frame = CGRectMake(self.containerView.frame.size.width / 2 - 50, self.containerView.frame.size.height / 2 - 50, 100, 100);
        self.indexView.frame =
            CGRectMake(self.containerView.right - 40, locationTopViewH + 48 + 40, 40, self.containerView.height - 80 - (locationTopViewH + 48));
    } else {
        //        _topView.frame = CGRectMake(0, 0, kAddressPickerWidth, kTopViewH);
        //        _tipLab.frame = CGRectMake(kMargin, 0, kAddressPickerWidth - 60, kTopViewH);
        //        _deleteIcon.frame = CGRectMake(kAddressPickerWidth - 40, 16, 24, 24);

        //        _addressInfoView.frame = CGRectMake(0, CGRectGetMaxY(_topView.frame), kAddressPickerWidth, 0);
        //        CGFloat labW = (kAddressPickerWidth - kMargin * 2) / 4;
        //        _addressTip.frame = CGRectMake(kMargin, 0, kTipLabW, kAddressInfoViewH);
        //        _provinceLab.frame = CGRectMake(kMargin, 0, kTipLabW, kAddressInfoViewH);
        //        _cityLab.frame = CGRectMake(kTipLabW * 1 + kMargin, 0, kTipLabW, kAddressInfoViewH);
        //        _areaLab.frame = CGRectMake(kTipLabW * 2 + kMargin, 0, kTipLabW, kAddressInfoViewH);
        //        _townLab.frame = CGRectMake(kTipLabW * 3 + kMargin, 0, kTipLabW, kAddressInfoViewH);

        //        _bottomLine.frame = CGRectMake(0, CGRectGetMaxY(_addressInfoView.frame), kAddressPickerWidth, 0.33);
        //        _tableView.frame = CGRectMake(0, CGRectGetMaxY(_bottomLine.frame), kTCLScreenW, kAddressPickerHeight - CGRectGetMaxY(_bottomLine.frame) -
        //        117); _indicatorView.frame = CGRectMake(_containerView.frame.size.width / 2 - 50, _containerView.frame.size.height / 2 - 50, 100, 100);
        //        _indexView.frame = CGRectMake(_containerView.right - 40, 104 + 40, 40, _containerView.height - 80 - 104);
    }

    [_containerView setBorderWithCornerRadius:12 borderWidth:0 borderColor:_containerView.backgroundColor type:UIRectCornerTopLeft | UIRectCornerTopRight];
}


/// 更新UI
- (void)updateUI {
    if (self.pickType && self.pickType == AddressPickerTypeIot) {
        _addressInfoView.frame = CGRectMake(0, CGRectGetMaxY(_locationTopView.frame), kAddressPickerWidth, kTopViewH);
        _bottomLine.frame = CGRectMake(0, CGRectGetMaxY(_addressInfoView.frame), kAddressPickerWidth, 0.33);
        _tableView.frame = CGRectMake(0, CGRectGetMaxY(_bottomLine.frame), kTCLScreenW, kAddressPickerHeight - CGRectGetMaxY(_bottomLine.frame) - 117);
    } else {
        //        _addressInfoView.frame = CGRectMake(0, CGRectGetMaxY(_topView.frame), kAddressPickerWidth, kTopViewH);
        //        _bottomLine.frame = CGRectMake(0, CGRectGetMaxY(_addressInfoView.frame), kAddressPickerWidth, 0.33);
        //        _tableView.frame = CGRectMake(0, CGRectGetMaxY(_bottomLine.frame), kTCLScreenW, kAddressPickerHeight - CGRectGetMaxY(_bottomLine.frame) -
        //        117);

        _addressInfoView.height = kTopViewH;
        _bottomLine.top = _addressInfoView.bottom;
        _tableView.frame = CGRectMake(0, CGRectGetMaxY(_bottomLine.frame), kTCLScreenW, kAddressPickerHeight - CGRectGetMaxY(_bottomLine.frame) - 117);
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.pickType && self.pickType == AddressPickerTypeIot) {
        if (self.isFetchProvince) {
            return self.provinceDict.allKeys.count;
        } else if (self.isFetchCity) {
            return self.cityDict.allKeys.count;
        } else if (self.isFetchArea) {
            return self.areaDict.allKeys.count;
        }
    } else {
        if (self.isFetchProvince) {
            return _provinceDict.allKeys.count;
        } else if (self.isFetchCity) {
            return _cityDict.allKeys.count;
        } else if (self.isFetchArea) {
            return _areaDict.allKeys.count;
        } else if (self.isFetchTown) {
            return _townDict.allKeys.count;
        }
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.pickType && self.pickType == AddressPickerTypeIot) {
        if (self.isFetchProvince) {
            NSArray *allKeyArrs = [self sortDictKeys:self.provinceDict];
            return [self.provinceDict[allKeyArrs[section]] count];
        } else if (self.isFetchCity) {
            NSArray *allKeyArrs = [self sortDictKeys:self.cityDict];
            return [self.cityDict[allKeyArrs[section]] count];
        } else if (self.isFetchArea) {
            NSArray *allKeyArrs = [self sortDictKeys:self.areaDict];
            return [self.areaDict[allKeyArrs[section]] count];
        }
    } else {
        if (self.isFetchProvince) {
            NSArray *allKeyArrs = [self sortDictKeys:_provinceDict];
            return [_provinceDict[allKeyArrs[section]] count];
        } else if (self.isFetchCity) {
            NSArray *allKeyArrs = [self sortDictKeys:_cityDict];
            return [_cityDict[allKeyArrs[section]] count];
        } else if (self.isFetchArea) {
            NSArray *allKeyArrs = [self sortDictKeys:_areaDict];
            return [_areaDict[allKeyArrs[section]] count];
        } else if (self.isFetchTown) {
            NSArray *allKeyArrs = [self sortDictKeys:_townDict];
            return [_townDict[allKeyArrs[section]] count];
        }
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddressPickerCell *addressPickerCell = [tableView dequeueReusableCellWithIdentifier:addressPickerCellID forIndexPath:indexPath];
    if (_isFetchProvince) {
        NSArray *allKeyArrs = [self sortDictKeys:_provinceDict];
        NSArray *allValue = _provinceDict[allKeyArrs[indexPath.section]];
        AddressPickerProvinceItemModel *provinceItemModel = allValue[indexPath.row];
        addressPickerCell.nameText = provinceItemModel.provinceName;
        addressPickerCell.indexText = allKeyArrs[indexPath.section];
        addressPickerCell.selectedLetter = provinceItemModel.selectedLetter;
        if (indexPath.row == 0) {
            addressPickerCell.hiddenIndexLab = NO;
        } else {
            addressPickerCell.hiddenIndexLab = YES;
        }

        if (indexPath.row == (allValue.count - 1)) {
            addressPickerCell.hiddenBottomLine = NO;
        } else {
            addressPickerCell.hiddenBottomLine = YES;
        }
    } else if (_isFetchCity) {
        NSArray *allKeyArrs = [self sortDictKeys:_cityDict];
        NSArray *allValue = _cityDict[allKeyArrs[indexPath.section]];
        AddressPickerCityItemModel *cityItemModel = allValue[indexPath.row];
        addressPickerCell.nameText = cityItemModel.cityName;
        addressPickerCell.indexText = allKeyArrs[indexPath.section];
        addressPickerCell.selectedLetter = cityItemModel.selectedLetter;

        if (indexPath.row == 0) {
            addressPickerCell.hiddenIndexLab = NO;
        } else {
            addressPickerCell.hiddenIndexLab = YES;
        }

        if (indexPath.row == (allValue.count - 1)) {
            addressPickerCell.hiddenBottomLine = NO;
        } else {
            addressPickerCell.hiddenBottomLine = YES;
        }
    } else if (_isFetchArea) {
        NSArray *allKeyArrs = [self sortDictKeys:_areaDict];
        NSArray *allValue = _areaDict[allKeyArrs[indexPath.section]];
        AddressPickerAreaItemModel *areaItemModel = allValue[indexPath.row];
        addressPickerCell.nameText = areaItemModel.regionName;
        addressPickerCell.indexText = allKeyArrs[indexPath.section];
        addressPickerCell.selectedLetter = areaItemModel.selectedLetter;
        if (indexPath.row == 0) {
            addressPickerCell.hiddenIndexLab = NO;
        } else {
            addressPickerCell.hiddenIndexLab = YES;
        }

        if (indexPath.row == (allValue.count - 1)) {
            addressPickerCell.hiddenBottomLine = NO;
        } else {
            addressPickerCell.hiddenBottomLine = YES;
        }
    } else if (_isFetchTown) {
        NSArray *allKeyArrs = [self sortDictKeys:_townDict];
        NSArray *allValue = _townDict[allKeyArrs[indexPath.section]];
        AddressPickerTownItemModel *townItemModel = allValue[indexPath.row];
        addressPickerCell.nameText = townItemModel.streetName;
        addressPickerCell.indexText = allKeyArrs[indexPath.section];
        addressPickerCell.selectedLetter = townItemModel.selectedLetter;
        if (indexPath.row == 0) {
            addressPickerCell.hiddenIndexLab = NO;
        } else {
            addressPickerCell.hiddenIndexLab = YES;
        }

        if (indexPath.row == (allValue.count - 1)) {
            addressPickerCell.hiddenBottomLine = NO;
        } else {
            addressPickerCell.hiddenBottomLine = YES;
        }
    }

    return addressPickerCell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [_indexView dismissIndicator];
    if (_isFetchProvince) {
        if ([_provinceDict allKeys].count == 0) return;
        NSArray *allKeyArrs = [self sortDictKeys:_provinceDict];
        if (allKeyArrs.count == 0) return;
        NSArray *allValue = _provinceDict[allKeyArrs[indexPath.section]];
        if (allValue.count == 0) return;
        [self updateUI];
        AddressPickerProvinceItemModel *provinceItemModel = allValue[indexPath.row];
        self.selectedProvinceItemModel = provinceItemModel;
        [self fetchCityWithProvinceUUID:provinceItemModel.uuid didFresh:YES];
    } else if (_isFetchCity) {
        if ([_cityDict allKeys].count == 0) return;
        NSArray *allKeyArrs = [self sortDictKeys:_cityDict];
        if (allKeyArrs.count == 0) return;
        NSArray *allValue = _cityDict[allKeyArrs[indexPath.section]];
        if (allValue.count == 0) return;
        AddressPickerCityItemModel *cityItemModel = allValue[indexPath.row];
        self.selectedCityItemModel = cityItemModel;
        [self fetchAreaWithCityUUID:cityItemModel.uuid didFresh:YES];
    } else if (_isFetchArea) {
        if (self.pickType && self.pickType == AddressPickerTypeIot) {
            NSArray *allKeyArrs = [self sortDictKeys:self.areaDict];
            if (allKeyArrs.count == 0) return;
            NSArray *allValue = self.areaDict[allKeyArrs[indexPath.section]];
            if (allValue.count == 0) return;
            AddressPickerAreaItemModel *areaItemModel = allValue[indexPath.row];
            self.selectedAreaItemModel = areaItemModel;

            self.areaLab.text = areaItemModel.regionName;
            self.provinceLab.hidden = NO;
            self.cityLab.hidden = NO;
            self.areaLab.hidden = NO;
            self.addressTip.hidden = YES;
            if (self.addressPickerBlock) {
                NSMutableDictionary *info = [NSMutableDictionary dictionary];
                info[@"ProvinceUUID"] = self.selectedProvinceItemModel.uuid;
                info[@"CityUUID"] = self.selectedCityItemModel.uuid;
                info[@"AreaUUID"] = self.selectedAreaItemModel.uuid;
                info[@"TownUUID"] = self.selectedTownIteModel.uuid;
                info[@"AreaInfo"] = [NSString stringWithFormat:@"%@%@%@%@", self.selectedProvinceItemModel.provinceName, self.selectedCityItemModel.cityName,
                                                               self.selectedAreaItemModel.regionName, self.selectedTownIteModel.streetName];
                info[@"addressText"] = [NSString stringWithFormat:@"%@ %@ %@", self.selectedProvinceItemModel.provinceName, self.selectedCityItemModel.cityName,
                                                                  self.selectedAreaItemModel.regionName];
                self.addressPickerBlock(info);
                [self dismiss];
            }
        } else {
            if ([_areaDict allKeys].count == 0) return;
            NSArray *allKeyArrs = [self sortDictKeys:_areaDict];
            if (allKeyArrs.count == 0) return;
            NSArray *allValue = _areaDict[allKeyArrs[indexPath.section]];
            if (allValue.count == 0) return;
            AddressPickerAreaItemModel *areaItemModel = allValue[indexPath.row];
            self.selectedAreaItemModel = areaItemModel;
            [self fetchTownWithAreaUUID:areaItemModel.uuid didFresh:YES];
        }
    } else if (_isFetchTown) {
        if ([_townDict allKeys].count == 0) return;
        NSArray *allKeyArrs = [self sortDictKeys:_townDict];
        if (allKeyArrs.count == 0) return;
        NSArray *allValue = _townDict[allKeyArrs[indexPath.section]];
        if (allValue.count == 0) return;
        AddressPickerTownItemModel *townItemModel = allValue[indexPath.row];
        self.selectedTownIteModel = townItemModel;
        _townLab.text = townItemModel.streetName;
        _provinceLab.hidden = NO;
        _cityLab.hidden = NO;
        _areaLab.hidden = NO;
        _townLab.hidden = NO;
        _addressTip.hidden = YES;
        if (self.addressPickerBlock) {
            NSMutableDictionary *info = [NSMutableDictionary dictionary];
            info[@"ProvinceUUID"] = _selectedProvinceItemModel.uuid;
            info[@"CityUUID"] = _selectedCityItemModel.uuid;
            info[@"AreaUUID"] = _selectedAreaItemModel.uuid;
            info[@"TownUUID"] = _selectedTownIteModel.uuid;
            info[@"AreaInfo"] = [NSString stringWithFormat:@"%@%@%@%@", _selectedProvinceItemModel.provinceName, _selectedCityItemModel.cityName,
                                                           _selectedAreaItemModel.regionName, _selectedTownIteModel.streetName];
            self.addressPickerBlock(info);
            [self dismiss];
        }
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    WS(weakSelf);
    if (section == 0 && _isFetchProvince) {
        AddressPickerHotCityHeaderView *hotCityHeaderView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:addressPickerHeaderViewID];
        hotCityHeaderView.hotCityBlock = ^(AddressPickerHotCityItemModel *_Nonnull model) {
            [weakSelf.indexView dismissIndicator];
            [weakSelf updateUI];
            weakSelf.provinceLab.hidden = NO;
            weakSelf.cityLab.hidden = NO;
            weakSelf.provinceLab.text = model.provinceName;
            weakSelf.cityLab.text = model.cityName;

            // 计算文字宽度
            if (weakSelf.provinceLab.text.length == 0) {
                weakSelf.provinceLab.text = @"";
            }
            NSAttributedString *provinceAttr = [[NSAttributedString alloc] initWithString:weakSelf.provinceLab.text
                                                                               attributes:@{NSFontAttributeName: weakSelf.provinceLab.font}];
            CGFloat provinceW = [NSString caculatorTextSize:provinceAttr maxWdith:kTipLabMaxW].width;
            weakSelf.provinceLab.frame = CGRectMake(16, 0, provinceW, 48);

            if (weakSelf.cityLab.text.length == 0) {
                weakSelf.cityLab.text = @"";
            }
            NSAttributedString *cityAttr = [[NSAttributedString alloc] initWithString:weakSelf.cityLab.text
                                                                           attributes:@{NSFontAttributeName: weakSelf.cityLab.font}];
            CGFloat cityW = [NSString caculatorTextSize:cityAttr maxWdith:kTipLabMaxW].width;
            weakSelf.cityLab.frame = CGRectMake(weakSelf.provinceLab.right + kTipMarginW, 0, cityW, 48);

            NSAttributedString *areaAttr = [[NSAttributedString alloc] initWithString:@"选择区/县" attributes:@{NSFontAttributeName: weakSelf.cityLab.font}];
            CGFloat areaW = [NSString caculatorTextSize:areaAttr maxWdith:kTipLabMaxW].width;
            weakSelf.areaLab.frame = CGRectMake(weakSelf.cityLab.right + kTipMarginW, 0, areaW, 48);

            weakSelf.addressTip.frame = CGRectMake(weakSelf.cityLab.right + kTipMarginW, 0, areaW, 48);
            weakSelf.addressTip.text = @"选择区/县";

            AddressPickerProvinceItemModel *provinceModel = [AddressPickerProvinceItemModel new];
            provinceModel.uuid = model.provinceUuid;
            provinceModel.provinceName = model.provinceName;
            weakSelf.selectedProvinceItemModel = provinceModel;

            AddressPickerCityItemModel *cityModel = [AddressPickerCityItemModel new];
            cityModel.uuid = model.uuid;
            cityModel.cityName = model.cityName;
            weakSelf.selectedCityItemModel = cityModel;

            [weakSelf resetAllStatus];
            weakSelf.isFetchCity = YES;
            [weakSelf fetchAreaWithCityUUID:weakSelf.selectedCityItemModel.uuid didFresh:YES];
        };
        return hotCityHeaderView;
    }
    return [UIView new];
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0 && _isFetchProvince) {
        return 150;
    }
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return CGFLOAT_MIN;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }

    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)resetAllStatus {
    _isFetchCity = NO;
    _isFetchProvince = NO;
    _isFetchArea = NO;
    _isFetchTown = NO;

    _provinceLab.textColor = [UIColor colorWithHexString:@"#333333"];
    _cityLab.textColor = [UIColor colorWithHexString:@"#333333"];
    _areaLab.textColor = [UIColor colorWithHexString:@"#333333"];
    _townLab.textColor = [UIColor colorWithHexString:@"#333333"];
}

#pragma mark - Gesture
- (void)tapDeleteIconGesture:(UITapGestureRecognizer *)gesture {
    [self dismiss];
}

- (void)tapped:(UITapGestureRecognizer *)tapGR {
    [self dismiss];
}

- (void)tapLabGesture:(UITapGestureRecognizer *)gesture {
    [_indexView dismissIndicator];
    UILabel *lab = (UILabel *)gesture.view;
    _addressTip.hidden = YES;
    if (lab.tag == 1) {
        [self resetAllStatus];
        _isFetchProvince = YES;
        [self fethchProvince:NO];
    } else if (lab.tag == 2) {
        [self resetAllStatus];
        _isFetchCity = YES;
        [self fetchCityWithProvinceUUID:_selectedProvinceItemModel.uuid didFresh:NO];
    } else if (lab.tag == 3) {
        [self resetAllStatus];
        _isFetchArea = YES;
        [self fetchAreaWithCityUUID:_selectedCityItemModel.uuid didFresh:NO];
    } else if (lab.tag == 4) {
        [self resetAllStatus];
        _townLab.hidden = YES;
        [self fetchTownWithAreaUUID:_selectedAreaItemModel.uuid didFresh:NO];
    }
}

//手动定位
- (void)selectLocationTap:(UITapGestureRecognizer *)tap {
    if (self.locationTopView.locationError) {
        //定位错误情况下不可点击
    } else {
        NSString *addressText = [self.locationTopView.locDic valueForKey:@"addressText"];
        if (addressText == nil) addressText = @"";
        if (self.addressPickerBlock) {
            NSMutableDictionary *info = [NSMutableDictionary dictionary];
            info[@"ProvinceUUID"] = @"";
            info[@"CityUUID"] = @"";
            info[@"AreaUUID"] = @"";
            info[@"TownUUID"] = @"";
            info[@"AreaInfo"] = addressText;
            info[@"addressText"] = addressText;
            self.addressPickerBlock(info);
            [self dismiss];
        }
    }
}

#pragma mark - Request

/// 获取省份数据
- (void)fethchProvince:(BOOL)fresh {
    WS(weakSelf);
    _indicatorView.hidden = NO;
    [_indicatorView startAnimating];
    AddressPickerProvinceModel *provinceModel = [AddressPickerProvinceModel new];
    [provinceModel fetchProvinceWithSuccess:^(BOOL isSuc, AddressPickerProvinceModel *_Nonnull response) {
        if (isSuc) {
            weakSelf.provinceDict = response.sortDict;
            NSInteger indexItemCount = [[weakSelf.provinceDict allKeys] count];
            weakSelf.indexView.hidden = NO;
            weakSelf.indexView.height = kItemH * indexItemCount;
            weakSelf.indexView.centerY = weakSelf.tableView.centerY;
            NSArray *dataSource = [weakSelf sortDictKeys:weakSelf.provinceDict];
            weakSelf.indexView.dataSource = dataSource;
            if (fresh) {
                weakSelf.addressTip.hidden = NO;
            } else {
                weakSelf.addressTip.hidden = YES;
                weakSelf.provinceLab.textColor = defaultRedColor;
            }
            [weakSelf.tableView hideDefaultPageView];
            weakSelf.indicatorView.hidden = YES;
            [weakSelf.indicatorView stopAnimating];
            [weakSelf.tableView reloadData];
        } else {
            weakSelf.indicatorView.hidden = YES;
            [weakSelf.indicatorView stopAnimating];
            weakSelf.indexView.hidden = YES;
            [Popover popToastOnWindowWithText:response.errMsg];
            [weakSelf.tableView showDefaultPageViewWithImage:[UIImage imageNamed:@"ErrorNetwork"] tips:@"网络异常，请刷新" buttonText:@"刷新"];
            [weakSelf.tableView configReloadAction:^{
                [weakSelf fethchProvince:fresh];
            }];
        }
    } failure:^(AddressPickerProvinceModel *_Nonnull response) {
        weakSelf.indicatorView.hidden = YES;
        [weakSelf.indicatorView stopAnimating];
        weakSelf.indexView.hidden = YES;
        [Popover popToastOnWindowWithText:response.errMsg];
        [weakSelf.tableView showDefaultPageViewWithImage:[UIImage imageNamed:@"ErrorNetwork"] tips:@"网络异常，请刷新" buttonText:@"刷新"];
        [weakSelf.tableView configReloadAction:^{
            [weakSelf fethchProvince:fresh];
        }];
    }];
}


/// 获取市区数据
- (void)fetchCityWithProvinceUUID:(NSString *)uuid didFresh:(BOOL)fresh {
    if (uuid == nil) return;
    WS(weakSelf);
    _indicatorView.hidden = NO;
    [_indicatorView startAnimating];
    AddressPickerCityModel *cityModel = [AddressPickerCityModel new];
    [cityModel fetchCityWithProvinceUUID:uuid success:^(BOOL isSuc, AddressPickerCityModel *_Nonnull response) {
        if (isSuc) {
            weakSelf.cityDict = response.sortDict;
            NSInteger indexItemCount = [[weakSelf.cityDict allKeys] count];
            weakSelf.indexView.hidden = NO;
            weakSelf.indexView.height = kItemH * indexItemCount;
            weakSelf.indexView.centerY = weakSelf.tableView.centerY;
            NSArray *dataSource = [weakSelf sortDictKeys:weakSelf.cityDict];
            weakSelf.indexView.dataSource = dataSource;
            if (fresh) {
                weakSelf.provinceLab.text = (weakSelf.selectedProvinceItemModel.provinceName != nil) ? weakSelf.selectedProvinceItemModel.provinceName : @"";
                // 计算文字宽度
                NSAttributedString *provinceAttr = [[NSAttributedString alloc] initWithString:weakSelf.provinceLab.text
                                                                                   attributes:@{NSFontAttributeName: weakSelf.provinceLab.font}];
                CGFloat provinceW = [NSString caculatorTextSize:provinceAttr maxWdith:kTipLabMaxW].width;
                weakSelf.provinceLab.frame = CGRectMake(16, 0, provinceW, 48);

                NSAttributedString *cityAttr = [[NSAttributedString alloc] initWithString:@"选择市区"
                                                                               attributes:@{NSFontAttributeName: weakSelf.provinceLab.font}];
                CGFloat cityW = [NSString caculatorTextSize:cityAttr maxWdith:kTipLabMaxW].width;
                weakSelf.cityLab.frame = CGRectMake(weakSelf.provinceLab.right + kTipMarginW, 0, cityW, 48);

                [weakSelf resetAllStatus];
                weakSelf.addressTip.hidden = NO;
                [UIView animateWithDuration:0.25 animations:^{
                    weakSelf.addressTip.frame = CGRectMake(weakSelf.provinceLab.right + kTipMarginW, 0, cityW, 48);
                    weakSelf.addressTip.text = @"选择市区";
                }];
                weakSelf.isFetchCity = YES;
                weakSelf.provinceLab.hidden = NO;
                weakSelf.cityLab.hidden = YES;
                weakSelf.areaLab.hidden = YES;
                weakSelf.townLab.hidden = YES;
            } else {
                [weakSelf resetAllStatus];
                weakSelf.cityLab.textColor = defaultRedColor;
                weakSelf.addressTip.hidden = YES;
                weakSelf.isFetchCity = YES;
            }
            [weakSelf.tableView hideDefaultPageView];
            weakSelf.indicatorView.hidden = YES;
            [weakSelf.indicatorView stopAnimating];
            [weakSelf.tableView reloadData];

        } else {
            weakSelf.indicatorView.hidden = YES;
            [weakSelf.indicatorView stopAnimating];
            weakSelf.indexView.hidden = YES;
            [weakSelf.tableView showDefaultPageViewWithImage:[UIImage imageNamed:@"ErrorNetwork"] tips:@"网络异常，请刷新" buttonText:@"刷新"];
            [weakSelf.tableView configReloadAction:^{
                [weakSelf fetchCityWithProvinceUUID:uuid didFresh:fresh];
            }];
        }
    } failure:^(AddressPickerCityModel *_Nonnull response) {
        weakSelf.indicatorView.hidden = YES;
        [weakSelf.indicatorView stopAnimating];
        weakSelf.indexView.hidden = YES;
        [weakSelf.tableView showDefaultPageViewWithImage:[UIImage imageNamed:@"ErrorNetwork"] tips:@"网络异常，请刷新" buttonText:@"刷新"];
        [weakSelf.tableView configReloadAction:^{
            [weakSelf fetchCityWithProvinceUUID:uuid didFresh:fresh];
        }];
    }];
}


/// 获取区域数据
- (void)fetchAreaWithCityUUID:(NSString *)uuid didFresh:(BOOL)fresh {
    if (uuid == nil) return;
    WS(weakSelf);
    _indicatorView.hidden = NO;
    [_indicatorView startAnimating];
    AddressPickerAreaModel *areaModel = [AddressPickerAreaModel new];
    [areaModel fetchAreaWithCityUUID:uuid success:^(BOOL isSuc, AddressPickerAreaModel *_Nonnull response) {
        if (isSuc) {
            if (fresh) {
                weakSelf.cityLab.text = (weakSelf.selectedCityItemModel.cityName != nil) ? weakSelf.selectedCityItemModel.cityName : @"";
                // 计算文字宽度
                NSAttributedString *cityAttr = [[NSAttributedString alloc] initWithString:weakSelf.cityLab.text
                                                                               attributes:@{NSFontAttributeName: weakSelf.cityLab.font}];
                CGFloat cityW = [NSString caculatorTextSize:cityAttr maxWdith:kTipLabMaxW].width;
                weakSelf.cityLab.frame = CGRectMake(weakSelf.provinceLab.right + kTipMarginW, 0, cityW, 48);

                NSAttributedString *areaAttr = [[NSAttributedString alloc] initWithString:@"选择区/县"
                                                                               attributes:@{NSFontAttributeName: weakSelf.cityLab.font}];
                CGFloat areaW = [NSString caculatorTextSize:areaAttr maxWdith:kTipLabMaxW].width;
                weakSelf.areaLab.frame = CGRectMake(weakSelf.cityLab.right + kTipMarginW, 0, areaW, 48);

                [weakSelf resetAllStatus];
                weakSelf.addressTip.hidden = NO;
                [UIView animateWithDuration:0.25 animations:^{
                    weakSelf.addressTip.frame = CGRectMake(weakSelf.cityLab.right + kTipMarginW, 0, areaW, 48);
                    weakSelf.addressTip.text = @"选择区/县";
                }];
                weakSelf.isFetchArea = YES;
                weakSelf.provinceLab.hidden = NO;
                weakSelf.cityLab.hidden = NO;
                weakSelf.areaLab.hidden = YES;
                weakSelf.townLab.hidden = YES;
            } else {
                [weakSelf resetAllStatus];
                weakSelf.areaLab.textColor = defaultRedColor;
                weakSelf.addressTip.hidden = YES;
                weakSelf.isFetchArea = YES;
            }

            weakSelf.areaDict = response.sortDict;
            NSArray *dataSource = [weakSelf sortDictKeys:weakSelf.areaDict];
            NSInteger indexItemCount = [[weakSelf.areaDict allKeys] count];
            weakSelf.indexView.hidden = NO;
            weakSelf.indexView.height = kItemH * indexItemCount;
            weakSelf.indexView.centerY = weakSelf.tableView.centerY;
            weakSelf.indexView.dataSource = dataSource;
            [weakSelf.tableView hideDefaultPageView];
            weakSelf.indicatorView.hidden = YES;
            [weakSelf.indicatorView stopAnimating];
            [weakSelf.tableView reloadData];

        } else {
            weakSelf.indicatorView.hidden = YES;
            [weakSelf.indicatorView stopAnimating];
            weakSelf.indexView.hidden = YES;
            [weakSelf.tableView showDefaultPageViewWithImage:[UIImage imageNamed:@"ErrorNetwork"] tips:@"网络异常，请刷新" buttonText:@"刷新"];
            [weakSelf.tableView configReloadAction:^{
                [weakSelf fetchAreaWithCityUUID:uuid didFresh:fresh];
            }];
        }
    } failure:^(AddressPickerAreaModel *_Nonnull response) {
        weakSelf.indicatorView.hidden = YES;
        [weakSelf.indicatorView stopAnimating];
        weakSelf.indexView.hidden = YES;
        [weakSelf.tableView showDefaultPageViewWithImage:[UIImage imageNamed:@"ErrorNetwork"] tips:@"网络异常，请刷新" buttonText:@"刷新"];
        [weakSelf.tableView configReloadAction:^{
            [weakSelf fetchAreaWithCityUUID:uuid didFresh:fresh];
        }];
    }];
}


/// 获取街道数据
- (void)fetchTownWithAreaUUID:(NSString *)uuid didFresh:(BOOL)fresh {
    if (uuid == nil) return;
    WS(weakSelf);
    _indicatorView.hidden = NO;
    [_indicatorView startAnimating];
    AddressPickerTownModel *townModel = [AddressPickerTownModel new];
    [townModel fetchTownWithRegionUUID:uuid success:^(BOOL isSuc, AddressPickerTownModel *_Nonnull response) {
        if (isSuc) {
            if (fresh) {
                weakSelf.areaLab.text = (weakSelf.selectedAreaItemModel.regionName != nil) ? weakSelf.selectedAreaItemModel.regionName : @"";
                // 计算文字宽度
                NSAttributedString *areaAttr = [[NSAttributedString alloc] initWithString:weakSelf.areaLab.text
                                                                               attributes:@{NSFontAttributeName: weakSelf.areaLab.font}];
                CGFloat areaW = [NSString caculatorTextSize:areaAttr maxWdith:kTipLabMaxW].width;
                weakSelf.areaLab.frame = CGRectMake(weakSelf.cityLab.right + kTipMarginW, 0, areaW, 48);

                NSAttributedString *townAttr = [[NSAttributedString alloc] initWithString:@"选择街道"
                                                                               attributes:@{NSFontAttributeName: weakSelf.areaLab.font}];
                CGFloat townW = [NSString caculatorTextSize:townAttr maxWdith:kTipLabMaxW].width;
                weakSelf.townLab.frame = CGRectMake(weakSelf.areaLab.right + kTipMarginW, 0, townW, 48);

                [weakSelf resetAllStatus];
                weakSelf.addressTip.hidden = NO;
                [UIView animateWithDuration:0.25 animations:^{
                    weakSelf.addressTip.frame = CGRectMake(weakSelf.areaLab.right + kTipMarginW, 0, townW, 48);
                    weakSelf.addressTip.text = @"选择街道";
                }];
                weakSelf.isFetchTown = YES;
                weakSelf.provinceLab.hidden = NO;
                weakSelf.cityLab.hidden = NO;
                weakSelf.areaLab.hidden = NO;
                weakSelf.townLab.hidden = YES;
            } else {
                [weakSelf resetAllStatus];
                weakSelf.townLab.textColor = defaultRedColor;
                weakSelf.addressTip.hidden = NO;
                weakSelf.isFetchTown = YES;
            }
            self.townDict = response.sortDict;
            NSInteger indexItemCount = [[weakSelf.townDict allKeys] count];
            weakSelf.indexView.hidden = NO;
            weakSelf.indexView.height = kItemH * indexItemCount;
            weakSelf.indexView.centerY = weakSelf.tableView.centerY;
            NSArray *dataSource = [weakSelf sortDictKeys:weakSelf.townDict];
            weakSelf.indexView.dataSource = dataSource;
            [weakSelf.tableView hideDefaultPageView];
            weakSelf.indicatorView.hidden = YES;
            [weakSelf.indicatorView stopAnimating];
            [weakSelf.tableView reloadData];

        } else {
            weakSelf.indicatorView.hidden = YES;
            [weakSelf.indicatorView stopAnimating];
            weakSelf.indexView.hidden = YES;
            [weakSelf.tableView showDefaultPageViewWithImage:[UIImage imageNamed:@"ErrorNetwork"] tips:@"网络异常，请刷新" buttonText:@"刷新"];
            [weakSelf.tableView configReloadAction:^{
                [weakSelf fetchTownWithAreaUUID:uuid didFresh:fresh];
            }];
        }
    } failure:^(AddressPickerTownModel *_Nonnull response) {
        weakSelf.indicatorView.hidden = YES;
        [weakSelf.indicatorView stopAnimating];
        weakSelf.indexView.hidden = YES;
        [weakSelf.tableView showDefaultPageViewWithImage:[UIImage imageNamed:@"ErrorNetwork"] tips:@"网络异常，请刷新" buttonText:@"刷新"];
        [weakSelf.tableView configReloadAction:^{
            [weakSelf fetchTownWithAreaUUID:uuid didFresh:fresh];
        }];
    }];
}


#pragma mark - AddressPickerIndexViewDelegate
- (void)addressPickerIndexView:(AddressPickerIndexView *)indexView didSelectedIndex:(NSInteger)index completion:(void (^)(NSInteger))completion {
    if (index >= 0 && index <= _tableView.numberOfSections) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:index];
        [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
    CGPoint point = CGPointMake(0, _tableView.contentOffset.y);
    NSIndexPath *indexPath = [_tableView indexPathForRowAtPoint:point];
    completion(indexPath.section);
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGPoint point = CGPointMake(0, scrollView.contentOffset.y);
    NSIndexPath *indexPath = [_tableView indexPathForRowAtPoint:point];
    if (scrollView.contentOffset.y <= 0) {
        indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"AddressPickerCellIndexNotification" object:nil];
    [_indexView updateSelectedIndex:indexPath.section];
    AddressPickerCell *pickerCell = [_tableView cellForRowAtIndexPath:indexPath];
    pickerCell.selectedLetter = YES;
}


/// 排序
- (NSArray *)sortDictKeys:(NSDictionary *)allKeys {
    NSMutableArray *allKeyArrs = [[allKeys allKeys] mutableCopy];
    [allKeyArrs sortUsingComparator:^NSComparisonResult(NSString *obj1, NSString *obj2) {
        return [obj1 compare:obj2];
    }];
    return allKeyArrs;
}

@end
