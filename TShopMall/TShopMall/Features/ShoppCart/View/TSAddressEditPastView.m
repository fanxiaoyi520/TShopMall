//
//  TSAddressEditPastView.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/17.
//

#import "TSAddressEditPastView.h"

@interface TSPastLabel : UILabel
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

- (void)updatePastViewHeight{
    [UIView animateWithDuration:0.3 animations:^{
        [self.pastLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(self.closeBtn.selected==YES? 0:KRateW(82.0));
        }];
        [self layoutSubviews];
    } completion:^(BOOL finished) {
        
    }];
}

- (void)layoutView{
    [self.pastLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(KRateW(16.0));
        make.right.equalTo(self.mas_right).offset(-KRateW(16.0));
        make.top.equalTo(self.mas_top).offset(KRateW(10.0));
        make.height.mas_equalTo(KRateW(82.0));
    }];
    
    [self.closeTips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_centerX).offset(KRateW(7.0));
        make.top.equalTo(self.pastLabel.mas_bottom).offset(KRateW(14.0));
        make.height.mas_equalTo(KRateW(20.0));
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    [self.closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.closeTips);
        make.width.height.mas_equalTo(KRateW(12.0));
        make.left.equalTo(self.closeTips.mas_right).offset(KRateW(4.0));
    }];
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
        self.numberOfLines = 0;
        self.font = KRegularFont(14.0);
        self.userInteractionEnabled = YES;
        self.text = @"";
    }
    return self;
}

- (void)setText:(NSString *)text{
    [super setText:text];
    if (text.length != 0) {
        self.textColor = KHexColor(@"#CBCBCB");
        self.textAlignment = NSTextAlignmentLeft;
    } else {
        self.textColor = KHexColor(@"#2D3132");
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
    self.text = pb.string;
}

@end
