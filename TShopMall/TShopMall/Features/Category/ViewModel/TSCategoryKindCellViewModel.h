//
//  TSCategoryKindCellViewModel.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/12.
//

#import <Foundation/Foundation.h>
#import "TSCategoryKindModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSCategoryKindCellViewModel : NSObject

/// 种类名
@property(nonatomic, copy) NSString *kind;
/// 是否选中
@property(nonatomic, assign) BOOL selected;
/// 第几行
@property(nonatomic, assign) NSUInteger row;

+ (nonnull TSCategoryKindCellViewModel *)viewModelWithSubject:(nonnull TSCategoryKindModel *)kindModel
                                                    isSlected:(BOOL)isSlected;

@end

NS_ASSUME_NONNULL_END
