//
//  AddressPickerIndexView.m
//  TCLPlus
//
//  Created by kobe on 2020/10/30.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import <objc/runtime.h>

#import "AddressPickerIndexView.h"

#import "AppDelegate.h"
#import "MineConst.h"

#import "UIColor+Plugin.h"
#define kItemH 20


@interface UIWindow (AddressPickerIndexView)

@property (nonatomic, strong, nullable) UIView *indicatorView;

@end

static const char *AddressPickerIndexViewKey = "AddressPickerIndexViewKey";


@implementation UIWindow (AddressPickerIndexView)

- (void)setIndicatorView:(UIView *)indicatorView {
    objc_setAssociatedObject(self, AddressPickerIndexViewKey, indicatorView, OBJC_ASSOCIATION_RETAIN);
}

- (UIView *)indicatorView {
    return objc_getAssociatedObject(self, AddressPickerIndexViewKey);
}

@end


@interface AddressPickerIndexView ()

@property (nonatomic, strong, nullable) NSMutableArray *itemArrs;
@property (nonatomic, strong, nullable) UIView *containerView;
@property (nonatomic, strong, nullable) UIImageView *indicatorView;
@property (nonatomic, strong, nullable) UILabel *indicatorLab;
@property (nonatomic, assign) NSInteger lastSelectedIndex;
@property (nonatomic, assign) BOOL touching;

@end


@implementation AddressPickerIndexView


- (UIView *)containerView {
    if (!_containerView) {
        _containerView = [UIView new];
        _containerView.backgroundColor = [UIColor colorWithHexString:@"#2D3132" alpha:0.1];
        _containerView.layer.masksToBounds = YES;
        _containerView.layer.cornerRadius = 8.0f;
    }
    return _containerView;
}


- (UIImageView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [UIImageView new];
        _indicatorView.image = [UIImage imageNamed:@"addressIndicator"];
        _indicatorView.frame = CGRectMake(0, 0, 60, 50);
    }
    return _indicatorView;
}

- (UILabel *)indicatorLab {
    if (!_indicatorLab) {
        _indicatorLab = [UILabel new];
        _indicatorLab.frame = CGRectMake(0, 0, 50, 50);
        _indicatorLab.textAlignment = NSTextAlignmentCenter;
        _indicatorLab.textColor = [UIColor colorWithHexString:@"#FFFFFF"];
    }
    return _indicatorLab;
}


- (NSMutableArray *)itemArrs {
    if (!_itemArrs) {
        _itemArrs = [NSMutableArray array];
    }
    return _itemArrs;
}


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.indicatorView addSubview:self.indicatorLab];
        [self addSubview:self.containerView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _containerView.frame = CGRectMake(self.frame.size.width - 32, 0, 16, self.frame.size.height);
}


- (void)layoutItem:(NSArray *)items {
    CGFloat originX = 0;
    CGFloat originY = 0;
    CGFloat wdith = 16;
    CGFloat height = 20;
    [_itemArrs removeAllObjects];
    for (NSInteger i = 0; i < items.count; i++) {
        UILabel *item = [UILabel new];
        item.frame = CGRectMake(originX, originY + i * height, wdith, height);
        item.backgroundColor = [UIColor clearColor];
        item.textColor = [UIColor colorWithHexString:@"#333333" alpha:0.6];
        item.textAlignment = NSTextAlignmentCenter;
        item.font = [UIFont systemFontOfSize:8];
        item.text = items[i];
        item.tag = i;
        item.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(itemTapGesture:)];
        [item addGestureRecognizer:tap];
        [self.itemArrs addObject:item];
        [self.containerView addSubview:item];
    }
}

- (void)itemTapGesture:(UITapGestureRecognizer *)gesture {
    [self resetAllItemStatus];
    UILabel *lab = (UILabel *)gesture.view;
    lab.textColor = defaultTextColor;
    if (self.indexBlock) {
        self.indexBlock(lab.tag);
    }
}

- (void)resetAllItemStatus {
    for (UILabel *lab in _itemArrs) {
        lab.textColor = [UIColor colorWithHexString:@"#333333" alpha:0.6];
    }
}


- (void)setDataSource:(NSArray *)dataSource {
    _dataSource = dataSource;
    for (UIView *view in _containerView.subviews) {
        [view removeFromSuperview];
    }
    [self layoutItem:dataSource];
}


#pragma mark - Touch Event
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _touching = YES;
    [self handleTouches:touches];
    [self showIndicator];
}


- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _touching = YES;
    [self handleTouches:touches];
    [self showIndicator];
}


- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _touching = NO;
    [self updateSelectedIndex:_lastSelectedIndex];
    [self dismissIndicator];
}


- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _touching = NO;
    [self updateSelectedIndex:_lastSelectedIndex];
    [self dismissIndicator];
}


#pragma mark - 处理触摸滑动事件
- (void)handleTouches:(NSSet<UITouch *> *)touches {
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    NSInteger selectedIndex = touchPoint.y / 20;
    if (selectedIndex >= 0 && selectedIndex < _itemArrs.count) {
        [self resetAllItemStatus];
        self.lastSelectedIndex = selectedIndex;
        UILabel *lab = _itemArrs[selectedIndex];
        lab.textColor = defaultTextColor;
        //        __weak typeof(self) weakSelf = self;
        if (self.delegate && [self.delegate respondsToSelector:@selector(addressPickerIndexView:didSelectedIndex:completion:)]) {
            [self.delegate addressPickerIndexView:self didSelectedIndex:selectedIndex completion:^(NSInteger lastSelectedIndex){
                //                                weakSelf.lastSelectedIndex = lastSelectedIndex;
            }];
        }
    }
}


- (void)updateSelectedIndex:(NSInteger)index {
    if (_touching) return;
    if (index >= 0 && index < _itemArrs.count) {
        [self resetAllItemStatus];
        UILabel *lab = _itemArrs[index];
        lab.textColor = defaultTextColor;
    }
}


#pragma mark - 字母指示器
- (void)showIndicator {
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    if (!window.indicatorView) {
        [window addSubview:self.indicatorView];
        _indicatorView.alpha = 0.0;
        [UIView animateWithDuration:0.25 animations:^{
            self.indicatorView.alpha = 1.0;
        }];
        window.indicatorView = _indicatorView;
    }
    UILabel *lab = _itemArrs[self.lastSelectedIndex];
    _indicatorLab.text = lab.text;
    CGRect rect = [self convertRect:lab.frame toView:window];
    CGFloat w = CGRectGetWidth(_indicatorView.frame);
    CGFloat h = CGRectGetHeight(_indicatorView.frame);
    _indicatorView.frame = CGRectMake(CGRectGetMinX(rect) - w - 10, CGRectGetMidY(rect) - h / 2, w, h);
}

- (void)dismissIndicator {
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    if (window.indicatorView == nil) return;
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self.indicatorView removeFromSuperview];
        window.indicatorView = nil;
    }];
}

@end
