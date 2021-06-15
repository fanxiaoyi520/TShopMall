//
//  TSCategoryKindCellViewModel.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/12.
//

#import "TSCategoryKindCellViewModel.h"

@implementation TSCategoryKindCellViewModel

+ (nonnull TSCategoryKindCellViewModel *)viewModelWithSubject:(nonnull TSCategoryKindModel *)kindModel isSlected:(BOOL)isSlected{
    TSCategoryKindCellViewModel *viewModel = [[TSCategoryKindCellViewModel alloc] init];
    viewModel.kind = kindModel.kind;
    viewModel.selected = isSlected;
    return viewModel;
}

@end
