//
//  TSRecomendModel.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/22.
//

#import <Foundation/Foundation.h>
#import "TSRecomendGoodsProtocol.h"
@class TSRecomendGoods;
@class TSRecomendPageInfo;

@interface TSRecomendModel : NSObject
@property (nonatomic, copy) NSString *accountType;
@property (nonatomic, strong) NSDictionary *data;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) NSArray<TSRecomendGoods *> *goodsList;
@property (nonatomic, copy) NSString *padding;
@property (nonatomic, assign) NSInteger listStyle;
@property (nonatomic, strong) TSRecomendPageInfo *pageInfo;
@end

@interface TSRecomendGoods : NSObject<TSRecomendGoodsProtocol>
@property (nonatomic, copy) NSString *baseRetailPrice;
@property (nonatomic, assign) BOOL buyState;
@property (nonatomic, copy) NSString *earnMost;
@property (nonatomic, copy) NSString *goodsUuid;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *pTagId;
@property (nonatomic, copy) NSString *pTagName;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *productName;
@property (nonatomic, copy) NSString *promotionPrice;
@property (nonatomic, copy) NSString *recommend;
@property (nonatomic, copy) NSString *sellingPrice;
@property (nonatomic, copy) NSString *staffPrice;
@property (nonatomic, assign) NSInteger stock;
@end


@interface TSRecomendPageInfo : NSObject
@property (nonatomic, copy) NSString *actionType;
@property (nonatomic, copy) NSString *backgroundColor;
@end
