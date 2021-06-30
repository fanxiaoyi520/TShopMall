//
//  TSSearchResultController.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/29.
//

#import "TSGoodsListController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSSearchResultController : TSGoodsListController
@property (nonatomic, copy) NSString *searchKey;
@property (nonatomic, copy) NSString *goodsGroupUuid;// 商品类别uuid
- (void)showSearchResultView;
@end

NS_ASSUME_NONNULL_END
