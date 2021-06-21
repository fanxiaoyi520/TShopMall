//
//  RefreshGifFooter.m
//  TCLPlus
//
//  Created by kobe on 2020/10/21.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import "RefreshGifFooter.h"
#import "NSString+Time.h"
#import "MineConst.h"

@interface RefreshGifFooter ()

@property (nonatomic, strong, nullable) UILabel *tipLab;
@property (nonatomic, strong, nullable) CAShapeLayer *layer1;
@property (nonatomic, strong, nullable) CAShapeLayer *layer2;
/** 所有状态对应的文字 */
@property (strong, nonatomic, nullable) NSMutableDictionary *stateTitles;

@end


@implementation RefreshGifFooter

- (UILabel *)tipLab {
    if (!_tipLab) {
        _tipLab = [UILabel new];
        _tipLab.textColor = defaultTextColor4;
        _tipLab.font = defaultTextFont14;
        _tipLab.textAlignment = NSTextAlignmentCenter;
    }
    return _tipLab;
}


- (CAShapeLayer *)layer1 {
    if (!_layer1) {
        _layer1 = [CAShapeLayer layer];
    }
    return _layer1;
}

- (CAShapeLayer *)layer2 {
    if (!_layer2) {
        _layer2 = [CAShapeLayer layer];
    }
    return _layer2;
}


- (NSMutableDictionary *)stateTitles {
    if (!_stateTitles) {
        self.stateTitles = [NSMutableDictionary dictionary];
    }
    return _stateTitles;
}

#pragma mark - 实现父类方法
- (void)prepare {
    [super prepare];

    // 设置控件的高度
    self.mj_h = 50;
    [self addSubview:self.tipLab];
    [self.layer addSublayer:self.layer1];
    [self.layer addSublayer:self.layer2];

    // 普通闲置状态
    [self setTitle:@"上拉加载更多" forState:MJRefreshStateIdle];
    // 松开就可以进行刷新的状态
    [self setTitle:@"松开立即加载" forState:MJRefreshStatePulling];
    // 正在刷新中的状态
    [self setTitle:@"加载中" forState:MJRefreshStateRefreshing];
    // 即将刷新的状
    [self setTitle:@"准备加载" forState:MJRefreshStateWillRefresh];
    // 所有数据加载完毕，没有更多的数据了
    [self setTitle:@"已加载全部" forState:MJRefreshStateNoMoreData];
}

- (void)placeSubviews {
    [super placeSubviews];
    [self updateUI];
}


- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    [super scrollViewContentOffsetDidChange:change];
}

- (void)scrollViewContentSizeDidChange:(NSDictionary *)change {
    [super scrollViewContentSizeDidChange:change];
}

- (void)scrollViewPanStateDidChange:(NSDictionary *)change {
    [super scrollViewPanStateDidChange:change];
}


- (void)setState:(MJRefreshState)state {
    MJRefreshCheckState;
    if (self.isRefreshingTitleHidden && state == MJRefreshStateRefreshing) {
        _tipLab.text = nil;
    } else {
        _tipLab.text = self.stateTitles[@(state)];
    }
}


- (void)updateUI {
    if (_tipLab.text.length == 0) {
        _tipLab.text = @"";
    }
    NSAttributedString *attr = [[NSAttributedString alloc] initWithString:_tipLab.text attributes:@{NSFontAttributeName: defaultTextFont14}];
    CGFloat w = [NSString caculatorTextSize:attr maxWdith:200].width;
    _tipLab.frame = CGRectMake(self.mj_w / 2 - w / 2 - 5, self.mj_h / 2 - 15, w + 10, 30);

    UIBezierPath *path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint:CGPointMake(_tipLab.mj_x - 60, self.mj_h / 2)];
    [path1 addLineToPoint:CGPointMake(_tipLab.mj_x - 60 + 50, self.mj_h / 2)];
    _layer1.lineWidth = 0.33;
    _layer1.strokeColor = defaultTextColor4.CGColor;
    _layer1.path = path1.CGPath;

    UIBezierPath *path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint:CGPointMake(_tipLab.mj_x + _tipLab.mj_w + 10, self.mj_h / 2)];
    [path2 addLineToPoint:CGPointMake(_tipLab.mj_x + _tipLab.mj_w + 50 + 10, self.mj_h / 2)];
    _layer2.lineWidth = 0.33;
    _layer2.strokeColor = defaultTextColor4.CGColor;
    _layer2.path = path2.CGPath;
}


- (void)setTitle:(NSString *)title forState:(MJRefreshState)state {
    if (title == nil) return;
    self.stateTitles[@(state)] = title;
    _tipLab.text = self.stateTitles[@(self.state)];
}

@end
