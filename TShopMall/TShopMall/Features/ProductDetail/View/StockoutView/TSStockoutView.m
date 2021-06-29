//
//  TSStockoutView.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/29.
//

#import "TSStockoutView.h"

@interface TSStockoutView()

@property(nonatomic, strong) UILabel *promptLabel;

@end

@implementation TSStockoutView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        
        [self addSubview:self.promptLabel];
        [self.promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
    }
    return self;
}


#pragma mark - Getter
-(UILabel *)promptLabel{
    if (!_promptLabel) {
        _promptLabel = [[UILabel alloc] init];
        _promptLabel.font = KRegularFont(14);
        _promptLabel.textColor = KWhiteColor;
        _promptLabel.text = @"缺货";
    }
    return _promptLabel;
}

@end
