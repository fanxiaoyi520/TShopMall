//
//  TSGoodsListFittleView.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/13.
//

#import "TSGoodsListFittleView.h"

@interface TSGoodsListFittleButton : UIButton
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UIImageView *indeImg;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, assign) BOOL isUp;
@end

@implementation TSGoodsListFittleView

- (instancetype)init{
    if (self == [super init]) {
        self.backgroundColor = UIColor.whiteColor;
        [self setFittleItems];
    }
    return self;
}

- (void)itemTap:(TSGoodsListFittleButton *)sender{
    if (sender.selected == YES) {
        sender.selected = YES;
        [self.delegate operationType:sender.tag sortType:sender.isUp];
        return;
    }
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[TSGoodsListFittleButton class]]) {
            TSGoodsListFittleButton *btn = (TSGoodsListFittleButton *)view;
            if (btn.tag == sender.tag) {
                btn.selected = YES;
            } else {
                btn.selected = NO;
            }
        }
    }
    
    [self.delegate operationType:sender.tag sortType:sender.isUp];
}

- (void)setFittleItems{
    NSArray *items = @[@"综合", @"佣金", @"销量", @"价格"];
    CGFloat btnWidth = kScreenWidth / items.count;
    for (NSInteger i=0; i<items.count; i++) {
        TSGoodsListFittleButton *btn = [TSGoodsListFittleButton new];
        btn.selected = i==0? YES:NO;
        btn.indeImg.hidden = i==0? YES:NO;
        btn.name.text = items[i];
        [self addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(btnWidth * i);
            make.width.mas_equalTo(btnWidth);
            make.top.bottom.equalTo(self);
        }];
        btn.tag = i;
        [btn addTarget:self action:@selector(itemTap:) forControlEvents:UIControlEventTouchUpInside];
    }
}

@end


@implementation TSGoodsListFittleButton

- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    if (selected == YES) {
        self.isUp = !self.isUp;
        self.name.textColor = KHexColor(@"#E64C3D");
        if (self.isUp == YES) {
            self.indeImg.image = KImageMake(@"inde_red_up");
        } else {
            self.indeImg.image = KImageMake(@"inde_red_down");
        }
    } else {
        self.isUp = NO;
        self.name.textColor = KHexAlphaColor(@"#2D3132", 0.6);
        self.indeImg.image = KImageMake(@"");
    }
}

- (void)layoutSubviews{
    [self.name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.height.mas_equalTo(KRateW(24.0));
    }];
    
    [self.indeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.name.mas_right).offset(KRateW(2));
        make.width.height.mas_equalTo(KRateW(12.0));
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right);
        make.width.mas_equalTo(1);
        make.centerY.equalTo(self);
        make.height.mas_equalTo(KRateW(14.0));
    }];
}

- (UILabel *)name{
    if (_name) {
        return _name;
    }
    self.name = [UILabel new];
    self.name.font  = KRegularFont(16.0);
    self.name.textColor = KHexAlphaColor(@"#2D3132", 0.6);
    [self addSubview:self.name];
    
    return self.name;
}

- (UIImageView *)indeImg{
    if (_indeImg) {
        return _indeImg;
    }
    self.indeImg = [UIImageView new];
    [self addSubview:self.indeImg];
    
    return self.indeImg;
}

- (UIView *)line{
    if (_line) {
        return _line;
    }
    self.line = [UIView new];
    self.line.backgroundColor = KHexColor(@"#E6E6E6");
    [self addSubview:self.line];
    
    return self.line;
}

@end
