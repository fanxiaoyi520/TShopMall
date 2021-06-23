//
//  TSCartEmptyCell.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/10.
//

#import "TSCartEmptyCell.h"
#import "TSEmptyAlertView.h"

@interface TSCartEmptyCell()
@property (nonatomic, strong) TSEmptyAlertView *emptyView;
@end

@implementation TSCartEmptyCell


- (void)layoutSubviews{
    self.backgroundColor = UIColor.clearColor;
    self.emptyView.hidden = NO;
}

- (TSEmptyAlertView *)emptyView{
    if (_emptyView) {
        return _emptyView;
    }
    self.emptyView = TSEmptyAlertView.new.alertBackColor(KHexColor(@"#F4F4F5")).alertInfo(@"购物车是空的", @"去购物").show(self.contentView, @"center", ^{
        [self.delegate goToShopping];
    });
    
    return self.emptyView;
}

@end
