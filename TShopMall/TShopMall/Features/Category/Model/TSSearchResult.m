//
//  TSSearchResult.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/15.
//

#import "TSSearchResult.h"

@implementation TSSearchResult

- (void)setList:(NSArray<TSSearchList *> *)list{
    _list = [NSArray yy_modelArrayWithClass:[TSSearchList class] json:list];
}

@end

@implementation TSSearchList


@end
