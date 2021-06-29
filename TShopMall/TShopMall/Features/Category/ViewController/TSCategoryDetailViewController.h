//
//  TSCategoryDetailViewController.h
//  TShopMall
//
//  Created by  on 2021/6/29.
//

#import "TSBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSCategoryDetailViewController : TSBaseViewController
@property (nonatomic, copy) NSString *uuid;// 商品类别uuid
@property (nonatomic, copy) NSString *name;// 标题
@end

NS_ASSUME_NONNULL_END
