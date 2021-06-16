//
//  TSMineNavigationBar.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/15.
//

#import "TSMineNavigationBar.h"

@interface TSMineNavigationBar()

@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIButton *setButton;

@end

@implementation TSMineNavigationBar

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self fillCustomView];
    }
    return self;
}

-(void)fillCustomView{
    
}

#pragma mark - Getter
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
    }
    return _titleLabel;
}

@end
