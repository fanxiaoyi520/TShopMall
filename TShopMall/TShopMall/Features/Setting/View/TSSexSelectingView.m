//
//  TSSexSelectingView.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/18.
//

#import "TSSexSelectingView.h"

@interface TSSexSelectingView()
/** 背景视图 */
@property(nonatomic, weak) UIView *contentView;
/** 顶部视图 */
@property(nonatomic, weak) UIView *topView;
/** 确定 */
@property(nonatomic, weak) UIButton *confirmButton;
/** 取消 */
@property(nonatomic, weak) UIButton *cancelButton;
/** 男视图 */
@property(nonatomic, weak) UIView *maleView;
/** 男性的图标 */
@property(nonatomic, weak) UIImageView *maleImgV;
/** 女视图 */
@property(nonatomic, weak) UIView *femaleView;
/** 女性的图标 */
@property(nonatomic, weak) UIImageView *femaleImgV;

@end

@implementation TSSexSelectingView

- (instancetype)init {
    if (self = [super init]) {
        [self setUpInit];
    }
    return self;
}

+ (instancetype)sexSelectingView {
    return [[self alloc] init];
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:.5 animations:^{
        CGRect rect = self.contentView.frame;
        rect.origin.y = kScreenHeight - self.contentView.frame.size.height;
        self.contentView.frame = rect;
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:.5 animations:^{
        CGRect rect = self.contentView.frame;
        rect.origin.y += self.contentView.bounds.size.height;
        self.contentView.frame = rect;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)setUpInit {
    self.contentView.backgroundColor = KWhiteColor;
    self.frame = [[UIScreen mainScreen] bounds];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    self.contentView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, 113 + GK_SAFEAREA_BTM);
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(0);
        make.top.equalTo(self.contentView.mas_top).with.offset(0);
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        make.height.mas_equalTo(45);
    }];
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.topView.mas_left).with.offset(16);
        make.top.equalTo(self.topView.mas_top).with.offset(16);
    }];
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.topView.mas_right).with.offset(-16);
        make.top.equalTo(self.topView.mas_top).with.offset(16);
    }];
    [self.maleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(16);
        make.right.equalTo(self.contentView.mas_right).with.offset(-16);
        make.top.equalTo(self.topView.mas_bottom).with.offset(16);
        make.height.mas_equalTo(25);
    }];
    [self.femaleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(16);
        make.right.equalTo(self.contentView.mas_right).with.offset(-16);
        make.top.equalTo(self.maleView.mas_bottom).with.offset(0);
        make.height.mas_equalTo(25);
    }];
    [self.maleImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.maleView.mas_centerX).with.offset(0);
        make.centerY.equalTo(self.maleView.mas_centerY).with.offset(0);
        make.width.mas_equalTo(17);
        make.height.mas_equalTo(17);
    }];
    [self.femaleImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.femaleView.mas_centerX).with.offset(0);
        make.centerY.equalTo(self.femaleView.mas_centerY).with.offset(0);
        make.width.mas_equalTo(17);
        make.height.mas_equalTo(17);
    }];
    if (self.sex == female) {
        self.maleView.backgroundColor = KWhiteColor;
    } else {
        self.femaleView.backgroundColor = KWhiteColor;
        self.sex = male;
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (CGRectContainsPoint(self.contentView.frame, point)) {
        return;
    }
    [self dismiss];
}

- (UIView *)contentView {
    if (_contentView == nil) {
        UIView *contentView = [[UIView alloc] init];
        _contentView = contentView;
        [self addSubview:_contentView];
    }
    return _contentView;
}

- (UIView *)topView {
    if (_topView == nil) {
        UIView *topView = [[UIView alloc] init];
        _topView = topView;
        [self.contentView addSubview:_topView];
    }
    return _topView;
}

- (UIButton *)cancelButton {
    if (_cancelButton == nil) {
        UIButton *cancelButton = [[UIButton alloc] init];
        _cancelButton = cancelButton;
        _cancelButton.titleLabel.font = KRegularFont(16);
        [_cancelButton setTitleColor:KHexColor(@"#FF4D49") forState:(UIControlStateNormal)];
        [_cancelButton setTitle:@"取消" forState:(UIControlStateNormal)];
        [_cancelButton addTarget:self action:@selector(cancelAciton) forControlEvents:(UIControlEventTouchUpInside)];
        [self.topView addSubview:_cancelButton];
    }
    return _cancelButton;
}

- (UIButton *)confirmButton {
    if (_confirmButton == nil) {
        UIButton *confirmButton = [[UIButton alloc] init];
        _confirmButton = confirmButton;
        _confirmButton.titleLabel.font = KRegularFont(16);
        [_confirmButton setTitleColor:KHexColor(@"#FF4D49") forState:(UIControlStateNormal)];
        [_confirmButton setTitle:@"确定" forState:(UIControlStateNormal)];
        [_confirmButton addTarget:self action:@selector(confirmAciton) forControlEvents:(UIControlEventTouchUpInside)];
        [self.topView addSubview:_confirmButton];
    }
    return _confirmButton;
}

- (UIView *)maleView {
    if (_maleView == nil) {
        UIView *maleView = [[UIView alloc] init];
        _maleView = maleView;
        _maleView.layer.cornerRadius = 5;
        _maleView.clipsToBounds = YES;
        _maleView.backgroundColor = KHexColor(@"#F4F4F5");
        [_maleView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedMale)]];
        [self.contentView insertSubview:_maleView atIndex:0];
    }
    return _maleView;
}

- (UIView *)femaleView {
    if (_femaleView == nil) {
        UIView *femaleView = [[UIView alloc] init];
        _femaleView = femaleView;
        _femaleView.layer.cornerRadius = 5;
        _femaleView.clipsToBounds = YES;
        _femaleView.backgroundColor = KHexColor(@"#F4F4F5");
        [_femaleView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectedFemale)]];
        [self.contentView insertSubview:_femaleView atIndex:0];
    }
    return _femaleView;
}

- (UIImageView *)maleImgV {
    if (_maleImgV == nil) {
        UIImageView *maleImgV = [[UIImageView alloc] init];
        _maleImgV = maleImgV;
        _maleImgV.image = KImageMake(@"mall_setting_male");
        [self.contentView addSubview:_maleImgV];
    }
    return _maleImgV;
}

- (UIImageView *)femaleImgV {
    if (_femaleImgV == nil) {
        UIImageView *femaleImgV = [[UIImageView alloc] init];
        _femaleImgV = femaleImgV;
        _femaleImgV.image = KImageMake(@"mall_setting_female");
        [self.contentView addSubview:_femaleImgV];
    }
    return _femaleImgV;
}

#pragma mark - Actions

- (void)cancelAciton {
    [self dismiss];
}

- (void)confirmAciton {
    if ([self.delegate respondsToSelector:@selector(selectedSex:)]) {
        [self.delegate selectedSex:self.sex];
    }
    [self dismiss];
}

- (void)selectedMale {
    self.sex = male;
    self.femaleView.backgroundColor = KWhiteColor;
    self.maleView.backgroundColor = KHexColor(@"#F4F4F5");
}

- (void)selectedFemale {
    self.sex = female;
    self.femaleView.backgroundColor = KHexColor(@"#F4F4F5");
    self.maleView.backgroundColor = KWhiteColor;
}

@end
