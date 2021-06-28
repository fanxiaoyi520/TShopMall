//
//  TSSearchRecomendCell.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/13.
//

#import "TSSearchRecomendCell.h"

@implementation TSSearchRecomendCell

- (void)setObj:(id)obj{
    [super setObj:obj];
    if ([obj isKindOfClass:[TSRecomendGoods class]]) {
        self.recomendView.vm = [[TSRecomendViewModel alloc] iniWithGoods:obj];
    }
}

- (void)layoutView{
    self.backgroundColor = [UIColor clearColor];
    [self.recomendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
        make.width.mas_equalTo(kScreenWidth - KRateW(32.0));
        make.height.mas_equalTo(KRateW(120.0));
    }];
}

- (TSRecomendWidthView *)recomendView{
    if (_recomendView) {
        return _recomendView;
    }
    self.recomendView = [TSRecomendWidthView new];
    [self.contentView addSubview:self.recomendView];
    
    return self.recomendView;
}

@end

@implementation TSSearchRecomendSlimCell

- (void)setObj:(id)obj{
    [super setObj:obj];
    if ([obj isKindOfClass:[TSRecomendGoods class]]) {
        self.recomendView.vm = [[TSRecomendViewModel alloc] iniWithGoods:obj];
    }
}

- (void)layoutView{
    self.backgroundColor = [UIColor whiteColor];
    [self.recomendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
        make.width.mas_equalTo((kScreenWidth - KRateW(48.0))/2.0);
        make.height.mas_equalTo(KRateW(290.0));
    }];
}

- (TSRecomendSlimView *)recomendView{
    if (_recomendView) {
        return _recomendView;
    }
    self.recomendView = [TSRecomendSlimView new];
    [self.contentView addSubview:self.recomendView];
    
    return self.recomendView;
}

@end
