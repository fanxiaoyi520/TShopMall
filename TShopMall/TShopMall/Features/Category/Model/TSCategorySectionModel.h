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

@property(nonatomic, copy) NSString *imgUrl;
@property(nonatomic, copy) NSString *name;

@end

@interface TSCategorySectionRecommendItemModel : TSCategorySectionItemModel

@property(nonatomic, copy) NSString *imgUrl;
@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *retailPrice;
@property(nonatomic, copy) NSString *commission;
@property(nonatomic, copy) NSString *goodsPrice;

@end

NS_ASSUME_NONNULL_END
