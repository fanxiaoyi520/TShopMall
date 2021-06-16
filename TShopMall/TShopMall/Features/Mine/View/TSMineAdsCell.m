//
//  TSMineAdsCell.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/11.
//

#import "TSMineAdsCell.h"

@interface TSMineAdsCell()

@property(nonatomic, strong) UIImageView *adsImageView;

@end

@implementation TSMineAdsCell

-(void)fillCustomContentView{
    [super fillCustomContentView];
    
    [self.contentView addSubview:self.adsImageView];
    [self.adsImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

#pragma mark - Getter
-(UIImageView *)adsImageView{
    if (!_adsImageView) {
        _adsImageView = [[UIImageView alloc] init];
        _adsImageView.backgroundColor = KWhiteColor;
        _adsImageView.layer.cornerRadius = 8;
        _adsImageView.clipsToBounds = YES;
    }
    return _adsImageView;
}

@end
