//
//  TSProductDetailDataController.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/15.
//

#import "TSBaseDataController.h"
#import "TSGoodDetailSectionModel.h"
#import "TSGoodDetailItemModel.h"
#import "TSLocationInfoModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSProductDetailDataController : TSBaseDataController

/// 商品主图
@property(nonatomic, copy) NSString *bigImageUrl;

/// 商品sku
@property(nonatomic, copy) NSString *attrId;
/// 商品skuNo
@property(nonatomic, copy) NSString *skuNo;
/// 父类sku
@property(nonatomic, copy) NSString *parentSkuNo;
/// productUuid
@property(nonatomic, copy) NSString *productUuid;
/// 购物车角标
@property(nonatomic, copy) NSString *cartNumber;
/// 购买数量(默认购买数量为1)
@property(nonatomic, copy) NSString *buyNum;

@property(nonatomic, strong) TSLocationInfoModel *locationModel;

/// 下载素材
@property (nonatomic, strong) NSArray <TSMaterialImageModel *> *materialModels;



@property (nonatomic, strong, readonly) NSMutableArray <TSGoodDetailSectionModel *> *sections;


/// 请求商品详情数据
/// @param uuid 商品UUID
/// @param isRequired 是否需要加入线程组
/// @param complete 请求完成回调
-(NSMutableArray <TSGoodDetailSectionModel *> *)fetchProductDetailWithUuid:(NSString *)uuid
                                                       isRequireEnterGroup:(BOOL)isRequired
                                                                     group:(dispatch_group_t)group
                                                                  complete:(void(^)(BOOL isSucess))complete;
/// 获取商品详情购物车角标
/// @param isRequired 是否需要加入线程组
/// @param complete 请求完成回调
-(void)fetchProductDetailCartNumberIsRequireEnterGroup:(BOOL)isRequired
                                                 group:(dispatch_group_t)group
                                              complete:(void(^)(BOOL isSucess))complete;


/// 详情页计算运费接口
/// @param skuNo 商品sku
/// @param buyNum 购买数量
/// @param provinceUuid 省
/// @param cityUuid 市
/// @param regionUuid 区
/// @param streetUuid 街道
/// @param isRequired 是否需要加入线程组
/// @param complete 请求完成回调
-(void)fetchProductDetailFreightWithSkuNo:(NSString *)skuNo
                                   buyNum:(NSString *)buyNum
                             provinceUuid:(NSString *)provinceUuid
                                 cityUuid:(NSString *)cityUuid
                               regionUuid:(NSString *)regionUuid
                               streetUuid:(NSString *)streetUuid
                      isRequireEnterGroup:(BOOL)isRequired
                                    group:(dispatch_group_t)group
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
                isRequireEnterGroup:(BOOL)isRequired
                              group:(dispatch_group_t)group
                           complete:(void(^)(BOOL isSucess))complete;



/// 加购
/// @param productUuid 商品UUID
/// @param buyNum 数量
/// @param attrId 商品SKU
/// @param complete 请求完成block
-(void)fetchProductDetailAddProductToCart:(NSString *)productUuid
                                   buyNum:(NSString *)buyNum
                                   attrId:(NSString *)attrId
                                 complete:(void(^)(BOOL isSucess))complete;


/// 自己买
/// @param productUuid 商品UUID
/// @param buyNum 数量
/// @param attrId 商品SKU
/// @param complete 请求完成block
-(void)fetchProductDetailCustomBuyProductUuid:(NSString *)productUuid
                                       buyNum:(NSString *)buyNum
                                       attrId:(NSString *)attrId
                          complete:(void(^)(BOOL isSucess))complete;


/// 员工分享
/// @param shareType 分享类型
-(void)fetchStaffShareShareType:(NSUInteger)shareType
                       complete:(void(^)(BOOL isSucess, NSDictionary *data))complete;



/// 特权分享设置
/// @param shareType 分享类型（0 普通分享 1员工分享 2特权分享 3 特惠价分享）
/// @param discountType 优惠方式:打折(percent)、指定价格(price)
/// @param discountPrice 折扣金额
-(void)fetchProductPrerogativeStaffShareType:(NSString *)shareType
                                discountType:(NSString *)discountType
                               discountPrice:(NSString *)discountPrice
                                    complete:(void(^)(BOOL isSucess, NSDictionary *data))complete;

@end

NS_ASSUME_NONNULL_END
