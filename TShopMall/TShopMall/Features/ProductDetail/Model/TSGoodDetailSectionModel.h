//
//  TSGoodDetailSectionModel.h
//  TSale
//
//  Created by 陈洁 on 2021/1/9.
//  Copyright © 2021 TCL. All rights reserved.
//

#import "TSUniversalSectionModel.h"
#import "TSGoodDetailItemModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSGoodDetailSectionModel : TSUniversalSectionModel

/// sectionName名
@property (nonatomic, copy) NSString *sectionName;
/// section编号
@property (nonatomic, assign) BOOL isFirstSection;
/// items
@property (nonatomic, strong) NSArray <TSGoodDetailItemModel *>* items;

@end

 
NS_ASSUME_NONNULL_END
