//
//  TSBalanceModel.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/24.
//

#import <Foundation/Foundation.h>
#import "TSAddressModel.h"

@class TSBalanceCartManager;
@class TSBalanceCartManagerDetailModel;
@class TSBalanceAttrValue;
@class TSBalanceIntegralNow;

@interface TSBalanceModel : NSObject
@property (nonatomic, strong) NSArray<TSAddressModel *> *addressList;
@property (nonatomic, copy) NSString *allAffix;
@property (nonatomic, copy) NSString *canUseInteger;
@property (nonatomic, strong) TSBalanceCartManager *cartManager;
@property (nonatomic, copy) NSString *checkedAddress;
@property (nonatomic, copy) NSString *checkedInvoiceUuid;
@property (nonatomic, copy) NSString *cityId;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *empty;
@property (nonatomic, copy) NSString *integral;//用户积分
@property (nonatomic, strong) TSBalanceIntegralNow *integralToNowModel;//积分活动
@property (nonatomic, copy) NSString *isEmpty;
@property (nonatomic, copy) NSString *leaderFlag;
@property (nonatomic, copy) NSString *limitPromotionUuid;//秒杀活动uuid
@property (nonatomic, copy) NSString *loginUser;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *orderTotalIntegral;
@property (nonatomic, copy) NSString *orderTotalMoney;
@property (nonatomic, copy) NSString *provinceId;
@property (nonatomic, copy) NSString *real_total_num;
@property (nonatomic, copy) NSString *reginonId;
@property (nonatomic, copy) NSString *shareToken;
@property (nonatomic, copy) NSString *splitError;
@property (nonatomic, strong) NSDictionary *stockMap;
@property (nonatomic, copy) NSString *streetId;
@property (nonatomic, copy) NSString *suitCanReductMoney;
@property (nonatomic, copy) NSString *totalmoney;
@property (nonatomic, copy) NSString *transId;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *useMaxIntegral;//可以使用的最大积分数
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *willUuid;

@end

@interface TSBalanceCartManager : NSObject
@property (nonatomic, copy) NSString *affix;
@property (nonatomic, copy) NSString *cardUuid;
@property (nonatomic, copy) NSArray<NSString *> *cardUuidSet;
@property (nonatomic, copy) NSString *chooseCod;
@property (nonatomic, strong) id couponList;
@property (nonatomic, copy) NSString *couponReduceMoney;
@property (nonatomic, strong) id couponTypeGiftList;
@property (nonatomic, copy) NSString *crmOrderId;
@property (nonatomic, copy) NSString *customerUuid;
@property (nonatomic, assign) BOOL delFlag;
@property (nonatomic, strong) NSArray<TSBalanceCartManagerDetailModel *> *detailModelList;
@property (nonatomic, copy) NSString *firstPay;
@property (nonatomic, copy) NSString *invoiceCate;
@property (nonatomic, copy) NSString *invoiceContent;
@property (nonatomic, copy) NSString *invoiceType;
@property (nonatomic, copy) NSString *invoiceUuid;
@property (nonatomic, copy) NSString *lastPay;
@property (nonatomic, copy) NSString *lastPayTime;
@property (nonatomic, copy) NSString *nowCouponId;
@property (nonatomic, copy) NSString *nowPromotion;
@property (nonatomic, copy) NSString *opeTime;
@property (nonatomic, copy) NSString *oper;
@property (nonatomic, copy) NSString *orderInvoiceContent;
@property (nonatomic, copy) NSString *orderInvoiceTitle;
@property (nonatomic, copy) NSString *orderInvoiceType;
@property (nonatomic, copy) NSString *orderType;
@property (nonatomic, copy) NSString *pageReduceMoney;
@property (nonatomic, assign) NSInteger payType;
@property (nonatomic, copy) NSString *payTypeBackCode;
@property (nonatomic, copy) NSString *payTypeId;
@property (nonatomic, copy) NSString *pickUpTime;
@property (nonatomic, copy) NSString *platformUuid;
@property (nonatomic, strong) id productGiftLists;
@property (nonatomic, strong) NSArray *promotionsList;
@property (nonatomic, copy) NSString *pusm;
@property (nonatomic, copy) NSString *reduceMoney;
@property (nonatomic, copy) NSString *returnMoneyPayType;
@property (nonatomic, copy) NSString *shareToken;
@property (nonatomic, copy) NSString *shipType;
@property (nonatomic, copy) NSString *stationUuid;
@property (nonatomic, copy) NSString *storeName;
@property (nonatomic, copy) NSString *storeNote;
@property (nonatomic, copy) NSString *storePromotionsList;
@property (nonatomic, copy) NSString *storeTotalMoney;
@property (nonatomic, copy) NSString *storeUuid;
@property (nonatomic, copy) NSString *supportCod;
@property (nonatomic, copy) NSString *supportPickUp;
@property (nonatomic, copy) NSString *tenantId;
@property (nonatomic, copy) NSString *totalIntegral;
@property (nonatomic, copy) NSString *totalMoney;
@property (nonatomic, strong) id unCouponList;
@property (nonatomic, copy) NSString *uuid;

@end

@interface TSBalanceCartManagerDetailModel : NSObject
@property (nonatomic, copy) NSString *activityUuid;
@property (nonatomic, copy) NSString *affixation;
@property (nonatomic, copy) NSString *attrAndValue;
@property (nonatomic, strong) NSArray<TSBalanceAttrValue *> *attrValues;
@property (nonatomic, copy) NSString *basePrice;
@property (nonatomic, assign) NSInteger buyNum;
@property (nonatomic, copy) NSString *cardUuid;
@property (nonatomic, copy) NSString *carriageTemplateName;
@property (nonatomic, copy) NSString *carriageTemplateUuid;
@property (nonatomic, copy) NSString *cartManagerUuid;
@property (nonatomic, assign) BOOL checked;
@property (nonatomic, assign) BOOL delFlag;
@property (nonatomic, copy) NSString *distributorUuid;
@property (nonatomic, copy) NSString *friendPrice;
@property (nonatomic, copy) NSString *integral;
@property (nonatomic, copy) NSString *integralWarning;
@property (nonatomic, strong) id isSuitMain;
@property (nonatomic, copy) NSString *modelType;
@property (nonatomic, copy) NSString *nowPrice;
@property (nonatomic, copy) NSString *nowPromotion;
@property (nonatomic, copy) NSString *opeTime;
@property (nonatomic, copy) NSString *oper;
@property (nonatomic, copy) NSString *parentSkuNo;
@property (nonatomic, assign) NSInteger position;
@property (nonatomic, copy) NSString *productGiftIds;
@property (nonatomic, strong) id productGiftLists;
@property (nonatomic, copy) NSString *productImg;
@property (nonatomic, copy) NSString *productImgUrl;
@property (nonatomic, copy) NSString *productName;
@property (nonatomic, copy) NSString *productUuid;
@property (nonatomic, copy) NSString *productWarning;
@property (nonatomic, copy) NSString *promotionName;
@property (nonatomic, copy) NSString *promotionTag;
@property (nonatomic, copy) NSString *promotionTagId;
@property (nonatomic, copy) NSString *promotionType;
@property (nonatomic, strong) id protectionList;
@property (nonatomic, copy) NSString *recommender;
@property (nonatomic, copy) NSString *sellingPrice;
@property (nonatomic, copy) NSString *staffPrice;
@property (nonatomic, copy) NSString *streetsId;
@property (nonatomic, copy) NSString *suitSubProductUuids;
@property (nonatomic, copy) NSString *suitSubProducts;
@property (nonatomic, copy) NSString *suitUuid;
@property (nonatomic, copy) NSString *tempPrice;
@property (nonatomic, copy) NSString *totalPrice;
@property (nonatomic, copy) NSString *totalretailPrice;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *uuid;


@property (nonatomic, copy, readonly) NSString *attrValueStr;
@end


@interface TSBalanceAttrValue : NSObject
@property (nonatomic, copy) NSString *code;
@property (nonatomic, copy) NSString *enName;
@property (nonatomic, copy) NSString *loginUser;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *transId;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *value;
@property (nonatomic, copy) NSString *valueUuid;
@end


@interface TSBalanceIntegralNow : NSObject
@property (nonatomic, copy) NSString *createTime;
@property (nonatomic, copy) NSString *creator;
@property (nonatomic, copy) NSString *defaultPercentage;
@property (nonatomic, copy) NSString *nowId;
@property (nonatomic, copy) NSString *integralFunctionState;
@property (nonatomic, copy) NSString *opeTime;
@property (nonatomic, copy) NSString *oper;
@property (nonatomic, copy) NSString *orderAmountThreshold;
@property (nonatomic, copy) NSString *ratio;
@property (nonatomic, copy) NSString *storeUuid;
@end
