//
//  TSCategoryHeaderReusableView.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/10.
//

#import "TSUniversalHeaderView.h"
#import "TSCategorySectionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSCategoryHeaderReusableView : TSUniversalHeaderView

-(void)bindCategorySectionModel:(TSCategorySectionModel *)model;

@end

NS_ASSUME_NONNULL_END
