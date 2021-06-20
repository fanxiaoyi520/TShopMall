//
//  TSHomePageBannerCell.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/8.
//

#import "TSHomePageBannerCell.h"
#import <SDCycleScrollView.h>
#import "TSHomePageBannerViewModel.h"
#import "TSImageBaseModel.h"
@interface TSHomePageBannerCell()<SDCycleScrollViewDelegate>
@property(nonatomic, strong) SDCycleScrollView *cycleScrollView;

@end

@implementation TSHomePageBannerCell
-(void)setupUI{
    
    [super setupUI];
    
    [self.contentView addSubview:self.cycleScrollView];
    [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.right.equalTo(self.contentView).offset(-16);
        make.top.equalTo(self.contentView).offset(16);
        make.bottom.equalTo(self.contentView).offset(-12);
        make.height.equalTo(@174);
    }];
  
}

- (void)setViewModel:(TSHomePageCellViewModel *)viewModel{
    [super setViewModel:viewModel];
    TSHomePageBannerViewModel *bannerViewModel = (TSHomePageBannerViewModel *)viewModel;
    if (!bannerViewModel.bannerDatas.count) {
        [bannerViewModel getBannerData];
    }
    @weakify(self);
    [self.KVOController observe:bannerViewModel keyPath:@"bannerDatas" options:(NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew) block:^(id  _Nullable observer, id  _Nonnull object, NSDictionary<NSString *,id> * _Nonnull change) {
        @strongify(self)
        if (bannerViewModel.bannerDatas) {
            NSMutableArray *tempArr = @[].mutableCopy;
            for (TSImageBaseModel *model in bannerViewModel.bannerDatas) {
                [tempArr addObject:model.imageData.url];
            }
            self.cycleScrollView.imageURLStringsGroup = tempArr;
        }
    }];
    
}

#pragma mark - Getter
-(SDCycleScrollView *)cycleScrollView{
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:nil];
        _cycleScrollView.showPageControl = NO;
        _cycleScrollView.autoScroll  = YES;
        _cycleScrollView.autoScrollTimeInterval = 4;
//        _cycleScrollView.backgroundColor = KGrayColor;
        _cycleScrollView.clipsToBounds = YES;
        _cycleScrollView.layer.cornerRadius = 6;
    }
    return _cycleScrollView;
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    TSHomePageBannerViewModel *bannerViewModel = (TSHomePageBannerViewModel *)self.viewModel;

    NSLog(@"uri:%@",bannerViewModel.bannerDatas[index].linkData.objectValue);

}



@end
