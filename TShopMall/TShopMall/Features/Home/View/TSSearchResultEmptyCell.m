//
//  TSSearchResultEmptyCell.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/23.
//

#import "TSSearchResultEmptyCell.h"
#import "TSEmptyAlertView.h"

@interface TSSearchResultEmptyCell()
@property (nonatomic, strong) TSEmptyAlertView *alertView;
@end

@implementation TSSearchResultEmptyCell

- (void)layoutSubviews{
    self.backgroundColor = UIColor.clearColor;
    self.alertView.hidden = NO;
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
