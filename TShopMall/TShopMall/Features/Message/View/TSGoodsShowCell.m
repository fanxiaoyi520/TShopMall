//
//  TSGoodsShowCell.m
//  TShopMall
//
//  Created by edy on 2021/6/21.
//

#import "TSGoodsShowCell.h"
#import "TSHotSectionModel.h"

@interface TSGoodsShowCell ()
/// 背景视图
@property(nonatomic, weak) UIImageView *bgImageView;
/** 底部  */
@property(nonatomic, weak) UIImageView *rankBottomImgV;
@property(nonatomic, weak) UIImageView *championImgV;
@property(nonatomic, weak) UIImageView *championIconImgV;
@property(nonatomic, weak) UIImageView *rightImgV;
@property(nonatomic, weak) UIImageView *rightIconImgV;
@property(nonatomic, weak) UIImageView *leftImgV;
@property(nonatomic, weak) UIImageView *leftIconImgV;
/** title显示  */
@property (nonatomic, weak) UIImageView * champion_title_bg;
@property (nonatomic, weak) UILabel * champion_title;

@end

@implementation TSGoodsShowCell

- (void)fillCustomContentView {
    [super fillCustomContentView];
    self.contentView.backgroundColor = KWhiteColor;
    ///添加约束
    [self addConstraints];
}

- (void)addConstraints {
    [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.left.offset(-1);
        make.right.offset(1);
        make.height.mas_equalTo(KRateW(250));
    }];
    [self.rankBottomImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(0);
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        make.bottom.equalTo(self.contentView).offset(-KRateW(10));
        make.height.mas_equalTo(KRateW(65));
    }];
    
    [self.championImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_centerX).with.offset(0);
        make.bottom.equalTo(self.champion_title_bg.mas_top).with.offset(KRateW(10));
        make.width.mas_equalTo(KRateW(154));
        make.height.mas_equalTo(KRateW(64));
    }];
    [self.championIconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.championImgV.mas_centerX).with.offset(0);
        make.bottom.equalTo(self.championImgV.mas_top).offset(KRateW(10));
        make.width.mas_equalTo(KRateW(154));
        make.height.mas_equalTo(KRateW(88));
    }];
    
    [self.rightImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).with.offset(-KRateW(43));
        make.bottom.equalTo(self.championIconImgV);
        make.width.mas_equalTo(KRateW(98));
        make.height.mas_equalTo(KRateW(41));
    }];
    [self.rightIconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.rightImgV.mas_centerX).with.offset(0);
        make.bottom.equalTo(self.rightImgV.mas_top).with.offset(KRateW(10));
        make.width.mas_equalTo(KRateW(98));
        make.height.mas_equalTo(KRateW(66));
    }];
    
    [self.leftImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(KRateW(40));
        make.centerY.equalTo(self.rightImgV.mas_centerY).with.offset(0);
        make.width.mas_equalTo(KRateW(98));
        make.height.mas_equalTo(KRateW(41));
    }];
    [self.leftIconImgV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.leftImgV.mas_centerX).with.offset(0);
        make.bottom.equalTo(self.leftImgV.mas_top).with.offset(KRateW(10));
        make.width.mas_equalTo(KRateW(98));
        make.height.mas_equalTo(KRateW(66));
    }];
    
    [self.champion_title_bg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.bottom.equalTo(self.bgImageView).offset(-KRateW(45));
        make.width.mas_equalTo(KRateW(195));
        make.height.mas_equalTo(KRateW(32));
    }];
    
    [self.champion_title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.champion_title_bg).mas_equalTo(UIEdgeInsetsMake(0, 20, 0, 20));
    }];
}

#pragma mark - Getter
- (UIImageView *)bgImageView{
    if (_bgImageView == nil) {
        UIImageView *bgImageView = [[UIImageView alloc] init];
        _bgImageView = bgImageView;
        _bgImageView.image = KImageMake(@"mall_rank_hotgoodsbg");
        [self.contentView insertSubview:_bgImageView atIndex:0];
    }
    return _bgImageView;
}

- (UIImageView *)rankBottomImgV {
    if (_rankBottomImgV == nil) {
        UIImageView *rankBottomImgV = [[UIImageView alloc] init];
        _rankBottomImgV = rankBottomImgV;
        _rankBottomImgV.image = KImageMake(@"mall_rank_bottom");
        [self.contentView addSubview: _rankBottomImgV];
    }
    return _rankBottomImgV;
}

- (UIImageView *)championImgV {
    if (_championImgV == nil) {
        UIImageView *championImgV = [[UIImageView alloc] init];
        _championImgV = championImgV;
        _championImgV.image = KImageMake(@"mall_rank_hotbest");
        _championImgV.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview: _championImgV];
    }
    return _championImgV;
}

- (UIImageView *)championIconImgV {
    if (_championIconImgV == nil) {
        UIImageView *championIconImgV = [[UIImageView alloc] init];
        _championIconImgV = championIconImgV;
        _championIconImgV.image = KImageMake(@"image_test");
        _championIconImgV.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView insertSubview:_championIconImgV aboveSubview:self.championImgV];
    }
    return _championIconImgV;
}

- (UIImageView *)rightImgV {
    if (_rightImgV == nil) {
        UIImageView *rightImgV = [[UIImageView alloc] init];
        _rightImgV = rightImgV;
        _rightImgV.image = KImageMake(@"mall_rank_hotright");
        _rightImgV.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView insertSubview:_rightImgV belowSubview:self.championImgV];
    }
    return _rightImgV;
}

- (UIImageView *)rightIconImgV {
    if (_rightIconImgV == nil) {
        UIImageView *rightIconImgV = [[UIImageView alloc] init];
        _rightIconImgV = rightIconImgV;
        _rightIconImgV.image = KImageMake(@"image_test");
        _rightIconImgV.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView insertSubview:_rightIconImgV aboveSubview:self.rightImgV];
    }
    return _rightIconImgV;
}

- (UIImageView *)leftImgV {
    if (_leftImgV == nil) {
        UIImageView *leftImgV = [[UIImageView alloc] init];
        _leftImgV = leftImgV;
        _leftImgV.image = KImageMake(@"mall_rank_hotleft");
        _leftImgV.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView insertSubview:_leftImgV belowSubview:self.championImgV];
    }
    return _leftImgV;
}

- (UIImageView *)leftIconImgV {
    if (_leftIconImgV == nil) {
        UIImageView *leftIconImgV = [[UIImageView alloc] init];
        _leftIconImgV = leftIconImgV;
        _leftIconImgV.image = KImageMake(@"image_test");
        _leftIconImgV.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView insertSubview:_leftIconImgV aboveSubview:self.leftImgV];
    }
    return _leftIconImgV;
}

- (UIImageView *)champion_title_bg {
    if (_champion_title_bg == nil) {
        UIImageView *champion_title_bg = [[UIImageView alloc] init];
        champion_title_bg = [[UIImageView alloc] initWithImage:KImageMake(@"mall_rank_titlebg")];
        _champion_title_bg = champion_title_bg;
        [self.contentView addSubview: _champion_title_bg];
    }
    return _champion_title_bg;
}

- (UILabel *)champion_title {
    if (_champion_title == nil) {
        UILabel *label = [UILabel new];
        _champion_title = label;
        _champion_title.font = KRegularFont(14);
        _champion_title.textColor = KWhiteColor;
        _champion_title.text = @"等待上榜";
        [self.champion_title_bg addSubview: _champion_title];
    }
    return _champion_title;
}

- (void)setDelegate:(id<UniversalCollectionViewCellDataDelegate>)delegate {
    TSHotSectionItemModel *item = [delegate universalCollectionViewCellModel:self.indexPath];
    
    self.championIconImgV.image = KImageMake(@"image_test");
    self.leftIconImgV.image = KImageMake(@"image_test");
    self.rightIconImgV.image = KImageMake(@"image_test");
    self.champion_title.text = @"等待上榜";
    
    //冠军
    if (item.rankList.count > 0) {
        TSRecomendGoods *goodModel = item.rankList[0];
        [self.championIconImgV sd_setImageWithURL:[NSURL URLWithString:goodModel.imageUrl] placeholderImage:KImageMake(@"image_test")];
        self.champion_title.text = goodModel.name;
        
        //亚军
        if (item.rankList.count > 1) {
            TSRecomendGoods *goodModel = item.rankList[1];
            [self.leftIconImgV sd_setImageWithURL:[NSURL URLWithString:goodModel.imageUrl] placeholderImage:KImageMake(@"image_test")];
            
            //季军
            if (item.rankList.count > 2) {
                TSRecomendGoods *goodModel = item.rankList[1];
                [self.rightIconImgV sd_setImageWithURL:[NSURL URLWithString:goodModel.imageUrl] placeholderImage:KImageMake(@"image_test")];
            }
        }
    }
}


@end
