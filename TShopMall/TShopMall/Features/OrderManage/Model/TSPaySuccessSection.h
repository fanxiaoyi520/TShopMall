//
//  TSPaySuccessSection.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/28.
//

#import "TSUniversalSectionModel.h"
#import "TSUniversaItemModel.h"

@class TSPaySuccessItem;

@interface TSPaySuccessSection : TSUniversalSectionModel
@property (nonatomic, strong) NSArray<TSPaySuccessItem *> *items;
@end


@interface TSPaySuccessItem : TSUniversaItemModel
@property (nonatomic, strong) id obj;
@end
