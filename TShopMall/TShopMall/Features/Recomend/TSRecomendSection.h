//
//  TSRecomendSection.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/22.
//

#import "TSUniversalSectionModel.h"
#import "TSUniversaItemModel.h"

@class TSRecomendRow;

@interface TSRecomendSection : TSUniversalSectionModel
@property (nonatomic, strong) NSArray<TSRecomendRow *> *rows;
@end

@interface TSRecomendRow : TSUniversaItemModel
@property (nonatomic, strong) id obj;
@property (nonatomic, assign) CGSize size;
@end
