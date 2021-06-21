//
//  TSSearchResultController.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/21.
//

#import "TSBaseViewController.h"

@interface TSSearchResultController : TSBaseViewController
@property (nonatomic, copy) NSString *searchKey;
- (void)showSearchResultView;
@end

