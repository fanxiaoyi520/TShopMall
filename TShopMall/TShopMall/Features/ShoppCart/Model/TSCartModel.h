//
//  TSCartModel.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/9.
//

#import <Foundation/Foundation.h>

@class TSCartStore;
@class TSCart;

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
@property (nonatomic, strong) NSArray *attrValues;
@property (nonatomic, assign) NSInteger buyNum;
@property (nonatomic, copy) NSString *cartManagerUuid;
@property (nonatomic, copy) NSString *channelType;
@property (nonatomic, copy) NSString *channelUuid;
@property (nonatomic, assign) NSInteger checked;
@property (nonatomic, copy) NSString *cmdUuid;
@property (nonatomic, strong) NSArray *couponList;
@property (nonatomic, assign) NSInteger existedInDB;
@property (nonatomic, copy) NSString *finalPrice;
@property (nonatomic, copy) NSString *integralWarning;
@property (nonatomic, copy) NSString *isSuitMain;
@property (nonatomic, copy) NSString *marketFinalPrice;
@property (nonatomic, assign) BOOL onSell;
@property (nonatomic, copy) NSString *opeTime;
@property (nonatomic, copy) NSString *pim;
@property (nonatomic, assign) NSInteger position;
@property (nonatomic, copy) NSString *productId;
@property (nonatomic, copy) NSString *productImg;
@property (nonatomic, copy) NSString *productImgUrl;
@property (nonatomic, copy) NSString *productName;
@property (nonatomic, copy) NSString *productWarning;
@property (nonatomic, copy) NSString *singleMarketPrice;
@property (nonatomic, copy) NSString *stockNo;
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

@property (nonatomic, assign) BOOL hasGift;
@property (nonatomic, assign) BOOL isSelected;
@end
