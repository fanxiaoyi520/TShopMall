//
//  TSPayDataController.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/28.
//

#import "TSBaseDataController.h"


@interface TSPayDataController : TSBaseDataController
@property (nonatomic, copy) NSString *orderId;
@property (nonatomic, copy) NSString *payChannel;


@property (nonatomic, strong) NSDictionary *extra;
///唤起三方支付需要的参数
@property (nonatomic, strong) NSDictionary *awakeAppInfo;

- (void)goToPay:(void(^)(BOOL))isSuccess;

- (void)mockPay:(void(^)(BOOL))finished;
@end


/*
 "html_form" = "{\"package\":\"Sign=WXPay\",\"appid\":\"wxe658f160c3cc3d7c\",\"sign\":\"379A33BC6337645D71A714120B9A3175\",\"partnerid\":\"1235041202\",\"prepayid\":\"wx28150524614456f344076db90e449e0000\",\"noncestr\":\"1624863924684\",\"timestamp\":\"1624863924\"}";
 */
