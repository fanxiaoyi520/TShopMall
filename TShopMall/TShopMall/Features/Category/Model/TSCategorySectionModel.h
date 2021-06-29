//
//  TSCategorySectionModel.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/10.
//

#import "TSUniversalSectionModel.h"
#import "TSUniversaItemModel.h"

@class TSCategorySectionItemModel;

NS_ASSUME_NONNULL_BEGIN

@interface TSCategorySectionModel : TSUniversalSectionModel

/// 头标题
@property (nonatomic, copy) NSString *headerName;
/// item
@property (nonatomic, strong) NSArray <TSCategorySectionItemModel *>* items;

@end

@interface TSCategorySectionItemModel : TSUniversaItemModel


@end

// banner
@interface TSCategorySectionBannerItemModel : TSCategorySectionItemModel

@property(nonatomic, strong) NSArray *imgUrls;

@end

@interface TSCategorySectionKindItemModel : TSCategorySectionItemModel

@property(nonatomic, copy) NSString *TwoLevelImg;
@property(nonatomic, copy) NSString *TwoLevelTitle;

@end

@interface TSCategorySectionRecommendItemModel : TSCategorySectionItemModel

@property(nonatomic, copy) NSString *promotionPrice;
@property(nonatomic, copy) NSString *buyState;
@property(nonatomic, copy) NSString *recommend;
@property(nonatomic, copy) NSString *baseRetailPrice;
@property(nonatomic, copy) NSString *uuid;
@property(nonatomic, copy) NSString *productName;
@property(nonatomic, copy) NSString *sellingPrice;
@property(nonatomic, copy) NSString *price;
@property(nonatomic, copy) NSString *imageUrl;
@property(nonatomic, copy) NSString *stock;
@property(nonatomic, copy) NSString *staffPrice;
@property(nonatomic, copy) NSString *earnMost;

@end

NS_ASSUME_NONNULL_END
