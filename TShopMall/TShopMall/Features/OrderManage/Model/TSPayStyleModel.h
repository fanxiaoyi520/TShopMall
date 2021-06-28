//
//  TSPayStyleModel.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/28.
//

#import <Foundation/Foundation.h>

@class TSPayPurCharse;
@class TSPayPurCharsePlan;

@interface TSPayStyleModel : NSObject
@property (nonatomic, copy) NSString *channelName;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *payTypeId;
@property (nonatomic, strong) TSPayPurCharse *purCharse;
@property (nonatomic, assign) BOOL status;

@property (nonatomic, copy) NSString *payChannel;
@end

@interface TSPayPurCharse : NSObject
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, assign) NSInteger disCountNo;
@property (nonatomic, strong) NSArray<TSPayPurCharsePlan *> *repayPlans;
@end

@interface TSPayPurCharsePlan : NSObject
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *freePeriodsDesc;
@property (nonatomic, copy) NSString *interestAmt;
@property (nonatomic, copy) NSString *interestMoney;
@property (nonatomic, copy) NSString *purchaseDesc;
@property (nonatomic, copy) NSString *rate;
@property (nonatomic, copy) NSString *rateDesc;
@property (nonatomic, copy) NSString *term;
@end
/*
 {
     code = 200;
     data =     {
         payChannelList =         (
                         {
                 channelName = "\U652f\U4ed8\U5b9d";
                 icon = "http://f0.testpc.tclo2o.cn/Fir20byKNwELiwUjhUmUAyP9DwHS";
                 payTypeId = "alipay_app";
                 purCharse = "<null>";
                 status = 1;
             },
                         {
                 channelName = "\U5fae\U4fe1";
                 icon = "http://f0.testpc.tclo2o.cn/Fir20byKNwELiwUjhUmUAyP9DwHS";
                 payTypeId = "wx_app";
                 purCharse = "<null>";
                 status = 1;
             },
                         {
                 channelName = "TCL\U5206\U671f";
                 icon = "http://f0.testpc.tclo2o.cn/Fir20byKNwELiwUjhUmUAyP9DwHS";
                 payTypeId = "tcl_purchase";
                 purCharse =                 {
                     desc = "6\U671f\U514d\U606f";
                     disCountNo = 6;
                     repayPlans =                     (
                                                 {
                             desc = "\U514d\U606f\Uff0c\U6bcf\U671f\U4f4e\U81f32666.67\U5143";
                             freePeriodsDesc = "";
                             interestAmt = 80;
                             interestMoney = "80.00";
                             principalAmt = "2666.67";
                             principalMoney = "2666.67";
                             purchaseDesc = "2666.67\U5143 \U00d7 3\U671f";
                             rate = "0.00%";
                             rateDesc = "\U514d\U606f, 0\U624b\U7eed\U8d39";
                             term = 3;
                         },
                                                 {
                             desc = "\U514d\U606f\Uff0c\U6bcf\U671f\U4f4e\U81f31333.33\U5143";
                             freePeriodsDesc = "";
                             interestAmt = 70;
                             interestMoney = "70.00";
                             principalAmt = "1333.33";
                             principalMoney = "1333.33";
                             purchaseDesc = "1333.33\U5143 \U00d7 6\U671f";
                             rate = "0.00%";
                             rateDesc = "\U514d\U606f, 0\U624b\U7eed\U8d39";
                             term = 6;
                         },
                                                 {
                             desc = "\U4eab6\U671f\U514d\U606f\Uff0c\U6bcf\U671f\U4f4e\U81f3955.56\U5143";
                             freePeriodsDesc = "\U524d6\U671f\U514d\U606f";
                             interestAmt = "66.67";
                             interestMoney = "66.67";
                             principalAmt = "888.89";
                             principalMoney = "888.89";
                             purchaseDesc = "888.89\U5143 \U00d7 9\U671f";
                             rate = "4.41%";
                             rateDesc = "\U540e3\U671f\U53e6\U4ed8\U624b\U7eed\U8d3966.67\U5143/\U671f\Uff0c\U624b\U7eed\U8d39\U73874.41%/\U5e74";
                             term = 9;
                         },
                                                 {
                             desc = "\U4eab6\U671f\U514d\U606f\Uff0c\U6bcf\U671f\U4f4e\U81f3731.67\U5143";
                             freePeriodsDesc = "\U524d6\U671f\U514d\U606f";
                             interestAmt = 65;
                             interestMoney = "65.00";
                             principalAmt = "666.67";
                             principalMoney = "666.67";
                             purchaseDesc = "666.67\U5143 \U00d7 12\U671f";
                             rate = "8.69%";
                             rateDesc = "\U540e6\U671f\U53e6\U4ed8\U624b\U7eed\U8d3965.00\U5143/\U671f\Uff0c\U624b\U7eed\U8d39\U73878.69%/\U5e74";
                             term = 12;
                         }
                     );
                 };
                 status = 1;
             }
         );
     };
     loginUser = "<null>";
     message = "\U6210\U529f";
     transId = 356ec93fff9d40fda488e37f66d09018;
     type = "<null>";
     userId = "<null>";
 }
 */

