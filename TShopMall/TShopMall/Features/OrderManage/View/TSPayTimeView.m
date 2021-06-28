//
//  TSPayTimeView.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/28.
//

#import "TSPayTimeView.h"

@interface TSPayTimeView(){
    NSTimeInterval payTimeLeft;
}
@property (nonatomic, strong) UILabel *timeBg;
@property (nonatomic, strong) UILabel *time;

@property (nonatomic, strong) UIView *priceView;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) UIImageView *watchImg;
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation TSPayTimeView

- (instancetype)init{
    if (self == [super init]) {
        self.image = KImageMake(@"mall_pay_bg");
        [self testUI];
    }
    return self;
}

- (void)updateOrederPriec:(NSString *)price{
    self.price.text = [NSString stringWithFormat:@"¥ %@", price];
}

- (void)updateTime:(NSTimeInterval)time{
    int days = (int)time / (3600*24);
    int hours = (time - days*24*3600) / 3600;
    int minute = (time - days*24*3600-hours*3600)/60;
    int second = time - days*24*3600-hours*3600-minute*60;
 
    self.time.text = [NSString stringWithFormat:@"支付剩余时间 %d:%d:%d", days * 24 + hours, minute, second];
}

- (void)startCountDown{
    payTimeLeft --;
    [self updateTime:payTimeLeft];
    if (payTimeLeft <= 0) {
        [self.timer setFireDate:[NSDate distantFuture]];
        self.timer = nil;
        if (self.payTimeEnd) {
            self.payTimeEnd();
        }
    }
}

- (void)orderCurrentTime:(NSTimeInterval)currentTime endTime:(NSTimeInterval)endTime{
    currentTime = currentTime / 1000;
    endTime = endTime / 1000;
    payTimeLeft = endTime - currentTime;
    [self.timer fire];
}

- (void)testUI{
    self.time.text = @"支付剩余时间14:50:00";
}

- (void)layoutSubviews{
    self.timeBg.layer.cornerRadius = KRateW(12.0);
    self.timeBg.layer.masksToBounds = YES;
    [self.timeBg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(-KRateW(34.0));
        make.height.mas_equalTo(KRateW(24.0));
    }];
    
    [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self.timeBg);
        make.left.equalTo(self.timeBg.mas_left).offset(KRateW(16.0));
        make.right.equalTo(self.timeBg.mas_right).offset(-KRateW(16.0)).priorityHigh();
    }];
    
    [self.priceView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.height.mas_equalTo(KRateW(20.0));
        make.bottom.equalTo(self.timeBg.mas_top).offset(-KRateW(16.0));
    }];
    
    [self.watchImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.priceView);
        make.width.height.mas_equalTo(KRateW(20.0));
        make.centerY.equalTo(self.priceView);
    }];
    
    [self.price mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.watchImg.mas_right).offset(KRateW(8.0));
        make.top.bottom.equalTo(self.priceView);
        make.right.equalTo(self.priceView.mas_right).priorityHigh();
    }];
}

- (UILabel *)timeBg{
    if (_timeBg) {
        return _timeBg;
    }
    self.timeBg = [UILabel new];
    self.timeBg.backgroundColor = [KHexColor(@"#FFFFFF") colorWithAlphaComponent:0.2];
    [self addSubview:self.timeBg];
    
    return self.timeBg;
}

- (UILabel *)time{
    if (_time) {
        return _time;
    }
    self.time = [UILabel new];
    self.time.font = KRegularFont(12.0);
    self.time.textColor = KWhiteColor;
    [self.timeBg addSubview:self.time];
    
    return self.time;
}

- (UIView *)priceView{
    if (_priceView) {
        return _priceView;
    }
    self.priceView = [UILabel new];
    [self addSubview:self.priceView];
    
    return self.priceView;
}

- (UILabel *)price{
    if (_price) {
        return _price;
    }
    self.price = [UILabel new];
    self.price.font = KFont(PingFangSCMedium, 20.0);
    self.price.textColor = KHexColor(@"#FFFFFF");
    [self addSubview:self.price];
    
    return self.price;
}

- (UIImageView *)watchImg{
    if (_watchImg) {
        return _watchImg;
    }
    self.watchImg = [UIImageView new];
    self.watchImg.image = KImageMake(@"mall_pay_timer");
    [self addSubview:self.watchImg];
    
    return _watchImg;
}


- (NSTimer *)timer{
    if (_timer) {
        return _timer;
    }
    self.timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(startCountDown) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    
    return self.timer;
}

@end
