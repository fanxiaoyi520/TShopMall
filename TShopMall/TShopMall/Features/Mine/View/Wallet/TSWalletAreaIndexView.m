//
//  TSWalletAreaIndexView.m
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/7/1.
//

#import "TSWalletAreaIndexView.h"

@implementation TSWalletAreaIndexView

- (instancetype)init{
    if (self == [super init]) {
        [self layouView];
    }
    return self;
}

- (void)setIndexs:(NSArray<NSString *> *)indexs{
    _indexs = indexs;
    self.hidden = !indexs.count;
    [self configIndexUI];
}

- (void)tapAction:(UIButton *)sender{
    if (sender.selected == YES) return;
    for (UIButton *btn in self.bgView.subviews) {
        if (btn.tag == sender.tag) {
            btn.selected = YES;
        } else {
            btn.selected = NO;
        }
    }
    self.lastTag = sender.tag;
    [self updateIndeImgae:sender.tag];
    self.indeDes.text = self.indexs[sender.tag];
}

- (void)configIndexUI{
    for (UIView *view in self.bgView.subviews) {
        [view removeFromSuperview];
    }
    [self.bgView layoutIfNeeded];
    CGFloat h = self.bgView.height / self.indexs.count;
    self.btnHeight = h;
    for (NSInteger i=0; i<self.indexs.count; i++) {
        UIButton *btn = [UIButton new];
        [btn setTitleColor:[KHexColor(@"#333333") colorWithAlphaComponent:0.6] forState:UIControlStateNormal];
        [btn setTitleColor:KHexColor(@"#333333") forState:UIControlStateSelected];
        btn.titleLabel.font = KRegularFont(8.0);
        [btn setTitle:self.indexs[i] forState:UIControlStateNormal];
        [self.bgView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.bgView);
            make.top.equalTo(self.bgView.mas_top).offset(h * i);
            make.height.mas_equalTo(h);
        }];
        btn.tag = i;
        [btn addTarget:self action:@selector(tapAction:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)bgViewPanGestureAction:(UIPanGestureRecognizer *)panGes{
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    [self handleTouch:touch];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self defaultUI];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    UITouch *touch = [touches anyObject];
    [self handleTouch:touch];
}

- (void)handleTouch:(UITouch *)touch{
    CGPoint point = [touch locationInView:self];
    CGFloat availableX = self.frame.size.width - KRateW(16.0);
    if (point.x >= availableX) {
        self.indeImg.hidden = NO;
        self.indeImg.alpha = 1;
        NSInteger index = point.y / self.btnHeight;
        NSString *str = self.indexs[index];
        self.indeDes.text = str;
        [self updateBtnStatus:index];
        [self updateIndeImgae:index];
        if (self.indexChanged) {
            self.indexChanged(index);
        }
    } else {
        [self performSelector:@selector(defaultUI) afterDelay:2.3];
    }
}

- (void)defaultUI{
    [UIView animateWithDuration:0.4 animations:^{
        self.indeImg.alpha = 0;
    } completion:^(BOOL finished) {
        self.indeImg.hidden = YES;
    }];
    
    for (UIButton *btn in self.bgView.subviews) {
        btn.selected = NO;
    }
}

- (void)updateBtnStatus:(NSInteger)index{
    if (self.lastTag == index) return;
    self.lastTag = index;
    for (UIButton *btn in self.bgView.subviews) {
        if (btn.tag == index) {
            btn.selected = YES;
        } else {
            btn.selected = NO;
        }
    }
}

- (void)updateIndeImgae:(NSInteger)index{
    [UIView animateWithDuration:0.3 animations:^{
        [self.indeImg mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.bgView.mas_top).offset(self.btnHeight * (index + 1) - self.btnHeight/2.0);
        }];
        [self layoutSubviews];
    }];
}

- (void)layouView{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.equalTo(self);
        make.width.mas_equalTo(KRateW(16.0));
    }];
    
    [self.indeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView.mas_left).offset(-KRateW(8.0));
        make.width.mas_equalTo(KRateW(44.0));
        make.height.mas_equalTo(KRateW(36.0));
        make.centerY.equalTo(self.bgView.mas_top).offset(self.btnHeight);
    }];
    
    [self.indeDes mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.indeImg.mas_centerX).offset(-KRateW(3.0));
        make.top.bottom.equalTo(self.indeImg);
    }];
}

- (UIView *)bgView{
    if (_bgView) {
        return _bgView;
    }
    self.bgView = [UIView new];
    self.bgView.layer.cornerRadius = KRateW(8.0);
    self.bgView.layer.masksToBounds = YES;
    self.bgView.backgroundColor = KHexColor(@"#EAEAEA");
    [self addSubview:self.bgView];
    self.bgView.userInteractionEnabled = NO;
    
    return self.bgView;
}

- (UIImageView *)indeImg{
    if (_indeImg) {
        return _indeImg;
    }
    self.indeImg = [UIImageView new];
    self.indeImg.hidden = YES;
    self.indeImg.image = KImageMake(@"address_index_bg");
    [self addSubview:self.indeImg];
    
    return self.indeImg;
}

- (UILabel *)indeDes{
    if (_indeDes) {
        return _indeDes;
    }
    self.indeDes = [UILabel new];
    self.indeDes.font = KFont(PingFangSCMedium, 24.0);
    self.indeDes.textColor = KHexColor(@"#FFFFFF");
    [self.indeImg addSubview:self.indeDes];
    
    return self.indeDes;
}

@end

