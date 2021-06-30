//
//  TSPaySuccessRecomendCell.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/28.
//

#import "TSPaySuccessRecomendCell.h"
#import "TSRecomendSlimView.h"

@interface TSPaySuccessRecomendCell()
@property (nonatomic, strong) TSRecomendSlimView *aView;
@end

@implementation TSPaySuccessRecomendCell

- (void)setObj:(id)obj{
    [super setObj:obj];
    if ([obj isKindOfClass:[TSRecomendGoods class]]) {
        self.aView.vm = [[TSRecomendViewModel alloc] iniWithGoods:obj];
    }
}

- (void)recomendViewTapped{
    [self.theDelegate recomendGoodsTapped:self.aView.vm.uuid];
}

- (void)layoutSubviews{
    [self.aView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (TSRecomendSlimView *)aView{
    if (_aView) {
        return _aView;
    }
    self.aView = [TSRecomendSlimView new];
    [self.contentView addSubview:self.aView];
    
    return self.aView;
}

@end
