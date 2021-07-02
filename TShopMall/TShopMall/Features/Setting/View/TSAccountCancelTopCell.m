//
//  TSAccountCancellCell.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/15.
//

#import "TSAccountCancelTopCell.h"
#import "TSAccountCancelSectionModel.h"
#import "TSTools.h"
#import "NSTimer+TSBlcokTimer.h"

@interface TSAccountCancelTopCell ()
/** logo */
@property(nonatomic, weak) UIImageView *warningImgV;
/** 时间倒计时视图 */
@property(nonatomic, weak) UIButton *showTimeButton;
/** 显示昵称 */
@property(nonatomic, weak) UILabel *nickNameLabel;
/** 页面注销的标题 */
@property(nonatomic, weak) UILabel *titleLabel;
/** 定时器  */
@property(nonatomic, strong) NSTimer *timer;
/** 倒计时的时间  */
@property(nonatomic, assign) NSTimeInterval interval;

@end

@implementation TSAccountCancelTopCell

- (void)fillCustomContentView {
    [super fillCustomContentView];
    ///添加约束
    [self addConstraints];
}

- (void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)addConstraints {
    [self.warningImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX).with.offset(0);
        make.top.equalTo(self.contentView.mas_top).with.offset(48);
        make.width.mas_equalTo(49);
        make.height.mas_equalTo(48);
    }];
    [self.showTimeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX).with.offset(0);
        make.top.equalTo(self.warningImgV.mas_bottom).with.offset(16);
        make.width.mas_equalTo(168);
        make.height.mas_equalTo(25);
    }];
    [self.nickNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX).with.offset(0);
        make.top.equalTo(self.showTimeButton.mas_bottom).with.offset(8);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX).with.offset(0);
        make.top.equalTo(self.nickNameLabel.mas_bottom).with.offset(0);
    }];
}

- (UIImageView *)warningImgV {
    if (_warningImgV == nil) {
        UIImageView *warningImgV = [[UIImageView alloc] init];
        _warningImgV = warningImgV;
        _warningImgV.image = KImageMake(@"mall_setting_warning");
        [self.contentView addSubview:_warningImgV];
    }
    return _warningImgV;
}

- (UIButton *)showTimeButton {
    if (_showTimeButton == nil) {
        UIButton *showTimeButton = [[UIButton alloc] init];
        _showTimeButton = showTimeButton;
        _showTimeButton.layer.cornerRadius = 25.0/2.0;
        _showTimeButton.titleLabel.font = KRegularFont(12);
        [_showTimeButton setTitleColor:KWhiteColor forState:UIControlStateNormal];
        _showTimeButton.backgroundColor = KHexAlphaColor(@"#E74C3D", 0.2);
        //_showTimeButton.hidden = YES;
        [self.contentView addSubview:_showTimeButton];
    }
    return _showTimeButton;
}

- (UILabel *)nickNameLabel {
    if (_nickNameLabel == nil) {
        UILabel *nickNameLabel = [[UILabel alloc] init];
        _nickNameLabel = nickNameLabel;
        _nickNameLabel.textColor = KTextColor;
        _nickNameLabel.font = [UIFont font:PingFangSCMedium size:18];
        _nickNameLabel.hidden = YES;
        [self.contentView addSubview:_nickNameLabel];
    }
    return _nickNameLabel;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        _titleLabel = titleLabel;
        _titleLabel.textColor = KTextColor;
        _titleLabel.font = [UIFont font:PingFangSCMedium size:18];
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (void)setDelegate:(id<UniversalCollectionViewCellDataDelegate>)delegate {
    TSAccountCancelSectionItemModel *item = [delegate universalCollectionViewCellModel:self.indexPath];
    self.titleLabel.text = item.title;
    if (item.nickname.length) {
        self.nickNameLabel.hidden = NO;
        self.nickNameLabel.text = [NSString stringWithFormat:@"昵称: %@", item.nickname];
    } else {
        [self.nickNameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }
    if (item.cancelTime.length) {
        self.showTimeButton.hidden = NO;
    } else if (item.dropTime.length) {
        self.showTimeButton.hidden = NO;
        [self startTimer:item.dropTime];
    } else {
        self.showTimeButton.hidden = YES;
        [self.showTimeButton mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
    }
}

- (void)startTimer:(NSString *)time {
    NSTimeInterval timeInterval = [TSTools timeIntervalWithDate:time];
    if (timeInterval < 0) {
        [self.showTimeButton setTitle:@"账户已注销，无法取消" forState:(UIControlStateNormal)];
        return;
    }
    self.interval = timeInterval;
    @weakify(self);
    self.timer = [NSTimer ts_scheduledTimerWithTimeInterval:1 block:^{
        @strongify(self);
        self.interval--;
        if (self.interval < 0) {
            [self.timer invalidate];
            self.timer = nil;
            [self.showTimeButton setTitle:@"账户已注销，无法取消" forState:(UIControlStateNormal)];
            return;
        }
        NSString *timeString = [TSTools getRestTimeWithTimeInterval:self.interval];
        [self.showTimeButton setTitle:timeString forState:(UIControlStateNormal)];
        
    } repeats:YES];
}

@end
