//
//  TSMineOrderCountModel.h
//  TShopMall
//
//  Created by 林伟 on 2021/6/30.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSMineOrderCountModel : NSObject
@property (nonatomic ,copy) NSString *shipping; //待收货
@property (nonatomic ,copy) NSString *waitcomment; //待评价
@property (nonatomic ,copy) NSString *waitpay; //待付款
@property (nonatomic ,copy) NSString *waitship; // 待发货
@property (nonatomic ,copy) NSString *afterorder; //退款/退货
@property (nonatomic ,copy) NSString *succeedorder; //已完成
@property (nonatomic ,copy) NSString *totalorder; //全部订单
@end

NS_ASSUME_NONNULL_END
