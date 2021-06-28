//
//  TSCustomPageControl.m
//  cmsmobilesecurities
//
//  Created by 蒲公英 on 2019/9/16.
//  Copyright © 2019 cms. All rights reserved.
//

#import "TSCustomPageControl.h"
#import "UIView+Extension.h"

@interface TSCustomPageControl()

@property (nonatomic, strong) UIColor *currentColor;
@property (nonatomic, strong) UIColor *inactiveColor;
@property (nonatomic, assign) CGSize currentSize;
@property (nonatomic, assign) CGSize inactiveSize;
@property (nonatomic, copy) NSArray<UIView *> *dotViews;

@end

@implementation TSCustomPageControl

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.inactiveColor = KHexAlphaColor(@"ffffff", .5);
        self.inactiveSize = CGSizeMake(18, 2);
        self.currentColor = KWhiteColor;
        self.currentSize = CGSizeMake(18, 2);
    }
    return self;
}

- (instancetype)init {
    return [self initWithFrame:CGRectZero];
}

- (void)setCurrentPage:(NSInteger)currentPage {
    if (_currentPage != currentPage) {
        _currentPage = currentPage;
        [self updateDots];
    }
}

- (void)layoutSubviews
{
//    [super layoutSubviews];
    
    for (UIView *dotView in self.dotViews) {
        [dotView removeFromSuperview];
    }
    CGFloat dotSpacing = 5.f;
    
//    CGFloat originCenterX = (int)((self.width - totalWidth) / 2);
    
    UIView *container = [UIView new];
    [self addSubview:container];
    CGFloat totalWidth = (self.numberOfPages - 1) * dotSpacing + self.numberOfPages * self.currentSize.width;

    if (self.alignment == UIControlContentHorizontalAlignmentCenter) {
        [container mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.height.equalTo(self);
            make.bottom.equalTo(self);
            make.width.equalTo(@(totalWidth));
        }];
    }
    else if (self.alignment == UIControlContentHorizontalAlignmentLeft){
        [container mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self);
            make.height.equalTo(self);
            make.bottom.top.equalTo(self);
            make.width.equalTo(@(totalWidth));
        }];
    }
    else if (self.alignment == UIControlContentHorizontalAlignmentRight){
        [container mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self);
            make.height.equalTo(self);
            make.bottom.top.equalTo(self);
            make.width.equalTo(@(totalWidth));
        }];
    }
    
    NSMutableArray<UIView *> *dotViews = @[].mutableCopy;
    for (int pageIndex = 0; pageIndex < self.numberOfPages; pageIndex++) {
        UIView *dotView = [[UIView alloc] initWithFrame:CGRectMake(pageIndex * (dotSpacing + self.currentSize.width), self.height/2, self.currentSize.width, self.currentSize.height)];
        [container addSubview:dotView];
        [dotViews addObject:dotView];
    }
    
    self.dotViews = dotViews;
    [self updateDots];
}

- (void)setNumberOfPages:(NSInteger)numberOfPages
{
    if (numberOfPages != _numberOfPages) {
        _numberOfPages = numberOfPages;
        [self setNeedsLayout];
        [self layoutIfNeeded];
    }
}

- (void)updateDots {
    for (NSInteger i = 0; i < [self.subviews count]; i++) {
        UIView *dotView = self.dotViews[i];
//        CGPoint center = dotView.center;
        if (i == self.currentPage){
            dotView.backgroundColor = self.currentColor;
//            dotView.size = self.currentSize;
        }else{
            dotView.backgroundColor = self.inactiveColor;
//            dotView.size = self.inactiveSize;
        }
//        dotView.center = center;
    }
}

@end


