//
//  AddressPickerHotCityHeaderView.m
//  TCLPlus
//
//  Created by kobe on 2020/11/9.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import <MJExtension/MJExtension.h>

#import "AddressPickerHotCityHeaderView.h"

#import "AddressPickerHotCityModel.h"

#import "MineConst.h"

#import "UIColor+Plugin.h"


@interface AddressPickerHotCityHeaderView ()

@property (nonatomic, strong, nullable) UILabel *hotCityLab;
@property (nonatomic, strong, nullable) NSMutableArray *hotCityArrs;
@property (nonatomic, strong, nullable) NSMutableArray *hotCityDataSource;

@end


@implementation AddressPickerHotCityHeaderView

- (UILabel *)hotCityLab {
    if (!_hotCityLab) {
        _hotCityLab = [UILabel new];
        _hotCityLab.font = [UIFont systemFontOfSize:13];
        _hotCityLab.textColor = [UIColor colorWithHexString:@"#333333"];
        _hotCityLab.text = @"热门城市";
    }
    return _hotCityLab;
}

- (NSMutableArray *)hotCityArrs {
    if (!_hotCityArrs) {
        _hotCityArrs = [NSMutableArray new];
    }
    return _hotCityArrs;
}

- (NSMutableArray *)hotCityDataSource {
    if (!_hotCityDataSource) {
        _hotCityDataSource = [NSMutableArray array];
    }
    return _hotCityDataSource;
}


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}


- (void)initUI {
    self.contentView.backgroundColor = [UIColor colorWithHexString:@"#FFFFFF"];
    [self.contentView addSubview:self.hotCityLab];
    [self updateHotCityData];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _hotCityLab.frame = CGRectMake(16, 0, kTCLScreenW - 32, 35);
}


- (void)updateHotCityData {
    NSMutableDictionary *needParams = [NSMutableDictionary new];
    needParams[@"fileName"] = @"HotCityAddress";
    HotCityAddressModel *hotCityAddressModel = [HotCityAddressModel new];
    [hotCityAddressModel fetchHotCityAddress:needParams success:^(BOOL isSuc, HotCityAddressModel *_Nonnull response) {
        if (isSuc) {
            AddressPickerHotCityModel *hotCityModel = [AddressPickerHotCityModel new];
            hotCityModel = [hotCityModel fetchHotCityModel];
            if ([hotCityModel.version isEqualToString:response.version]) {
                [self loadNativeHotCityJSON];
            } else {
                hotCityModel.data = response.list;
                hotCityModel.version = response.version;
                [hotCityModel saveHotCityModel:hotCityModel];
                [self loadNativeHotCityJSON];
            }
        } else {
            [self loadNativeHotCityJSON];
        }
    } failure:^(HotCityAddressModel *_Nonnull response) {
        [self loadNativeHotCityJSON];
    }];
}


/// 加载本地 Bundle JSON 文件
- (void)loadNativeHotCityJSON {
    AddressPickerHotCityModel *hotCityModel = [AddressPickerHotCityModel new];
    hotCityModel = [hotCityModel fetchHotCityModel];
    if (hotCityModel.data.count == 0) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"hotCity" ofType:@"json"];
        NSData *hotCityData = [[NSData alloc] initWithContentsOfFile:path];
        NSError *error;
        id jsonObj = [NSJSONSerialization JSONObjectWithData:hotCityData options:NSJSONReadingMutableContainers error:&error];
        if (!jsonObj || error) {
        } else {
            hotCityModel = [AddressPickerHotCityModel mj_objectWithKeyValues:jsonObj];
            [hotCityModel saveHotCityModel:hotCityModel];
        }
    }
    [self layoutItem:hotCityModel];
}


- (void)layoutItem:(AddressPickerHotCityModel *)model {
    [_hotCityDataSource removeAllObjects];
    [self.hotCityDataSource addObjectsFromArray:model.data];
    [_hotCityArrs removeAllObjects];
    CGFloat itemW = kTCLScreenW / 4;
    CGFloat itemH = 35;
    for (NSInteger i = 0; i < _hotCityDataSource.count; i++) {
        NSInteger row = i / 4;
        NSInteger column = i % 4;
        UILabel *lab = [UILabel new];
        lab.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemTapGesture:)];
        [lab addGestureRecognizer:tapGesture];
        lab.frame = CGRectMake(itemW * column, row * itemH + 40, itemW, itemH);
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:13];
        lab.textColor = [UIColor colorWithHexString:@"#333333"];
        AddressPickerHotCityItemModel *itemModel = _hotCityDataSource[i];
        lab.text = itemModel.cityName;
        lab.tag = i;
        [self addSubview:lab];
        [self.hotCityArrs addObject:lab];
    }
}

- (void)fetchHotCityData {
    [_hotCityDataSource removeAllObjects];
    AddressPickerHotCityModel *hotCityModel = [AddressPickerHotCityModel new];
    hotCityModel = [hotCityModel fetchHotCityModel];
    if (hotCityModel.data.count == 0) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"hotCity" ofType:@"json"];
        NSData *hotCityData = [[NSData alloc] initWithContentsOfFile:path];
        NSError *error;
        id jsonObj = [NSJSONSerialization JSONObjectWithData:hotCityData options:NSJSONReadingMutableContainers error:&error];
        if (!jsonObj || error) {
        } else {
            hotCityModel = [AddressPickerHotCityModel mj_objectWithKeyValues:jsonObj];
            [hotCityModel saveHotCityModel:hotCityModel];
        }
    }

    [self.hotCityDataSource addObjectsFromArray:hotCityModel.data];
    [_hotCityArrs removeAllObjects];
    CGFloat itemW = kTCLScreenW / 4;
    CGFloat itemH = 35;
    for (NSInteger i = 0; i < _hotCityDataSource.count; i++) {
        NSInteger row = i / 4;
        NSInteger column = i % 4;
        UILabel *lab = [UILabel new];
        lab.userInteractionEnabled = YES;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemTapGesture:)];
        [lab addGestureRecognizer:tapGesture];
        lab.frame = CGRectMake(itemW * column, row * itemH + 40, itemW, itemH);
        lab.textAlignment = NSTextAlignmentCenter;
        lab.font = [UIFont systemFontOfSize:13];
        lab.textColor = [UIColor colorWithHexString:@"#333333"];
        AddressPickerHotCityItemModel *itemModel = _hotCityDataSource[i];
        lab.text = itemModel.cityName;
        lab.tag = i;
        [self addSubview:lab];
        [self.hotCityArrs addObject:lab];
    }
}


- (void)itemTapGesture:(UIGestureRecognizer *)gesture {
    NSInteger index = gesture.view.tag;
    if (self.hotCityBlock) {
        self.hotCityBlock(_hotCityDataSource[index]);
    }
}


@end
