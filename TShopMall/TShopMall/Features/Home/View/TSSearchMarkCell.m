//
//  TSSearchMarkCell.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/12.
//

#import "TSSearchMarkCell.h"
#import "TSSearchKeyViewModel.h"

@interface TSSearchMarkCell ()
@property (nonatomic, strong) UILabel *markLabel;
@end

@implementation TSSearchMarkCell

- (void)setObj:(id)obj{
    [super setObj:obj];
    if ([obj isKindOfClass:[TSSearchKeyViewModel class]]) {
        TSSearchKeyViewModel *vm = (TSSearchKeyViewModel *)obj;
        self.markLabel.text = vm.keywords;
    }
}

- (void)layoutView{
    self.layer.cornerRadius = KRateW(12.0);
    self.layer.masksToBounds = YES;
    self.contentView.backgroundColor = KHexColor(@"#F4F4F5");
    
    [self.markLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(KRateW(10.0));
        make.right.equalTo(self.contentView.mas_right).offset(-KRateW(10.0));
        make.top.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(KRateW(24.0));
    }];
}

- (UILabel *)markLabel{
    if (_markLabel) {
        return _markLabel;
    }
    self.markLabel = [UILabel new];
    self.markLabel.font = KRegularFont(12.0);
    self.markLabel.textColor = KHexColor(@"#2D3132");
    self.markLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.markLabel];
    
    return self.markLabel;;
}

@end
