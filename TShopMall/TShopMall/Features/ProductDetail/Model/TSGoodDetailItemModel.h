//
//  TSGoodDetailItemModel.h
//  TSale
//
//  Created by 陈洁 on 2021/1/9.
//  Copyright © 2021 TCL. All rights reserved.
//

#import "TSUniversaItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSGoodDetailItemModel : TSUniversaItemModel

@end

@interface TSGoodDetailItemBannerModel : TSGoodDetailItemModel
/// images
@property (nonatomic, strong) NSArray *urls;

@end

@interface TSGoodDetailItemPriceModel : TSGoodDetailItemModel

/// 挂牌价
@property (nonatomic, copy) NSString *marketPrice;
/// 提货价
@property (nonatomic, copy) NSString *staffPrice;
/// 最高赚
@property (nonatomic, copy) NSString *earnMost;



/// 标题
@property (nonatomic, copy) NSString *title;
/// 内容
@property (nonatomic, copy) NSString *content;

@end

@interface TSGoodDetailItemDownloadImageModel : TSGoodDetailItemModel

/// images
@property (nonatomic, strong) NSArray *urls;

@end


@interface TSGoodDetailItemImageModel : TSGoodDetailItemModel

@property(nonatomic, copy) NSString *imgUrl;
@property(nonatomic, assign) CGFloat imageWidth;
@property(nonatomic, assign) CGFloat imageHeight;

@end


NS_ASSUME_NONNULL_END
