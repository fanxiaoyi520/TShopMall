//
//  TSAreaCard.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/18.
//

#import "TSAreaCard.h"

@interface TSAreaButton : UITextField<UITextFieldDelegate>
- (void)addTarget:(id)target selector:(SEL)selector;
@end

@interface TSAreaView : UIScrollView
@property (nonatomic, strong) TSAreaButton *proviceBtn;
@property (nonatomic, strong) TSAreaButton *cityBtn;
@property (nonatomic, strong) TSAreaButton *areaBtn;
@property (nonatomic, strong) TSAreaButton *streetBtn;
@end

@interface TSAreaCard()
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIButton *closeBtn;
@property (nonatomic, strong) UILabel *locationTips;
@property (nonatomic, strong) UIButton *locationBtn;
@property (nonatomic, strong) UILabel *locationAddress;
@property (nonatomic, strong) TSAreaView *areaView;
@end

@implementation TSAreaCard

- (instancetype)init{
    if (self == [super init]) {
        self.backgroundColor = UIColor.whiteColor;
        self.layer.cornerRadius = KRateW(8.0);
        self.layer.masksToBounds = YES;
        
        [self configUI];
    }
    return self;
}

- (void)configUI{
    self.title.text = @"请选择所在地区";
    self.locationTips.text = @"定位到的地址";
    self.locationAddress.text = @"1232546577";
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
    
    return self.areaView;
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
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    self.cityBtn.hidden = !self.proviceBtn.text.length;
    self.areaBtn.hidden = !self.cityBtn.text.length;
    self.streetBtn.hidden = !self.areaBtn.text.length;
}

- (void)layoutSubviews{
    [self.proviceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
    }];
    
    [self.cityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.proviceBtn.mas_right).offset(KRateW(24.0));
    }];
    
    [self.areaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.cityBtn.mas_right).offset(KRateW(24.0));
    }];
    
    [self.streetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.areaBtn.mas_right).offset(KRateW(24.0));
        make.right.mas_equalTo(self.mas_right);
    }];
}

- (TSAreaButton *)proviceBtn{
    if (_proviceBtn) {
        return _proviceBtn;
    }
    self.proviceBtn = [TSAreaButton new];
    self.proviceBtn.placeholder = @"选择省份";
    [self addSubview:self.proviceBtn];
    
    return self.proviceBtn;
}

- (TSAreaButton *)cityBtn{
    if (_cityBtn) {
        return _cityBtn;
    }
    self.cityBtn = [TSAreaButton new];
    self.cityBtn.placeholder = @"选择市区";
    [self addSubview:self.cityBtn];
    
    return self.cityBtn;
}

- (TSAreaButton *)areaBtn{
    if (_areaBtn) {
        return _areaBtn;
    }
    self.areaBtn = [TSAreaButton new];
    self.areaBtn.placeholder = @"选择区/县";
    [self addSubview:self.areaBtn];
    
    return self.areaBtn;
}

- (TSAreaButton *)streetBtn{
    if (_streetBtn) {
        return _streetBtn;
    }
    self.streetBtn = [TSAreaButton new];
    self.streetBtn.placeholder = @"选择街道";
    [self addSubview:self.streetBtn];
    
    return self.streetBtn;
}

@end

@implementation TSAreaButton

- (instancetype)init{
    if (self == [super init]) {
        self.textColor = KHexColor(@"#2D3132");
        self.font = KFont(PingFangSCMedium, 14.0);
        self.delegate = self;
    }
    return self;
}

- (void)addTarget:(id)target selector:(SEL)selector{
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
    tapGes.numberOfTouchesRequired = 1;
    [self addGestureRecognizer:tapGes];
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    return NO;
}


- (void)setPlaceholder:(NSString *)placeholder{
    if (placeholder.length == 0) {
        return;
    }
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:placeholder];
    [attStr addAttributes:@{
            NSFontAttributeName : KFont(PingFangSCMedium, 14.0),
            NSForegroundColorAttributeName : KHexColor(@"#E64C3D")
    } range:NSMakeRange(0, placeholder.length)];
    self.attributedPlaceholder = attStr;
}
@end
