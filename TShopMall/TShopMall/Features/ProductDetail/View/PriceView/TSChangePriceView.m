//
//  TSChangePriceView.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/22.
//

#import "TSChangePriceView.h"

@interface TSChangePriceView()

/// 关闭按钮
@property(nonatomic, strong) UIButton *closeButton;

@end

@implementation TSChangePriceView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupViews];
    }
    return self;
}

-(void)setupViews{

}

#pragma mark - Actions
-(void)closeAction:(UIButton *)sender{
    
}


@end
