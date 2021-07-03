//
//  TSCategoryBannerCell.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/10.
//

#import "TSCategoryBannerCell.h"
#import <SDCycleScrollView.h>
#import "TSCategoryContentModel.h"

@interface TSCategoryBannerCell()<SDCycleScrollViewDelegate>

@property(nonatomic, strong) SDCycleScrollView *cycleScrollView;

@end

@implementation TSCategoryBannerCell

-(void)setupUI{
    self.contentView.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:self.cycleScrollView];
    [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(16);
        make.right.equalTo(self.contentView).offset(-16);
        make.top.equalTo(self.contentView).offset(16);
        make.bottom.equalTo(self.contentView).offset(-16);
        make.height.equalTo(@144);
    }];
}

- (void)setData:(id)data{
    [super setData:data];
    TSCategoryContentModel *model = (TSCategoryContentModel *)data;
    self.cycleScrollView.imageURLStringsGroup = @[model.OneLevelImg];
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    TSCategoryContentModel *model = (TSCategoryContentModel *)self.data;
    NSString *uri = [[TSServicesManager sharedInstance].uriHandler configUriWithTypeValue:model.typeValue objectValue:model.objectValue];
    [[TSServicesManager sharedInstance].uriHandler openURI:uri];
    NSLog(@"uri:%@",uri);
}

#pragma mark - Getter
-(SDCycleScrollView *)cycleScrollView{
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:nil];
        _cycleScrollView.showPageControl = NO;
        _cycleScrollView.autoScroll  = NO;
        _cycleScrollView.autoScrollTimeInterval = 3;
        _cycleScrollView.backgroundColor = [UIColor clearColor];
        _cycleScrollView.localizationImageNamesGroup = @[@"home_banner_placeImage"];
        _cycleScrollView.layer.cornerRadius = 8;
        _cycleScrollView.clipsToBounds = YES;
    }
    return _cycleScrollView;
}

//-(void)setDelegate:(id<UniversalCollectionViewCellDataDelegate>)delegate{
//    TSCategorySectionBannerItemModel *item = [delegate universalCollectionViewCellModel:self.indexPath];
//    self.cycleScrollView.imageURLStringsGroup = item.imgUrls;
//}


@end
