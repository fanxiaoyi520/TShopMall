//
//  TSProductBaseModel.h
//  TShopMall
//
//  Created by sway on 2021/6/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSProductBaseModel : NSObject
@property (nonatomic, copy) NSString *uuid;//商品UUID
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *secondParentCategory;
@property (nonatomic, copy) NSString *recommend;//商品推荐描述，目前位于商品名称下方显示
@property (nonatomic, copy) NSString *clickurl;
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *desNote;
@property (nonatomic, assign) int salsnum;//实时销量
@property (nonatomic, assign) double price;
@property (nonatomic, assign) double sellingPrice;//划线价
@property (nonatomic, assign) double promotionPrice;//促销价格

@property (nonatomic, copy) NSString *promotionDesc;//促销描述
@property (nonatomic, copy) NSString *skuNo;//商品编码
@property (nonatomic, copy) NSString *existProduct;//商品库存是否存在1：存在0：不存在
@property (nonatomic, copy) NSString *state;//上架状态1 ：上架
@property (nonatomic, copy) NSString *platformUuid;//商户平台业务模式id
@property (nonatomic, assign) int limitNum;//限购数量
@property (nonatomic, assign) int browseVolume;//pv 浏览量
@property (nonatomic, assign) int visitorVolume;//uv 访客量

@property (nonatomic, copy) NSString *labelTitleName;//角标标签中文
@property (nonatomic, copy) NSString *labelImageUrl;//角标标签图片地址

@end

NS_ASSUME_NONNULL_END
