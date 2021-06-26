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
#import "TSCustomPageControl.h"
@interface TSHomePageBannerCell()<SDCycleScrollViewDelegate>
@property(nonatomic, strong) SDCycleScrollView *cycleScrollView;
@property (nonatomic, strong) TSCustomPageControl *pageControl;

@end

@implementation TSHomePageBannerCell
-(void)setupUI{
    
    [super setupUI];
    
    [self.contentView addSubview:self.cycleScrollView];
    [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.right.equalTo(self.contentView).offset(-16);
        make.top.equalTo(self.contentView).offset(11);
        make.bottom.equalTo(self.contentView).offset(-12);
        make.height.equalTo(@174).priorityLow();;
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
            [self updatePageControl];
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
        _cycleScrollView.clipsToBounds = YES;
        _cycleScrollView.layer.cornerRadius = 6;
    }
    return _cycleScrollView;
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    TSHomePageBannerViewModel *bannerViewModel = (TSHomePageBannerViewModel *)self.viewModel;
    [[TSServicesManager sharedInstance].uriHandler openURI:bannerViewModel.bannerDatas[index].uri];
    NSLog(@"uri:%@",bannerViewModel.bannerDatas[index].uri);
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    self.pageControl.currentPage = index;
}

#pragma mark - private methods
- (void)updatePageControl
{
    TSHomePageBannerViewModel *bannerViewModel = (TSHomePageBannerViewModel *)self.viewModel;
    NSInteger numberOfPages = bannerViewModel.bannerDatas.count;
    if (numberOfPages > 1) {
        if (!self.pageControl) {
            self.pageControl = [TSCustomPageControl new];
            self.pageControl.alignment = UIControlContentHorizontalAlignmentRight;
            [self.cycleScrollView addSubview:self.pageControl];
            
        }
        [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@10.f);
            make.bottom.equalTo(self.cycleScrollView).offset(-5);
            make.right.left.equalTo(self.cycleScrollView).offset(-10);
        }];
        
       
        self.pageControl.hidden = NO;
        self.pageControl.numberOfPages = numberOfPages;
    }
    else {
      
        self.pageControl.hidden = YES;

    }
}


@end
