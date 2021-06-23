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

@end

NS_ASSUME_NONNULL_END
