//
//  TSMineSectionModel.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/11.
//

#import "TSUniversalSectionModel.h"
#import "TSUniversaItemModel.h"


@class TSMineSectionItemModel;

NS_ASSUME_NONNULL_BEGIN

@interface TSMineSectionModel : TSUniversalSectionModel

/// 头标题
@property (nonatomic, copy) NSString *headerName;
/// item
@property (nonatomic, strong) NSArray <TSMineSectionItemModel *> *items;

@end

@interface TSMineSectionItemModel : TSUniversaItemModel

@end

@interface TSMineSectionOrderItemModel : TSMineSectionItemModel

@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *imageName;

@end

@interface TSMineSectionAdsItemModel : TSMineSectionItemModel

@end

@interface TSMineSectionEarnItemModel : TSMineSectionItemModel

@end

@interface TSMineSectionParterItemModel : TSMineSectionItemModel

@end

NS_ASSUME_NONNULL_END
