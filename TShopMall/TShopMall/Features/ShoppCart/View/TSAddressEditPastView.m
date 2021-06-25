//
//  TSAddressEditPastView.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/17.
//

#import "TSAddressEditPastView.h"

@interface TSPastLabel : UILabel
@property (nonatomic, copy) void(^pastDone)(NSString *);
@property (nonatomic, assign) BOOL isContentAddress;
@property (nonatomic, assign) UIEdgeInsets edgeInsets;
@end

@interface TSAddressEditPastView()
@property (nonatomic, strong) TSPastLabel *pastLabel;
@property (nonatomic, strong) UILabel *closeTips;
@property (nonatomic, strong) UIButton *closeBtn;
@end

@implementation TSAddressEditPastView

- (instancetype)init{
    if (self == [super init]) {
        self.userInteractionEnabled = YES;
        [self layoutView];
    }
    return self;
}

- (void)closeBtnAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    [self updatePastViewHeight];
}


- (void)closeTipsAction{
    self.closeBtn.selected = !self.closeBtn.selected;
    [self updatePastViewHeight];
}

- (void)updatePastView:(NSString *)string{
    if (string.length == 0) {
        self.pastLabel.isContentAddress = NO;
    } else {
        self.pastLabel.text = string;
        self.pastLabel.isContentAddress = YES;
    }
    [self updatePastViewHeight];
}

- (void)updatePastViewHeight{
    CGFloat height = KRateW(83.0);
    if (self.pastLabel.isContentAddress == YES) {
        height = [self.pastLabel.text heightForFont:KRegularFont(14.0) width:kScreenWidth - KRateW(32.0)];
    }
    if (self.closeBtn.selected == YES) {
        height = 0;
    }
    [UIView animateWithDuration:0.3 animations:^{
        [self.pastLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(height);
        }];
        [self layoutSubviews];
    } completion:^(BOOL finished) {

    }];
}

- (void)layoutView{
    
    [self.pastLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(KRateW(16.0));
        make.right.equalTo(self.mas_right).offset(-KRateW(16.0));
        make.top.equalTo(self.mas_top).offset(KRateW(8.0));
        make.height.mas_equalTo(KRateW(82.0));
    }];
    
    [self.closeTips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_centerX).offset(KRateW(7.0));
        make.top.equalTo(self.pastLabel.mas_bottom).offset(KRateW(14.0));
        make.height.mas_equalTo(KRateW(20.0));
        make.bottom.equalTo(self.mas_bottom).offset(-1);
    }];
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.closeTips);
        make.width.height.mas_equalTo(KRateW(12.0));
        make.left.equalTo(self.closeTips.mas_right).offset(KRateW(4.0));
    }];
    
    [self layoutSubviews];
}

- (TSPastLabel *)pastLabel{
    if (_pastLabel) {
        return _pastLabel;
    }
    self.pastLabel = [TSPastLabel new];
    self.pastLabel.layer.cornerRadius = KRateW(8.0);
    self.pastLabel.layer.masksToBounds = YES;
    self.pastLabel.backgroundColor = KHexColor(@"#F6F6F6");
    [self addSubview:self.pastLabel];
    __weak typeof(self) weakSelf = self;
    self.pastLabel.pastDone = ^(NSString *str) {
        weakSelf.pastContentChanged(str);
    };
    
    return self.pastLabel;
}

- (UILabel *)closeTips{
    if (_closeTips) {
        return _closeTips;
    }
    self.closeTips = [UILabel new];
    self.closeTips.font = KRegularFont(14.0);
    self.closeTips.text = @"地址粘贴板";
    self.closeTips.textColor = KHexColor(@"#A0A0A0");
    [self addSubview:self.closeTips];
    
    self.closeTips.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeTipsAction)];
    tapGes.numberOfTouchesRequired = 1;
    [self.closeTips addGestureRecognizer:tapGes];
    
    return self.closeTips;
}

- (UIButton *)closeBtn{
    if (_closeBtn) {
        return _closeBtn;
    }
    self.closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.closeBtn setBackgroundImage:KImageMake(@"inde_down") forState:UIControlStateNormal];
    [self.closeBtn setBackgroundImage:KImageMake(@"inde_up") forState:UIControlStateSelected];
    [self.closeBtn addTarget:self action:@selector(closeBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.closeBtn];
    
    return self.closeBtn;
}

@end


@implementation TSPastLabel

- (instancetype)init{
    if (self == [super init]) {
        self.edgeInsets = UIEdgeInsetsMake(KRateW(8.0), KRateW(8.0), KRateW(8.0), KRateW(8.0));
        self.numberOfLines = 0;
        self.font = KRegularFont(14.0);
        self.userInteractionEnabled = YES;
        self.isContentAddress = NO;
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showPastMenu:)];
        tapGes.numberOfTapsRequired = 1;
        [self addGestureRecognizer:tapGes];
    }
    return self;
}

- (void)showPastMenu:(UITapGestureRecognizer *)tapGes {
    [self becomeFirstResponder]; //UILabel默认是不能响应事件的，所以要让它成为第一响应者
    UIMenuController *menuVC = [UIMenuController sharedMenuController];
    [menuVC setTargetRect:self.frame inView:self.superview]; //定位Menu
    [menuVC setMenuVisible:YES animated:YES]; //展示Menu
}

- (BOOL)canBecomeFirstResponder{
    return YES;
}

- (void)setIsContentAddress:(BOOL)isContentAddress{
    if (isContentAddress == YES) {
        self.textColor = KTextColor;
        self.textAlignment = NSTextAlignmentLeft;
    } else {
        self.textColor = KHexColor(@"#CBCBCB");
        self.text = @"试试黏贴收件人姓名/手机号/收货地址\n可快速识别您的收货信息";
        self.textAlignment = NSTextAlignmentCenter;
    }
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender{
    if (action == @selector(paste:)) {
        return YES;
    }
    return NO;
}

- (void)paste:(id)sender{
    UIPasteboard *pb = [UIPasteboard generalPasteboard];
    if (pb.string.length == 0) {
        return;
    }
    if (self.pastDone) {
        self.pastDone(pb.string);
    }
}

- (CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines{
    UIEdgeInsets edgs = self.edgeInsets;
    CGRect rect = [super textRectForBounds:UIEdgeInsetsInsetRect(bounds, edgs) limitedToNumberOfLines:numberOfLines];
    rect.origin.x    -= edgs.left;
    rect.origin.y    -= edgs.top;
    rect.size.width  += (edgs.left + edgs.right);
    rect.size.height += (edgs.top + edgs.bottom);
    return rect;
}

- (void)drawTextInRect:(CGRect)rect {
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.edgeInsets)];
}

@end
