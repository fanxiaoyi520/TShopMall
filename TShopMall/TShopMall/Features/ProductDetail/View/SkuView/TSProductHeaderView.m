//
//  TSProductHeaderView.m
//  TSale
//
//  Created by Daisy  on 2020/12/9.
//  Copyright © 2020 TCL. All rights reserved.
//

#import "TSProductHeaderView.h"


@interface TSProductHeaderView()

/// 商品图片
@property (nonatomic, strong) UIImageView *iconImge;
/// 关闭弹窗按钮
@property (nonatomic, strong) UIButton *closeBtn;
/// 价格
@property (nonatomic, strong) UILabel *priceLable;
/// 已选参数
@property (nonatomic, strong) UILabel *selectedCount;
/// 库存状态
@property (nonatomic, strong) UILabel *statusLable;

@end

@implementation TSProductHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self makeConstraintsUI];
    }
    return self;
}

#pragma mark -UI布局
-(void)makeConstraintsUI {
    [self addSubview:self.iconImge];
    [self addSubview:self.closeBtn];
    [self addSubview:self.statusLable];
    [self addSubview:self.selectedCount];
    [self addSubview:self.priceLable];
    
    [self.iconImge mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(88, 88));
        make.left.equalTo(self).offset(16);
        make.top.equalTo(self).offset(16);
    }];
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.right.equalTo(self.mas_right).offset(-18);
        make.top.equalTo(self.mas_top).offset(18);
    }];

    [self.priceLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.iconImge);
        make.height.equalTo(@(28));
        make.left.equalTo(self.iconImge.mas_right).offset(8);
    }];
    
    [self.selectedCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLable);
        make.right.equalTo(self.mas_right).offset(-10);
        make.top.equalTo(self.priceLable.mas_bottom).offset(4);
        make.height.equalTo(@(22));
    }];

    [self.statusLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceLable);
        make.bottom.equalTo(self.iconImge);
        make.height.equalTo(@(22));
    }];
}

#pragma mark - Actions
-(void)closePopupEvent:(UIButton *)sender{
    
}

#pragma mark - Getter
-(UIImageView *)iconImge{
    if (!_iconImge) {
        _iconImge = [UIImageView new];
        _iconImge.layer.cornerRadius = 8;
        _iconImge.clipsToBounds = YES;
        _iconImge.backgroundColor = [UIColor redColor];
    }
    return _iconImge;
}

-(UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_closeBtn setBackgroundImage:KImageMake(@"cancel") forState:UIControlStateNormal];
        [_closeBtn addTarget:self action:@selector(closePopupEvent:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}

-(UILabel *)priceLable{
    if (!_priceLable) {
        _priceLable = [UILabel new];
        _priceLable.textAlignment = NSTextAlignmentCenter;
        _priceLable.text = @"¥8999";
    }
    return _priceLable;
}

-(UILabel *)selectedCount{
    if (!_selectedCount) {
        _selectedCount = [UILabel new];
        _selectedCount.textColor = KHexAlphaColor(@"#2D3132", 0.6);
        _selectedCount.font = KRegularFont(14);
        _selectedCount.text = @"已选：75寸";
    }
    return _selectedCount;
}

-(UILabel *)statusLable{
    if (!_statusLable) {
        _statusLable = [UILabel new];
        _statusLable.textColor = KMainColor;
        _statusLable.font = KRegularFont(14.0);
        _statusLable.text = @"库存紧张";
    }
    return _statusLable;;
}


@end
