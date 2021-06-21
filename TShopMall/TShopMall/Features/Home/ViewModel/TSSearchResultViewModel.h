//
//  TSSearchResultViewModel.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/21.
//

#import <Foundation/Foundation.h>
#import "TSSearchResult.h"

@interface TSSearchResultViewModel : NSObject
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *earnPrice;
@property (nonatomic, copy) NSString *thPrice;

- (instancetype)initWithList:(TSSearchList *)list;
@end

