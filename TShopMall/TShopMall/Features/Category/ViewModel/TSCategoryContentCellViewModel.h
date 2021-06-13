//
//  TSCategoryContentCellViewModel.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/12.
//

#import <Foundation/Foundation.h>
#import "TSCategoryContentModel.h"
#import "TSCategorySectionModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSCategoryContentCellViewModel : NSObject

@property(nonatomic, strong) NSArray <TSCategorySectionModel *> *sections;

+ (nonnull TSCategoryContentCellViewModel *)viewModelWithSubject:(nonnull TSCategoryContentModel *)kindModel;

@end

NS_ASSUME_NONNULL_END
