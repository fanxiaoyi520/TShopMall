//
//  TSMakeOrderEmptyCell.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/25.
//

#import "TSMakeOrderEmptyCell.h"
#import "TSEmptyAlertView.h"

@interface TSMakeOrderEmptyCell()
@property (nonatomic, strong) TSEmptyAlertView *emptyView;
@end

@implementation TSMakeOrderEmptyCell

- (void)layoutSubviews{
    self.backgroundColor = UIColor.clearColor;
    self.emptyView.hidden = NO;
}

- (TSEmptyAlertView *)emptyView{
    if (_emptyView) {
        return _emptyView;
    }
    self.emptyView = TSEmptyAlertView.new.alertBackColor(KHexColor(@"#F4F4F5")).alertInfo(@"无网络", @"").alertImage(@"alert_net_error").show(self.contentView, @"center", nil);
    
    return self.emptyView;
}


@end
