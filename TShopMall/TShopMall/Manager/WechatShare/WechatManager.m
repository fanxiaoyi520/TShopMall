//
//  WechatManager.m
//  push
//
//  Created by L灰灰Y on 2021/1/7.
//

// WechatManager.m
#import "WechatManager.h"
#import "TSAccountConst.h"

@interface WechatManager()<WXApiDelegate>

@end

@implementation WechatManager

+ (id)shareInstance {
    static WechatManager *weChatPayInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        weChatPayInstance = [[WechatManager alloc] init];
    });
    return weChatPayInstance;
}

+ (BOOL)handleOpenUrl:(NSURL *)url {
    return [WXApi handleOpenURL:url delegate:[WechatManager shareInstance]];
    
}

+ (void)hangleWechatPayWith:(PayReq *)req {
    [WXApi sendReq:req completion:^(BOOL success) {
        if (success) {
            NSLog(@"微信支付成功");
        } else {
             NSLog(@"微信支付异常");
        }
    }];
}

+ (void)hangleWechatAuthWith:(SendAuthReq *)req {
    [WXApi sendReq:req completion:^(BOOL success) {
        if (success) {
            NSLog(@"授权成功");
        } else {
             NSLog(@"授权异常");
        }
    }];
}

#pragma mark - 微信支付回调

- (void)onResp:(BaseResp *)resp {
    if ([resp isKindOfClass:[PayResp class]]) {
        /*
         enum  WXErrCode {
         WXSuccess           = 0,    < 成功
         WXErrCodeCommon     = -1,  < 普通错误类型
         WXErrCodeUserCancel = -2,   < 用户点击取消并返回
         WXErrCodeSentFail   = -3,   < 发送失败
         WXErrCodeAuthDeny   = -4,   < 授权失败
         WXErrCodeUnsupport  = -5,   < 微信不支持
         };
         */
        PayResp *response = (PayResp*)resp;
        switch (response.errCode) {
            case WXSuccess: {
                NSLog(@"微信回调支付成功");
                if (self.WXSuccess) {
                    self.WXSuccess();
                }
            break;
            }
            case WXErrCodeCommon: {
                NSLog(@"微信回调支付异常");
                [Popover popToastOnWindowWithText:@"微信回调支付异常"];
//                [TSToast showMessage:@"微信回调支付异常"];
                if (self.WXFail) {
                    self.WXFail();
                }
                break;
            }
            case WXErrCodeUserCancel: {
                NSLog(@"微信回调用户取消支付");
                [Popover popToastOnWindowWithText:@"微信回调用户取消支付"];

                if (self.WXFail) {
                    self.WXFail();
                }
                break;
            }
            case WXErrCodeSentFail: {
                NSLog(@"微信回调发送支付信息失败");
                [Popover popToastOnWindowWithText:@"微信回调发送支付信息失败"];

                if (self.WXFail) {
                    self.WXFail();
                }
                break;
            }
            case WXErrCodeAuthDeny: {
                NSLog(@"微信回调授权失败");
                [Popover popToastOnWindowWithText:@"微信回调授权失败"];

                if (self.WXFail) {
                    self.WXFail();
                }
                break;
            }
            case WXErrCodeUnsupport: {
                NSLog(@"微信回调微信版本暂不支持");
                [Popover popToastOnWindowWithText:@"微信回调微信版本暂不支持"];

                if (self.WXFail) {
                    self.WXFail();
                }
                break;
            }
            default: {
                break;
            }

        }
    }
    else if([resp isKindOfClass:SendAuthResp.class]){
        SendAuthResp *response = (SendAuthResp*)resp;
        switch (response.errCode) {
            case WXSuccess: {
                NSLog(@"用户同意");
                [self getAccessTokenWithCode:response.code];
//                if (self.WXSuccess) {
//                    self.WXSuccess();
//                }
            break;
            }
            case WXErrCodeAuthDeny: {
                NSLog(@"用户拒绝授权");
                [Popover popToastOnWindowWithText:@"用户拒绝授权"];
                if (self.WXFail) {
                    self.WXFail();
                }
                break;
            }
            case WXErrCodeUserCancel: {
                NSLog(@"微信回调用户取消");
                [Popover popToastOnWindowWithText:@"用户取消"];

                if (self.WXFail) {
                    self.WXFail();
                }
                break;
            }
            default: {
                break;
            }
    }
        
    }
}

- (void)selectWXpayWith:(NSDictionary *)dic{
    if (![WXApi isWXAppInstalled]) {
        [Popover popToastOnWindowWithText:@"请安装微信再进行支付~"];

        return;
    }
    NSMutableString *stamp  = [dic objectForKey:@"timeStamp"];
    PayReq *req = [[PayReq alloc] init];
    req.partnerId = dic[@"wxMchCode"];
    req.prepayId= dic[@"prepayId"];
    req.package = dic[@"packageValue"];
    req.nonceStr= dic[@"nonceStr"];
    req.timeStamp= stamp.intValue;;
    req.sign= dic[@"sign"];

    if (req.partnerId!=nil &&req.prepayId!=nil&&req.nonceStr!=nil&&req.package&&req.sign!=nil&&req.timeStamp!=0) {
        [WXApi sendReq:req completion:^(BOOL success) {
        }];

    }else {
        [Popover popToastOnWindowWithText:@"支付参数错误"];

    }
}
//检查支付宝支付状态
- (void)AlipayResultStatus:(NSDictionary *)resultDic{
//    9000    订单支付成功
//    8000    正在处理中，支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态
//    4000    订单支付失败
//    5000    重复请求
//    6001    用户中途取消
//    6002    网络连接出错
//    6004    支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态
    if ([resultDic[@"resultStatus"] isEqual:@"9000"] ) {
        NSLog(@"订单支付成功");
        if (self.WXSuccess) {
            self.WXSuccess();
        }
    }
    if ([resultDic[@"resultStatus"] isEqual:@"8000"] ) {
        NSLog(@"订单支付成功");
//        正在处理中，支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态
        if (self.WXSuccess) {
            self.WXSuccess();
        }
    }
    if ([resultDic[@"resultStatus"] isEqual:@"4000"] ) {
        NSLog(@"订单支付失败");
//        正在处理中，支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态
        if (self.WXFail) {
            self.WXFail();
        }
    }
    if ([resultDic[@"resultStatus"] isEqual:@"5000"] ) {
        NSLog(@"重复请求");
//        正在处理中，支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态
    }
    if ([resultDic[@"resultStatus"] isEqual:@"6001"] ) {
        NSLog(@"网络连接出错");
//        正在处理中，支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态
        if (self.WXFail) {
            self.WXFail();
        }
    }
    if ([resultDic[@"resultStatus"] isEqual:@"6002"] ) {
        NSLog(@"订单支付失败");
//        正在处理中，支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态
        if (self.WXFail) {
            self.WXFail();
        }
    }
    if ([resultDic[@"resultStatus"] isEqual:@"6004"] ) {
        NSLog(@"支付结果未知（有可能已经支付成功）");
//        正在处理中，支付结果未知（有可能已经支付成功），请查询商户订单列表中订单的支付状态
        if (self.WXSuccess) {
            self.WXSuccess();
        }
    }
}

- (void)getAccessTokenWithCode:(NSString *)code{
    NSString *urlStr = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code", WXAPPId, WXAPPSecret, code];
    NSString *newStr = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[[NSCharacterSet characterSetWithCharactersInString:@"?!@#$^&%*+,:;='\"`<>()[]{}/\\| "] invertedSet]];

    NSURL *url = [NSURL URLWithString:newStr];
    NSURLRequest *requst = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10];
//    [[NSURLSession sharedSession] dataTaskWithRequest:requst completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//
//    }];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *firsttask = [session dataTaskWithRequest:requst completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
    }];
    [firsttask resume];
}
@end
