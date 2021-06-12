//
//  TSCategoryKindViewModel.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/12.
//

#import "TSCategoryKindViewModel.h"

@implementation TSCategoryKindViewModel

-(void)viewModelWithKinds:(nonnull NSArray <TSCategoryKindModel *> *)kinds selectedRow:(NSUInteger)selectedRow{
    
    NSMutableArray *viewModels = [NSMutableArray array];
    for (int i = 0; i < kinds.count; i++) {
        BOOL selected = NO;
        if (i == selectedRow) {
            selected = YES;
        }
        
        TSCategoryKindCellViewModel *cellModel = [TSCategoryKindCellViewModel viewModelWithSubject:kinds[i] isSlected:selected];
        [viewModels addObject:cellModel];
    }
    
    self.cellViewModels = viewModels;
}

-(void)viewModelExchangeSelectedRow:(NSUInteger)selectedRow{
    for (int i = 0; i < self.cellViewModels.count; i++) {
        TSCategoryKindCellViewModel *cellModel = self.cellViewModels[i];
        if (i == selectedRow) {
            cellModel.selected = YES;
        } else {
            cellModel.selected = NO;
        }
    }
}

@end
