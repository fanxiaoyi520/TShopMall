//
//  TSCategoryKindCell.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/10.
//

#import "TSUniversalTableViewCell.h"
#import "TSCategoryKindCellViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSCategoryKindCell : TSUniversalTableViewCell

-(void)bindKindViewModel:(TSCategoryKindCellViewModel *)viewModel;

@end

NS_ASSUME_NONNULL_END
