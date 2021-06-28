//
//  WechatPayManager.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/28.
//

#import "WechatPayManager.h"
#import <WXApi.h>

@interface WechatPayManager()<WXApiDelegate>
@property (nonatomic, copy) void(^isPaySuccess)(BOOL);//是否支付完成
@end

@implementation WechatPayManager

static WechatPayManager *manager;
+ (instancetype)defaultWechatPayManager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[WechatPayManager alloc] init];
    });
    return manager;
}

+ (void)payWithParamas:(NSDictionary *)params paySuccess:(void (^)(BOOL))paySuccess{
    [WechatPayManager defaultWechatPayManager].isPaySuccess = paySuccess;
    if (![WXApi isWXAppInstalled]) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [Popover popToastOnWindowWithText:@"请安装微信再进行支付"];
        });
        return;
    }
    NSString *partnerId = params[@"partnerid"];
    NSString *prepayId = params[@"prepayid"];
    NSString *package = params[@"package"];
    NSString *nonceStr = params[@"noncestr"];
    NSString *timeStamp = params[@"timestamp"];
    NSString *sign = params[@"sign"];
    if (partnerId.length == 0 ||
        prepayId.length ==0 ||
        package.length ==0 ||
        nonceStr.length ==0 ||
        timeStamp.length ==0 ||
        sign.length == 0) {
        [Popover popToastOnWindowWithText:@"支付参数有误"];
        return;
    }
    
    PayReq *req = [[PayReq alloc] init];
    req.partnerId =partnerId;
    req.prepayId = prepayId;
    req.package = package;
    req.nonceStr = nonceStr;
    req.timeStamp = timeStamp.intValue;
    req.sign= sign;
    
    [WXApi sendReq:req completion:^(BOOL success) {
        
    }];
}

- (void)onResp:(BaseResp *)resp{
    if ([resp isKindOfClass:[PayResp class]]) {
        PayResp* response = (PayResp*)resp;
        switch (response.errCode) {
            case WXSuccess:
                self.isPaySuccess(YES);
                break;
            default:
                self.isPaySuccess(NO);
                break;
        }
    }
}

@end
