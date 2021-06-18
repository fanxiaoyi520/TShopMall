//
//  TSHomePageCellViewModel.h
//  TShopMall
//
//  Created by sway on 2021/6/10.
//

#import <Foundation/Foundation.h>
#import "TSHomePageCellTemplateModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSHomePageCellViewModel : NSObject
/// cell当前配置信息
@property (nonatomic, strong) TSHomePageCellTemplateModel *model;
/// 更新当前cell内容
- (void)refreshData;

@end

NS_ASSUME_NONNULL_END
