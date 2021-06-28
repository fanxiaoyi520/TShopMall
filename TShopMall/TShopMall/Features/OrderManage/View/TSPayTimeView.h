//
//  TSPayTimeView.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/28.
//

#import <UIKit/UIKit.h>


@interface TSPayTimeView : UIImageView
- (void)updateOrederPriec:(NSString *)price;
- (void)orderCurrentTime:(NSTimeInterval)currentTime endTime:(NSTimeInterval)endTime;

///支付时间结束
@property (nonatomic, copy) void(^payTimeEnd)(void);
@end

