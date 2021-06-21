//
//  RefreshGifHeader.m
//  TCLPlus
//
//  Created by kobe on 2020/10/21.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import <Lottie/Lottie.h>

#import "RefreshGifHeader.h"


@interface RefreshGifHeader ()

@property (nonatomic, strong, nullable) LOTAnimationView *animationView;

@end


@implementation RefreshGifHeader

static CGRect animationViewBounds = {0, 0, 40, 40};

- (LOTAnimationView *)animationView {
    if (!_animationView) {
        _animationView = [LOTAnimationView animationNamed:@"PulldownRefreshStyleRed"];
        _animationView.contentMode = UIViewContentModeScaleAspectFit;
        _animationView.loopAnimation = YES;
    }
    return _animationView;
}


#pragma mark - 实现父类方法

- (void)prepare {
    [super prepare];
    [self addSubview:self.animationView];
}

- (void)placeSubviews {
    [super placeSubviews];
    _animationView.center = CGPointMake(self.mj_w / 2.0, (self.mj_h - _loadingOffsetTop) / 2.0 + _loadingOffsetTop);
    _animationView.bounds = animationViewBounds;
}


- (void)setPullingPercent:(CGFloat)pullingPercent {
    [super setPullingPercent:pullingPercent];
    if (pullingPercent < 1.0) {
        _animationView.animationProgress = pullingPercent;
    }
}


- (void)setState:(MJRefreshState)state {
    MJRefreshCheckState;
    switch (state) {
        case MJRefreshStateIdle:
            break;
        case MJRefreshStatePulling:
            [_animationView play];
            break;
        case MJRefreshStateWillRefresh:
            break;
        case MJRefreshStateRefreshing:
            [_animationView play];
            break;
        case MJRefreshStateNoMoreData:
            break;
        default:
            break;
    }
}

- (void)endRefreshing {
    [super endRefreshing];
}


- (void)setIndicatorStyle:(IndicatorStyle)indicatorStyle {
    _indicatorStyle = indicatorStyle;
    switch (indicatorStyle) {
        case IndicatorStyleWhite:
            [_animationView stop];
            [_animationView setAnimationNamed:@"PulldownRefreshStyleWhite"];
            _animationView.loopAnimation = YES;
            break;
        case IndicatorStyleBlack:
            [_animationView stop];
            [_animationView setAnimationNamed:@"PulldownRefreshStyleBlack"];
            _animationView.loopAnimation = YES;
            break;
        case IndicatorStyleRed:
            [_animationView stop];
            [_animationView setAnimationNamed:@"PulldownRefreshStyleRed"];
            _animationView.loopAnimation = YES;
        default:
            break;
    }
}

- (void)setLoadingOffsetTop:(CGFloat)loadingOffsetTop {
    _loadingOffsetTop = loadingOffsetTop;
    // 设置高度
    self.mj_h = MJRefreshHeaderHeight + _loadingOffsetTop;
}

@end
