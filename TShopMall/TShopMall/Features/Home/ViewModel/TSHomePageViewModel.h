//
//  TSHomePageViewModel.h
//  TShopMall
//
//  Created by sway on 2021/6/10.
//

#import <Foundation/Foundation.h>
#import "TSHomePageCellViewModel.h"
#import "TSHomePageCellTemplateModel.h"
#import "TSCategoryGroupViewModel.h"
NS_ASSUME_NONNULL_BEGIN
@interface TSHomePageViewModel : NSObject
@property (nonatomic, strong) NSArray <TSHomePageCellViewModel *> *dataSource;
@property (nonatomic, strong) TSCategoryGroupViewModel *containerViewModel;
- (void)fetchData;
@end

NS_ASSUME_NONNULL_END
