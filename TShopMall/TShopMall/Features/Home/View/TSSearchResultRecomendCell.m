//
//  TSSearchResultRecomendCell.m
//  TShopMall
//
//  Created by 橙子 on 2021/7/5.
//

#import "TSSearchResultRecomendCell.h"

@implementation TSSearchResultRecomendCell

- (void)setObj:(id)obj{
    [super setObj:obj];
    if ([obj isKindOfClass:[TSRecomendGoods class]]) {
        self.recomendView.vm = [[TSRecomendViewModel alloc] iniWithGoods:obj];
    }
}

- (void)layoutView{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = KRateW(8.0);
    self.layer.masksToBounds = YES;
    [self.recomendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
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


@implementation TSSearchResultRecomendWidthCell


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
