//
//  TSSearchEmptyCell.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/25.
//

#import "TSSearchEmptyCell.h"
#import "TSEmptyAlertView.h"

@interface TSSearchEmptyCell()
@property (nonatomic, strong) TSEmptyAlertView *alertView;
@end
@implementation TSSearchEmptyCell



- (void)layoutView{
    self.backgroundColor = UIColor.clearColor;
    [self.alertView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.width.mas_equalTo(kScreenWidth - KRateW(32.0));
        make.height.mas_equalTo(KRateW(382.0));
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-KRateW(10.0));
    }];
}

- (TSEmptyAlertView *)alertView{
    if (_alertView) {
        return _alertView;
    }
  self.alertView =  TSEmptyAlertView.new.alertBackColor(UIColor.clearColor).alertInfo(@"未搜索到结果，看看下方的精彩推荐", @"").show(self.contentView, @"center", ^{
        
    });
    
    return self.alertView;
}
@end
