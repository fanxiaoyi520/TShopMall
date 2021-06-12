//
//  TSCategoryContentViewModel.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/12.
//

#import <Foundation/Foundation.h>
#import "TSCategoryContentCellViewModel.h"
#import "TSCategoryKindModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSCategoryContentViewModel : NSObject

@property (nonatomic, strong, nonnull) NSArray<TSCategoryContentCellViewModel *> *cellViewModels;

@property (nonatomic, strong, nonnull) UIColor *backgroundColor;

+ (nonnull TSCategoryContentViewModel *)viewModelWithSubjects:(nonnull NSArray<TSCategoryKindModel *> *)subjects;

@end

NS_ASSUME_NONNULL_END
