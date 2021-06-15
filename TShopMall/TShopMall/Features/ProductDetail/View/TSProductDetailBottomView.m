//
//  TSProductDetailBottomView.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/15.
//

#import "TSProductDetailBottomView.h"
#import "TSDetailFunctionButton.h"

@interface TSProductDetailBottomView()

@property(nonatomic, strong) UIView *contentView;

/// 商城
@property(nonatomic, strong) TSDetailFunctionButton *mallButton;
/// 客服
@property(nonatomic, strong) TSDetailFunctionButton *customButton;
/// 加入购物车
@property(nonatomic, strong) TSDetailFunctionButton *addButton;

@end

@implementation TSProductDetailBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self fillCustomView];
    }
    return self;
}

-(void)fillCustomView{
    [self addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(54);
    }];
}

#pragma mark - Getter
-(UIView *)contentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor orangeColor];
    }
    return _contentView;
}

@end
