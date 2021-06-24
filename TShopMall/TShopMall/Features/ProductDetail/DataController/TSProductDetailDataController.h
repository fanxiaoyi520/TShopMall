//
//  TSProductDetailDataController.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/15.
//

#import "TSBaseDataController.h"
#import "TSGoodDetailSectionModel.h"
#import "TSGoodDetailItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSProductDetailDataController : TSBaseDataController

/// 商品sku
@property(nonatomic, copy) NSString *attrId;

@property (nonatomic, strong, readonly) NSMutableArray <TSGoodDetailSectionModel *> *sections;


/// 商品详情数据
/// @param uuid 商品uuid
/// @param complete 请求完成block
-(NSMutableArray <TSGoodDetailSectionModel *> *)fetchProductDetailWithUuid:(NSString *)uuid
                                                                  complete:(void(^)(BOOL isSucess))complete;


/// 获取商品详情购物车角标
/// @param complete 请求完成block
-(void)fetchProductDetailCartNumber:(void(^)(BOOL isSucess))complete;



/// 加购
/// @param productUuid 商品UUID
/// @param buyNum 数量
/// @param attrId 商品SKU
/// @param complete 请求完成block
-(void)fetchProductDetailAddProductToCart:(NSString *)productUuid
                                   buyNum:(NSString *)buyNum
                                   attrId:(NSString *)attrId
                                 complete:(void(^)(BOOL isSucess))complete;


/// 商品检查库存
/// @param skuNo 商品SKU
/// @param areaUuid 街道UUID
/// @param parentSkuNo 父类SKU
/// @param buyNum 数量
/// @param region 区县UUID
/// @param complete 请求完成block
-(void)fetchProductDetailHasProduct:(NSString *)skuNo
                           areaUuid:(NSString *)areaUuid
                        parentSkuNo:(NSString *)parentSkuNo
                             buyNum:(NSString *)buyNum
                             region:(NSString *)region
                           complete:(void(^)(BOOL isSucess))complete;


/// 自己买 先清空购物车中的其他商品，注意两个入参固定：productIdAndAttrId: allRecords，chooseState: false
/// @param suitUuid 套装UUID
/// @param complete 请求完成block
-(void)fetchProductDetailCustomBuy:(NSString *)suitUuid
                          complete:(void(^)(BOOL isSucess))complete;


@end

NS_ASSUME_NONNULL_END
