//
//  TSCategoryKindViewModel.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/12.
//

#import <Foundation/Foundation.h>
#import "TSCategoryKindCellViewModel.h"
#import "TSCategoryKindModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSCategoryKindViewModel : NSObject

@property (nonatomic, strong, nonnull) NSArray<TSCategoryKindCellViewModel *> *cellViewModels;

-(void)viewModelWithKinds:(nonnull NSArray <TSCategoryKindModel *> *)kinds selectedRow:(NSUInteger)selectedRow;
-(void)viewModelExchangeSelectedRow:(NSUInteger)selectedRow;

@end

NS_ASSUME_NONNULL_END

