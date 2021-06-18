//
//  TSHomePageContainerGroup.h
//  TShopMall
//
//  Created by sway on 2021/6/14.
//

#import <Foundation/Foundation.h>
#import "TSProductBaseModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TSHomePageContainerGroup : NSObject
@property (nonatomic, copy) NSString *groupId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray <TSProductBaseModel *> *list;
@property (nonatomic, assign) int totalNum;

@end

NS_ASSUME_NONNULL_END
