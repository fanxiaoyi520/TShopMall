//
//  TSScoreView.m
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/26.
//

#import "TSScoreView.h"

@interface TSScoreView ()<UITextViewDelegate>

@property (nonatomic ,strong) UILabel *titileLab;
@property (nonatomic ,strong) UILabel *detailLab;
@property (nonatomic ,strong) NSMutableArray *mutableArray;
@property (nonatomic ,strong) NSMutableArray *kArray;
@property (nonatomic ,strong) UIView *lineView;
@property (nonatomic ,strong) UITextView *inputTextView;
@property (nonatomic ,strong) UILabel *defaultLab;
@end
@implementation TSScoreView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self jaf_layoutSubView];
    }
    return self;
}

- (void)jaf_layoutSubView {
    [self addSubview:self.titileLab];
    [self.titileLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(16);
        make.centerX.equalTo(self);
        make.height.mas_equalTo(24);
    }];
    
    [self addSubview:self.detailLab];
    [self.detailLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(52);
        make.centerX.equalTo(self);
        make.height.mas_equalTo(18);
    }];
    
    for (int i=0; i<5; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:KImageMake(@"mine_xingxing_grep") forState:UIControlStateNormal];
        btn.tag = 10+i;
        [btn addTarget:self action:@selector(scoreAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [self.mutableArray addObject:btn];
    }
    
    [self.mutableArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:62 tailSpacing:62];
    [self.mutableArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(83);
        make.width.height.equalTo(@36);
    }];
    
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@[self.detailLab.mas_bottom]).offset(81);
        make.height.mas_equalTo(1);
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self).offset(-16);
    }];
    
    [self addSubview:self.inputTextView];
    [self.inputTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@[self.lineView.mas_bottom]).offset(10);
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self).offset(-16);
        make.bottom.equalTo(self).offset(-20);
    }];
    
    [self addSubview:self.defaultLab];
    [self.defaultLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@[self.inputTextView.mas_top]).offset(5);
        make.left.equalTo(self).offset(20);
        make.right.equalTo(self).offset(-20);
        make.height.mas_equalTo(24);
    }];
}

// MARK: action
- (void)scoreAction:(UIButton *)sender {
    [self.kArray removeAllObjects];
    for (int i=10; i<=sender.tag; i++) {
        UIButton *btn = [self viewWithTag:i];
        [btn setBackgroundImage:KImageMake(@"mine_xingxing_red") forState:UIControlStateNormal];
        [self.kArray addObject:btn];
    }
    
    NSPredicate *predicatel = [NSPredicate predicateWithFormat:@"NOT(SELF.tag in %@.tag)",self.kArray];
    NSArray *result = [self.mutableArray filteredArrayUsingPredicate:predicatel];
    for (UIButton *btn in result) {
        [btn setBackgroundImage:KImageMake(@"mine_xingxing_grep") forState:UIControlStateNormal];
    }
    
    if ([self.kDelegate respondsToSelector:@selector(scoreViewScoreAction:)]) {
        [self.kDelegate scoreViewScoreAction:sender];
    }
}

// MARK: UITextViewDelegate
- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length == 0) {
        self.defaultLab.text = @"写出你的真实想法，多些细节对大家更有帮助。";
    }else{
        self.defaultLab.text = @"";
    }
    
    if ([self.kDelegate respondsToSelector:@selector(scoreViewTextViewDidChange:)]) {
        [self.kDelegate scoreViewTextViewDidChange:textView];
    }
}

// MARK: get
- (UILabel *)titileLab {
    if (!_titileLab) {
        _titileLab = [UILabel new];
        _titileLab.textColor = KHexColor(@"#2D3132");
        _titileLab.font = KRegularFont(20);
        _titileLab.text = @"评分";
    }
    return _titileLab;
}

- (UILabel *)detailLab {
    if (!_detailLab) {
        _detailLab = [UILabel new];
        _detailLab.textColor = KHexAlphaColor(@"#2D3132",.8);
        _detailLab.font = KRegularFont(14);
        _detailLab.text = @"产品很棒，用的很爽";
    }
    return _detailLab;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = KHexColor(@"#E6E6E6");
    }
    return _lineView;
}

- (UITextView *)inputTextView {
    if (!_inputTextView) {
        _inputTextView = [[UITextView alloc] init];
        _inputTextView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _inputTextView.delegate = self;
        _inputTextView.textColor = KHexColor(@"#2D3132");
        _inputTextView.font = KRegularFont(14);
    }
    return _inputTextView;
}

- (UILabel *)defaultLab {
    if (!_defaultLab) {
        _defaultLab = [UILabel new];
        _defaultLab.textColor = KHexAlphaColor(@"#2D3132",.5);
        _defaultLab.font = KRegularFont(14);
        _defaultLab.text = @"写出你的真实想法，多些细节对大家更有帮助。";
        _detailLab.numberOfLines = 0;
    }
    return _defaultLab;
}

- (NSMutableArray *)mutableArray {
    if (!_mutableArray) {
        _mutableArray = [NSMutableArray array];
    }
    return _mutableArray;
}

- (NSMutableArray *)kArray {
    if (!_kArray) {
        _kArray = [NSMutableArray array];
    }
    return _kArray;
}

@end
