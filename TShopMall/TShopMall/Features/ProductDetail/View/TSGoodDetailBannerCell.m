//
//  TSGoodDetailBannerCell.m
//  TSale
//
//  Created by 陈洁 on 2021/1/9.
//  Copyright © 2021 TCL. All rights reserved.
//

#import "TSGoodDetailBannerCell.h"
#import "TSGoodDetailSectionModel.h"
#import <SDCycleScrollView.h>

@interface TSGoodDetailBannerCell()<SDCycleScrollViewDelegate>

@property(nonatomic, strong) SDCycleScrollView *cycleScrollView;
/// 图片对应的展示
@property (nonatomic, strong) UILabel *numImgeLable;

@end

@implementation TSGoodDetailBannerCell

-(void)fillCustomContentView{
    [super fillCustomContentView];
    
    self.contentView.backgroundColor = KGrayColor;
    
    [self.contentView addSubview:self.cycleScrollView];
    [self.contentView addSubview:self.numImgeLable];
    
    [self.cycleScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.top.equalTo(self.contentView);
    }];
    
    [self.numImgeLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-16);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-16);
        make.size.mas_equalTo(CGSizeMake(40, 20));
    }];
}


#pragma mark - Private
- (NSMutableAttributedString *)attributeWithString:(NSString *)string
                                             color:(UIColor *)color
                                             fonts:(NSArray <UIFont *> *)fonts{

    NSArray <NSString *> *strs = [string componentsSeparatedByString:@"/"];
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:string];
    
    NSString *large = [strs firstObject];
    
    [attStr addAttributes:@{
        NSForegroundColorAttributeName: color,
        NSFontAttributeName: fonts[0]
    } range:NSMakeRange(0, large.length)];
    
    [attStr addAttributes:@{
        NSForegroundColorAttributeName: color,
        NSFontAttributeName: fonts[1]
    } range:NSMakeRange(large.length, string.length - large.length)];

    return attStr;
}

#pragma mark - SDCycleScrollViewDelegate
-(void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    NSString *testStr = [NSString stringWithFormat:@"%zd/%zd",index + 1,cycleScrollView.imageURLStringsGroup.count];
    self.numImgeLable.attributedText = [self attributeWithString:testStr color:KWhiteColor fonts:@[
        KFont(PingFangSCSemibold, 12.0),
        KFont(PingFangSCRegular, 8.0)
    ]];
}

#pragma mark - Getter
-(SDCycleScrollView *)cycleScrollView{
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:nil];
        _cycleScrollView.showPageControl = NO;
        _cycleScrollView.autoScroll  = NO;
        _cycleScrollView.titleLabelBackgroundColor = [UIColor redColor];
        _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleAspectFill;
        _cycleScrollView.backgroundColor = KGrayColor;
    }
    return _cycleScrollView;
}
-(UILabel *)numImgeLable{
    if (!_numImgeLable) {
        _numImgeLable = [UILabel new];
        _numImgeLable.backgroundColor  = [[UIColor blackColor] colorWithAlphaComponent:0.4];
        _numImgeLable.layer.cornerRadius =  10;
        _numImgeLable.layer.masksToBounds = YES;
        _numImgeLable.textAlignment = NSTextAlignmentCenter;
    }
    return _numImgeLable;
}

-(void)setDelegate:(id<UniversalCollectionViewCellDataDelegate>)delegate{
    if ([delegate respondsToSelector:@selector(universalCollectionViewCellModel:)]) {
        TSGoodDetailItemBannerModel *item = [delegate universalCollectionViewCellModel:self.indexPath];
        self.cycleScrollView.imageURLStringsGroup = item.urls;
        NSString *badgeStr = @"";
        if (item.urls.count > 0) {
            badgeStr =  [NSString stringWithFormat:@"1/%zd",self.cycleScrollView.imageURLStringsGroup.count];
        } else {
            badgeStr =  [NSString stringWithFormat:@"0/0"];
        }
        self.numImgeLable.attributedText = [self attributeWithString:badgeStr color:KWhiteColor fonts:@[
            KFont(PingFangSCSemibold, 12.0),
            KFont(PingFangSCRegular, 8.0)
        ]];
    }
}

@end
