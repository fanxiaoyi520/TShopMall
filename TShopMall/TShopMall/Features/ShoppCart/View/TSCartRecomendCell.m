//
//  TSCartRecomendCell.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/25.
//

#import "TSCartRecomendCell.h"

@implementation TSCartRecomendCell

- (void)setObj:(id)obj{
    if ([obj isKindOfClass:[TSRecomendGoods class]]) {
        self.recomendView.vm = [[TSRecomendViewModel alloc] iniWithGoods:obj];
    }
}

- (void)layoutSubviews{
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


@implementation TSCartRecomendGirdCell

- (void)setObj:(id)obj{
    self.backgroundColor = UIColor.clearColor;
    if ([obj isKindOfClass:[NSArray class]]) {
        TSRecomendViewModel *leftVM = [[TSRecomendViewModel alloc] iniWithGoods:obj[0]];
        self.leftRecomendView.vm = leftVM;
        if ([obj count] >= 2) {
            TSRecomendViewModel *rightVM = [[TSRecomendViewModel alloc] iniWithGoods:[obj lastObject]];
            self.rightRecomendView.vm = rightVM;
        }
    }
}

- (void)recomendGoodsTappedAction:(UITapGestureRecognizer *)tapGes{
    UIView *view = tapGes.view;
    TSRecomendViewModel *vm = nil;
    if (view == self.leftRecomendView) {
        vm = self.leftRecomendView.vm;
    } else {
        vm = self.rightRecomendView.vm;
    }
    [self.delegate recomendGoodsSelected:vm.uuid];
}

- (void)layoutSubviews{
    [self.leftRecomendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(KRateW(16.0));
        make.top.equalTo(self.contentView.mas_top);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-KRateW(8.0));
    }];
    
    [self.rightRecomendView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-KRateW(16.0));
        make.top.bottom.equalTo(self.leftRecomendView);
        make.left.equalTo(self.leftRecomendView.mas_right).offset(KRateW(8.0));
        make.width.mas_equalTo(self.leftRecomendView.mas_width);
    }];
}

- (TSRecomendSlimView *)leftRecomendView{
    if (_leftRecomendView) {
        return _leftRecomendView;
    }
    self.leftRecomendView = [TSRecomendSlimView new];
    [self.contentView addSubview:self.leftRecomendView];
    
    self.leftRecomendView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(recomendGoodsTappedAction:)];
    tapGes.numberOfTapsRequired = 1;
    [self.leftRecomendView addGestureRecognizer:tapGes];
    
    return self.leftRecomendView;
}

- (TSRecomendSlimView *)rightRecomendView{
    if (_rightRecomendView) {
        return _rightRecomendView;
    }
    self.rightRecomendView = [TSRecomendSlimView new];
    [self.contentView addSubview:self.rightRecomendView];
    
    self.rightRecomendView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(recomendGoodsTappedAction:)];
    tapGes.numberOfTapsRequired = 1;
    [self.rightRecomendView addGestureRecognizer:tapGes];
    
    return self.rightRecomendView;
}
@end
