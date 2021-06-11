//
//  TSCategoryBannerCell.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/10.
//

#import "TSCategoryBannerCell.h"
#import <SDCycleScrollView.h>

@interface TSCategoryBannerCell()<SDCycleScrollViewDelegate>

@property(nonatomic, strong) SDCycleScrollView *cycleScrollView;

@end

@implementation TSCategoryBannerCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self fillCustomView];
    }
    return self;
}

-(void)fillCustomView{
    self.contentView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.cycleScrollView];
    [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self).offset(-16);
        make.top.bottom.equalTo(self);
    }];
}

#pragma mark - Getter
-(SDCycleScrollView *)cycleScrollView{
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:nil];
        _cycleScrollView.showPageControl = NO;
        _cycleScrollView.autoScroll  = NO;
        _cycleScrollView.autoScrollTimeInterval = 4;
        _cycleScrollView.backgroundColor = [UIColor clearColor];
        _cycleScrollView.localizationImageNamesGroup = @[@"home_banner_placeImage"];
    }
    return _cycleScrollView;
}

#pragma mark - SDCycleScrollViewDelegate
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{

}

@end
