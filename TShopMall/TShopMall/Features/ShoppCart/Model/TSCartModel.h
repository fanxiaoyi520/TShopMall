//
//  TSCartModel.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/9.
//

#import <Foundation/Foundation.h>

@class TSCartStore;
@class TSCart;
@class TSCartAttr;
@class TSCartCoupon;

@interface TSCartModel : NSObject
@property (nonatomic, assign) NSInteger cartProductCount;
@property (nonatomic, assign) NSInteger cartProductCount_sel;
@property (nonatomic, assign) NSInteger cartsShowToBlance;
@property (nonatomic, copy) NSString *cartsTotalMount;
@property (nonatomic, copy) NSString *productTotalMount;
@property (nonatomic, strong) NSArray<TSCartStore *> *cartStores;
@property (nonatomic, strong) NSArray<TSCart *> *carts;
@end

@interface TSCartStore : NSObject
@property (nonatomic, assign) NSInteger checked;
@property (nonatomic, assign) NSInteger showToBlance;
@property (nonatomic, copy) NSString *storeName;
@property (nonatomic, copy) NSString *storeUuid;
@property (nonatomic, assign) NSInteger suppotCod;
@end

@interface TSCart : NSObject
@property (nonatomic, copy) NSString *attrIds;
@property (nonatomic, strong) NSArray<TSCartAttr *> *attrValues;
@property (nonatomic, assign) NSInteger buyNum;
@property (nonatomic, copy) NSString *canBuyNum;
@property (nonatomic, copy) NSString *cartManagerUuid;
@property (nonatomic, copy) NSString *categoryName;
@property (nonatomic, copy) NSString *channelType;
@property (nonatomic, copy) NSString *channelUuid;
@property (nonatomic, assign) NSInteger checked;
@property (nonatomic, copy) NSString *cmdUuid;
@property (nonatomic, strong) NSArray<TSCartCoupon *> *couponList;
@property (nonatomic, assign) NSInteger existedInDB;
@property (nonatomic, copy) NSString *finalPrice;
@property (nonatomic, copy) NSString *integralWarning;
@property (nonatomic, copy) NSString *isSuitMain;
@property (nonatomic, copy) NSString *limitNum;
@property (nonatomic, copy) NSString *marketFinalPrice;
@property (nonatomic, assign) BOOL onSell;
@property (nonatomic, copy) NSString *opeTime;
@property (nonatomic, copy) NSString *parentSkuNo;
@property (nonatomic, copy) NSString *pim;
@property (nonatomic, assign) NSInteger position;
@property (nonatomic, copy) NSString *productId;
@property (nonatomic, copy) NSString *productImg;
@property (nonatomic, copy) NSString *productImgUrl;
@property (nonatomic, copy) NSString *productName;
@property (nonatomic, copy) NSString *productSn;
@property (nonatomic, copy) NSString *productWarning;
@property (nonatomic, copy) NSString *promotionLimitBuy;
@property (nonatomic, copy) NSString *promotionSubscribeOrReserveVo;
@property (nonatomic, copy) NSString *promotionUuid;
@property (nonatomic, copy) NSString *purchaseLimit;
@property (nonatomic, copy) NSString *sellingPrice;
@property (nonatomic, copy) NSString *singleMarketPrice;
@property (nonatomic, copy) NSString *staffPrice;
@property (nonatomic, copy) NSString *stockNo;
@property (nonatomic, strong) NSArray *storePromotions;
@property (nonatomic, copy) NSString *streets;
@property (nonatomic, copy) NSString *suitCostAmount;
@property (nonatomic, copy) NSString *suitFinalPrice;
@property (nonatomic, copy) NSString *suitMain;
@property (nonatomic, assign) BOOL suitOnSell;
@property (nonatomic, copy) NSString *suitSubProduct;
@property (nonatomic, copy) NSString *suitTotalPrice;
@property (nonatomic, copy) NSString *suitUuid;
@property (nonatomic, copy) NSString *totalPrice;
@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign, readonly) BOOL isEnough;//库存是否充足
@property (nonatomic, assign, readonly) BOOL isInvalid;//是否失效
@property (nonatomic, copy, readonly) NSString *invalidReson;
@property (nonatomic, copy, readonly) NSString *attrValueStr;
@end

@interface TSCartAttr : NSObject
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

@interface TSCartCoupon : NSObject
@property (nonatomic, assign) BOOL canEdit;
@property (nonatomic, assign) NSInteger canIssuedNum;
@property (nonatomic, assign) BOOL cansend;
@property (nonatomic, copy) NSString *categoryRels;
@property (nonatomic, copy) NSString *code;
@property (nonatomic, assign) NSInteger collectType;
@property (nonatomic, copy) NSString *convertIntegral;
@property (nonatomic, assign) NSInteger couCondition;
@property (nonatomic, copy) NSString *couConditionType;
@property (nonatomic, copy) NSString *couponTypeCanUse;
@property (nonatomic, copy) NSString *couponTypeName;
@property (nonatomic, copy) NSString *couponUrl;
@property (nonatomic, assign) BOOL delFlag;
@property (nonatomic, copy) NSString *denomination;
@property (nonatomic, assign) NSInteger effectiveDays;
@property (nonatomic, copy) NSString *effectiveTimeDes;
@property (nonatomic, copy) NSString *endTime;
@property (nonatomic, copy) NSString *handEndTime;
@property (nonatomic, copy) NSString *hasDrawNum;
@property (nonatomic, copy) NSString *issuedNum;
@property (nonatomic, assign) NSInteger limitNum;
@property (nonatomic, copy) NSString *limitNumType;
@property (nonatomic, assign) BOOL makeFlag;
@property (nonatomic, copy) NSString *mobileUseScope;
@property (nonatomic, copy) NSString *msg;
@property (nonatomic, copy) NSString *opeTime;
@property (nonatomic, copy) NSString *oper;
@property (nonatomic, strong) id productRelList;
@property (nonatomic, copy) NSString *productRelNum;
@property (nonatomic, assign) NSInteger raleType;
@property (nonatomic, copy) NSString *raleTypeName;
@property (nonatomic, copy) NSString *reachUpLimit;
@property (nonatomic, copy) NSString *scope;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *storeName;
@property (nonatomic, copy) NSString *storeUuid;
@property (nonatomic, assign) NSInteger useMT;
@property (nonatomic, assign) NSInteger usePC;
@property (nonatomic, assign) NSInteger useTV;
@property (nonatomic, copy) NSString *uuid;
@end
