//
//  TSSelectProvincesCitiesCell.m
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/7/1.
//

#import "TSSelectProvincesCitiesCell.h"
#import "TSProvinceListModel.h"

@interface TSSelectProvincesCitiesCell ()

@property (nonatomic ,strong)UILabel *titleLab;
@property (nonatomic ,strong)UILabel *letterLab;
@property (nonatomic ,strong)NSIndexPath *indexPath;
@end
@implementation TSSelectProvincesCitiesCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withIndexPath:(NSIndexPath *)indexPath {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.indexPath = indexPath;
        [self jaf_layoutSubview];
    }
    return self;
}

- (void)jaf_layoutSubview {
    [self.contentView addSubview:self.titleLab];
//    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.centerY.equalTo(self);
//        make.left.equalTo(self).offset(42);
//        make.height.mas_equalTo(22);
//        make.width.mas_equalTo(kScreenWidth-42-32);
//    }];
    self.titleLab.frame = CGRectMake(42, (self.height-22)/2, kScreenWidth-42-32, 22);

    
    if (self.indexPath.row == 0) {
        [self.contentView addSubview:self.letterLab];
//        [self.letterLab mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.centerY.equalTo(self);
//            make.left.equalTo(self).offset(16);
//            make.width.height.mas_equalTo(22);
//        }];
        self.letterLab.frame = CGRectMake(16, (self.height-22)/2, 22, 22);
    }
}

// MARK: model
- (void)setModel:(id _Nullable)model titles:(NSString *)title {
    if (!model) return;
    TSProvinceListModel *kModel = (TSProvinceListModel *)model;
    NSString *name = nil;
    if (kModel.provinceName) {
        name = kModel.provinceName;
    } else {
        name = kModel.cityName;
    }
    _titleLab.text = name;
    
    _letterLab.text = title;
}

// MARK: get
- (UILabel *)letterLab {
    if (!_letterLab) {
        _letterLab = [UILabel new];
        _letterLab.textColor = KHexAlphaColor(@"#2D3132", .5);
        _letterLab.font = KRegularFont(14);
        _letterLab.textAlignment = NSTextAlignmentLeft;
    }
    return _letterLab;
}

- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.textColor = KHexColor(@"#2D3132");
        _titleLab.font = KRegularFont(14);
        _titleLab.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLab;
}

@end


@implementation TSSelectorCellAddressHeader
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = KWhiteColor;
        [self jaf_layoutSubViews];
    }
    return self;
}

- (void)jaf_layoutSubViews {
    [self addSubview:self.oneTitleBtn];
    self.oneTitleBtn.frame = CGRectMake(16, (50-22)/2, 90, 22);
    
    [self addSubview:self.secondTitleBtn];
    self.secondTitleBtn.frame = CGRectMake(self.oneTitleBtn.right, (50-22)/2, 90, 22);
}

// MARK: actions
- (void)headerAction:(UIButton *)sender {
    if ([self.kDelegate respondsToSelector:@selector(selectorCellAddressHeaderAction:)]) {
        [self.kDelegate selectorCellAddressHeaderAction:sender];
    }
}

// MARK: get
- (UIButton *)oneTitleBtn {
    if (!_oneTitleBtn) {
        _oneTitleBtn.hidden = YES;
        _oneTitleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _oneTitleBtn.titleLabel.font = KRegularFont(14);
        [_oneTitleBtn setTitleColor:KHexColor(@"#2D3132") forState:UIControlStateNormal];
        [_oneTitleBtn addTarget:self action:@selector(headerAction:) forControlEvents:UIControlEventTouchUpInside];
        _oneTitleBtn.tag = 100;
    }
    return _oneTitleBtn;
}

- (UIButton *)secondTitleBtn {
    if (!_secondTitleBtn) {
        _secondTitleBtn.hidden = YES;
        _secondTitleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_secondTitleBtn setTitle:@"选择市区" forState:UIControlStateNormal];
        _secondTitleBtn.titleLabel.font = KRegularFont(14);
        [_secondTitleBtn setTitleColor:KHexColor(@"#E64C3D") forState:UIControlStateNormal];
        [_oneTitleBtn addTarget:self action:@selector(headerAction:) forControlEvents:UIControlEventTouchUpInside];
        _secondTitleBtn.tag = 101;
    }
    return _secondTitleBtn;
}
@end


@interface TSSelectorAddressHeader ()

@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UIButton *closeBtn;
@property (nonatomic ,strong) UIView *lineView;
@end
@implementation TSSelectorAddressHeader
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self jaf_layoutSubViews];
    }
    return self;
}

- (void)jaf_layoutSubViews {
    [self addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(16);
        make.height.mas_equalTo(22);
    }];
    
    [self addSubview:self.closeBtn];
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-16);
        make.height.mas_equalTo(24);
        make.width.mas_equalTo(24);
    }];
    
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.height.mas_equalTo(1);
        make.width.mas_equalTo(self.width);
    }];
}

// MARK: actions
- (void)closeAction:(UIButton *)sender {
    if ([self.kDelegate respondsToSelector:@selector(selectorHeaderCloseAction:)]) {
        [self.kDelegate selectorHeaderCloseAction:sender];
    }
}

// MAKR: get
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.text = @"请选择省市";
        _titleLab.textColor = KHexColor(@"#333333");
        _titleLab.font = KRegularFont(16);
    }
    return _titleLab;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn addTarget:self action:@selector(closeAction:) forControlEvents:UIControlEventTouchUpInside];
        [_closeBtn setImage:KImageMake(@"general_close") forState:UIControlStateNormal];
        [_closeBtn jaf_setEnlargeEdgeWithTop:10 right:10 bottom:10 left:10];
    }
    return _closeBtn;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = KlineColor;
    }
    return _lineView;
}
@end
