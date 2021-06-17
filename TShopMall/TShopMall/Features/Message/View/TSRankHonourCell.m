//
//  TSRankHonourCell.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/17.
//

#import "TSRankHonourCell.h"

@interface TSRankHonourCell()

/// 背景视图
@property(nonatomic, strong) UIImageView *bgImageView;
/// 信息背景
@property(nonatomic, strong) UIImageView *rankImageView;

@end

@implementation TSRankHonourCell

-(void)fillCustomContentView{
    
    self.contentView.backgroundColor = UIColor.orangeColor;
    
//    [self.contentView addSubview:self.bgImageView];
//    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self);
//    }];
}

#pragma mark - Getter
-(UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc] init];
        _bgImageView.backgroundColor = [UIColor redColor];
    }
    return _bgImageView;
}

@end
