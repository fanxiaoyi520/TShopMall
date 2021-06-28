//
//  TSSearchResultController.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/21.
//

#import "TSBaseViewController.h"

@interface TSSearchResultController : TSBaseViewController
@property (nonatomic, copy) NSString *searchKey;
@property (nonatomic, copy) NSString *goodsGroupUuid;// 商品类别uuid
- (void)showSearchResultView;
@end

