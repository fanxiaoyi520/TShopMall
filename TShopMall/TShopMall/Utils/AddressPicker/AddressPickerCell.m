//
//  AddressPickerCell.m
//  TCLPlus
//
//  Created by kobe on 2020/8/24.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import "AddressPickerCell.h"

#import "Masonry.h"

#import "UIColor+Plugin.h"


@interface AddressPickerCell ()

@property (nonatomic, strong, nullable) UILabel *indexLab;
@property (nonatomic, strong, nullable) UILabel *nameLab;
@property (nonatomic, strong, nullable) UIView *bottomLine;

@end


@implementation AddressPickerCell


- (UILabel *)indexLab {
    if (!_indexLab) {
        _indexLab = [UILabel new];
        _indexLab.textAlignment = NSTextAlignmentCenter;
    }
    return _indexLab;
}

- (UILabel *)nameLab {
    if (!_nameLab) {
        _nameLab = [UILabel new];
        _nameLab.font = [UIFont systemFontOfSize:14];
        _nameLab.textColor = [UIColor colorWithHexString:@"#2D3132"];
        _nameLab.text = @"广东省";
    }
    return _nameLab;
}


- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [UIView new];
    }
    return _bottomLine;
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AddressPickerCellIndexNotification:)
                                                     name:@"AddressPickerCellIndexNotification"
                                                   object:nil];
    }
    return self;
}


- (void)initUI {
    [self.contentView addSubview:self.indexLab];
    [self.contentView addSubview:self.nameLab];
    [self.contentView addSubview:self.bottomLine];
}

- (void)AddressPickerCellIndexNotification:(NSNotification *)notification {
    
}


- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setNameText:(NSString *)nameText {
    _nameLab.text = nameText;
}

- (void)setIndexText:(NSString *)indexText {
    _indexLab.text = indexText;
}

- (void)setHiddenBottomLine:(BOOL)hiddenBottomLine {
    _bottomLine.hidden = hiddenBottomLine;
}

- (void)setHiddenIndexLab:(BOOL)hiddenIndexLab {
    _indexLab.hidden = hiddenIndexLab;
}

- (void)setSelectedLetter:(BOOL)selectedLetter {
    
}

+ (BOOL)requiresConstraintBasedLayout {
    return YES;
}

- (void)updateConstraints {
    [super updateConstraints];

    [_indexLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(16);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(20, 22));
    }];

    [_nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_indexLab.mas_right).with.offset(16);
        make.centerY.equalTo(self.mas_centerY);
        make.height.mas_equalTo(@(22));
    }];

    [_bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(16);
        make.right.equalTo(self.mas_right).with.offset(0);
        make.bottom.equalTo(self.mas_bottom);
        make.height.mas_equalTo(@(0.33));
    }];
}

@end
