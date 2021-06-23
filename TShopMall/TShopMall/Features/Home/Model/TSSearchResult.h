//
//  TSSearchResult.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/15.
//

#import <Foundation/Foundation.h>

@class TSSearchList;

@interface TSSearchResult : NSObject
@property (nonatomic, strong) NSDictionary *attributeMap;
@property (nonatomic, strong) NSDictionary *attributeValueMap;
@property (nonatomic, strong) NSArray *brands;
@property (nonatomic, strong) NSArray *catePrices;
@property (nonatomic, strong) NSDictionary *categoryMap;
@property (nonatomic, strong) NSArray *cates;
@property (nonatomic, copy) NSString *frontCategoryUuid;
@property (nonatomic, strong) NSArray *jsonList;
@property (nonatomic, copy) NSString *keyword;
@property (nonatomic, strong) NSArray<TSSearchList *> *list;
@property (nonatomic, assign) NSInteger totalNum;
@property (nonatomic, copy) NSString *searcheName;
@property (nonatomic, copy) NSString *subCate;
@end

@interface TSSearchList : NSObject
@property (nonatomic, copy) NSString *auditState;
@property (nonatomic, copy) NSString *bCustomerUuids;
@property (nonatomic, copy) NSString *baseRetailPrice;
@property (nonatomic, copy) NSString *bcustomerNo;
@property (nonatomic, copy) NSString *browseVolume;
@property (nonatomic, copy) NSString *buyState;
@property (nonatomic, copy) NSString *buyStatePhone;
@property (nonatomic, copy) NSString *buyStateTv;
@property (nonatomic, copy) NSString *carriageTemplateName;
@property (nonatomic, copy) NSString *carriageTemplateUuid;
@property (nonatomic, strong) NSString *catNames;
@property (nonatomic, strong) NSString *cats;
@property (nonatomic, copy) NSString *channelPrice;
@property (nonatomic, copy) NSString *clickurl;
@property (nonatomic, copy) NSString *comments;
@property (nonatomic, copy) NSString *commission;
@property (nonatomic, copy) NSString *desNote;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *existProduct;
@property (nonatomic, copy) NSString *favoriteState;
@property (nonatomic, copy) NSString *friendPrice;
@property (nonatomic, copy) NSString *isHide;
@property (nonatomic, copy) NSString *isTuike;
@property (nonatomic, copy) NSString *labelId;
@property (nonatomic, copy) NSString *labelImageUrl;
@property (nonatomic, copy) NSString *labelTitleName;
@property (nonatomic, copy) NSString *limitNum;
@property (nonatomic, copy) NSString *maxPrice;
@property (nonatomic, copy) NSString *minPrice;
@property (nonatomic, assign) NSInteger mount;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *pTagId;
@property (nonatomic, copy) NSString *pTagName;
@property (nonatomic, copy) NSString *parentSkuNo;
@property (nonatomic, copy) NSString *phonePrice;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *pic2;
@property (nonatomic, copy) NSString *platformUuid;
@property (nonatomic, copy) NSString *pname;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *priceText;
@property (nonatomic, copy) NSString *productSn;
@property (nonatomic, strong) NSArray *productTagList;
@property (nonatomic, copy) NSString *productType;
@property (nonatomic, copy) NSString *productUuid;
@property (nonatomic, copy) NSString *promotionDesc;
@property (nonatomic, copy) NSString *promotionLimitBuy;
@property (nonatomic, copy) NSString *promotionPrice;
@property (nonatomic, copy) NSString *props;
@property (nonatomic, copy) NSString *recommend;
@property (nonatomic, assign) NSInteger salsnum;
@property (nonatomic, assign) NSInteger score;
@property (nonatomic, copy) NSString *secondParentCategory;
@property (nonatomic, copy) NSString *sellingPrice;
@property (nonatomic, copy) NSString *shelveTime;
@property (nonatomic, copy) NSString *skuNo;
@property (nonatomic, copy) NSString *staffPrice;
@property (nonatomic, assign) NSInteger state;
@property (nonatomic, copy) NSString *stock;
@property (nonatomic, copy) NSString *storeCategoryUuids;
@property (nonatomic, copy) NSString *storeName;
@property (nonatomic, copy) NSString *storeUuid;
@property (nonatomic, copy) NSString *systemNowTime;
@property (nonatomic, copy) NSString *tenantId;
@property (nonatomic, copy) NSString *updateTime;
@property (nonatomic, copy) NSString *uuid;
@property (nonatomic, copy) NSString *visitorVolume;
@property (nonatomic, copy) NSString *earnMost;
@end

