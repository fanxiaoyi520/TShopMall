//
//  TSCategoryContentViewModel.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/12.
//

#import <Foundation/Foundation.h>
#import "TSCategoryContentModel.h"
#import "TSCategoryContentCellViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSCategoryContentViewModel : NSObject

@property(nonatomic, strong) TSCategoryContentCellViewModel *currentCellViewModel;

@property (nonatomic, strong, nonnull) NSArray<TSCategoryContentCellViewModel *> *cellViewModels;

-(void)viewModelWithSubjects:(nonnull NSArray<TSCategoryContentModel *> *)subjects selectedRow:(NSUInteger)selectedRow;
-(void)viewModelExchangeSelectedRow:(NSUInteger)selectedRow;

@end

NS_ASSUME_NONNULL_END
