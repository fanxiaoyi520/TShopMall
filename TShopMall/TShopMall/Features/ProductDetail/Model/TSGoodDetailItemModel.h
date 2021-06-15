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

@end


NS_ASSUME_NONNULL_END
