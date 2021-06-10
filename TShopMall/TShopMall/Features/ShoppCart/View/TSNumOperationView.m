//
//  TSNumOperationView.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/10.
//

#import "TSNumOperationView.h"

@implementation TSNumOperationView

- (instancetype)init{
    if (self == [super init]) {
        self.min = 0;
        self.max = 1000000;
    }
    return self;
}

- (void)executeOperationDone:(NumOperationType)type{
    if (self.numberOperationDone) {
        self.numberOperationDone(self.number.text, type);
    }
}

- (void)setMin:(NSInteger)min{
    _min = min;
    [self updateBtnStatus];
}

- (void)setMax:(NSInteger)max{
    _max = max;
    [self updateBtnStatus];
}

- (void)updateBtnStatus{
    NSInteger num = self.number.text.intValue;
    if (num <= self.min) {
        self.diviBtn.selected = YES;
    } else {
        self.diviBtn.selected = NO;
    }
    if (num >= self.max) {
        self.addBtn.selected = YES;
    } else {
        self.addBtn.selected = NO;
    }
}

- (void)addAction{
    [self endEditing:YES];
    if (self.addBtn.selected == YES) {
        [self executeOperationDone:Add];
        return;
    }
    NSInteger num = self.number.text.intValue;
    if (num >= self.max) {
        num = self.max;
    } else {
        num ++;
    }
    self.number.text = [NSString stringWithFormat:@"%ld", num];
    [self updateBtnStatus];
    [self executeOperationDone:Add];
}

- (void)diviAction{
    [self endEditing:YES];
    if (self.diviBtn.selected == YES) {
        [self executeOperationDone:Divi];
        return;
    }
    NSInteger num = self.number.text.intValue;
    if (num <= self.min) {
        num = self.min;
    } else {
        num -- ;
    }
    self.number.text = [NSString stringWithFormat:@"%ld", num];
    [self updateBtnStatus];
    [self executeOperationDone:Divi];
}

- (void)editingEnd:(UITextField *)sender{
    NSInteger num = self.number.text.intValue;
    if (num <= self.min) {
        self.number.text = [NSString stringWithFormat:@"%ld", self.min];
    }
    if (num >= self.max) {
        self.number.text = [NSString stringWithFormat:@"%ld", self.max];
    }
    
    [self updateBtnStatus];
    
    [self executeOperationDone:Edit];
}

- (void)layoutSubviews{
    [self.addBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.width.height.equalTo(self.mas_height);
        make.top.equalTo(self.mas_top);
    }];
    
    [self.number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.right.equalTo(self.addBtn.mas_left);
        make.width.equalTo(self.mas_height).multipliedBy(1.5);
    }];
    
    [self.diviBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.number.mas_left);
        make.top.bottom.width.equalTo(self.addBtn);
        make.left.equalTo(self.mas_left);
    }];
}

- (UIButton *)addBtn{
    if (_addBtn) {
        return _addBtn;
    }
    self.addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.addBtn setImage:KImageMake(@"btn_add_normal") forState:UIControlStateNormal];
    [self.addBtn setImage:KImageMake(@"btn_add_enable") forState:UIControlStateSelected];
    [self.addBtn addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.addBtn];
    
    return self.addBtn;
}

- (UIButton *)diviBtn{
    if (_diviBtn) {
        return _diviBtn;
    }
    self.diviBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.diviBtn setImage:KImageMake(@"btn_divi_normal") forState:UIControlStateNormal];
    [self.diviBtn setImage:KImageMake(@"btn_divi_enable") forState:UIControlStateSelected];
    [self.diviBtn addTarget:self action:@selector(diviAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.diviBtn];
    return self.diviBtn;
}

- (UITextField *)number{
    if (_number) {
        return _number;
    }
    self.number = [UITextField new];
    self.number.text = @"1";
    self.number.backgroundColor = [UIColor whiteColor];
    self.number.layer.cornerRadius = 2.0;
    self.number.layer.masksToBounds = YES;
    self.number.font = KFont(PingFangSCMedium, 14.0);
    self.number.keyboardType = UIKeyboardTypeNumberPad;
    self.number.returnKeyType = UIReturnKeyDone;
    self.number.textAlignment = NSTextAlignmentCenter;
    [self.number addTarget:self action:@selector(editingEnd:) forControlEvents:UIControlEventEditingDidEnd];
    [self addSubview:self.number];
    
    return self.number;
}

@end
