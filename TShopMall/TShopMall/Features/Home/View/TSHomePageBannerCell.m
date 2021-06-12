//
//  TSHomePageBannerCell.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/8.
//

#import "TSHomePageBannerCell.h"
#import <SDCycleScrollView.h>
#import "TSHomePageBannerViewModel.h"

@interface TSHomePageBannerCell()<SDCycleScrollViewDelegate>
@property(nonatomic, strong) SDCycleScrollView *cycleScrollView;
@end

@implementation TSHomePageBannerCell
-(void)setupUI{
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.cycleScrollView];
    [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.right.equalTo(self.contentView).offset(-16);
        make.top.equalTo(self.contentView).offset(10);
        make.bottom.equalTo(self.contentView).offset(-10);
        make.height.equalTo(@174);
    }];
    
}

- (void)setViewModel:(TSHomePageCellViewModel *)viewModel{
    [(TSHomePageBannerViewModel *)viewModel getBannerData];
    __weak typeof(self) weakSelf = self;
    [self.KVOController observe:viewModel keyPath:@"bannerDatas" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionInitial block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
          NSArray *data = change[@"new"];
          if (data.count > 0) {
              weakSelf.datas  = data;
          }
      }];
}

- (void)setDatas:(NSArray<TSHomePageBaseModel *> *)datas{
    [super setDatas:datas];
    NSMutableArray *tempArr = @[].mutableCopy;
    for (TSHomePageBaseModel *model in datas) {
        [tempArr addObject:model.imageUrl];
    }
    
    _cycleScrollView.localizationImageNamesGroup = tempArr;

}

#pragma mark - Getter
-(SDCycleScrollView *)cycleScrollView{
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:nil];
        _cycleScrollView.showPageControl = NO;
        _cycleScrollView.autoScroll  = NO;
        _cycleScrollView.autoScrollTimeInterval = 4;
        _cycleScrollView.backgroundColor = [UIColor clearColor];
    }
    return _cycleScrollView;
}

#pragma mark - SDCycleScrollViewDelegate
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{

}

@end
