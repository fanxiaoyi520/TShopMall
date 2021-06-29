//
//  TSCategoryContentViewModel.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/12.
//

#import "TSCategoryContentViewModel.h"

@implementation TSCategoryContentViewModel

-(void)viewModelWithSubjects:(nonnull NSArray<TSCategoryContentModel *> *)subjects selectedRow:(NSUInteger)selectedRow{
    
    NSMutableArray *cellViewModels = [NSMutableArray array];
    
    for (int i = 0; i < subjects.count; i++) {
        TSCategoryContentCellViewModel *cellViewModel = [TSCategoryContentCellViewModel viewModelWithSubject:subjects[i]];
        [cellViewModels addObject:cellViewModel];
    }
    
    self.cellViewModels = cellViewModels;
//    self.currentCellViewModel = cellViewModels[selectedRow];
      
}

-(void)viewModelExchangeSelectedRow:(NSUInteger)selectedRow{
//    self.currentCellViewModel = self.cellViewModels[selectedRow];
}

@end
