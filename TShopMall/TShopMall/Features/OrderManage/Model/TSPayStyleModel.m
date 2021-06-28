//
//  TSPayStyleModel.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/28.
//

#import "TSPayStyleModel.h"

@implementation TSPayStyleModel
- (NSString *)payChannel{
    if ([_channelName containsString:@"微信"]) {
        return @"wx_app";
    }
    if ([_channelName containsString:@"支付宝"]) {
        return @"alipay_app";
    }
    if ([_channelName containsString:@"TCL分期"]) {
        return @"tcl_purchase";
    }
    return @"";
}
@end

@implementation TSPayPurCharse

- (void)setRepayPlans:(NSArray<TSPayPurCharsePlan *> *)repayPlans{
    _repayPlans = [NSArray yy_modelArrayWithClass:TSPayPurCharsePlan.class json:repayPlans];
}
@end

@implementation TSPayPurCharsePlan


@end
