//
//  TSHomePageReleaseTitleViewModel.h
//  TShopMall
//
//  Created by sway on 2021/6/16.
//

#import "TSHomePageCellViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSHomePageReleaseTitleViewModel : TSHomePageCellViewModel
- (void)getReleaseTitleData;
@property (nonatomic, strong) NSAttributedString *title;
@end

NS_ASSUME_NONNULL_END
