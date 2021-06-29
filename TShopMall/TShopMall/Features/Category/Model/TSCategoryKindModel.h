//
//  TSCategoryKindModel.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSCategoryKindModel : NSObject

/// 种类名
@property(nonatomic, copy) NSString *kind;
/// 是否选中
@property(nonatomic, assign) BOOL selected;
/// section 开始下标
@property (nonatomic, assign) NSInteger startSection;
@end

NS_ASSUME_NONNULL_END
