//
//  TSSearchKeyViewModel.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/15.
//

#import <Foundation/Foundation.h>


@interface TSSearchKeyViewModel : NSObject
@property (nonatomic, copy) NSString *keywords;

+ (void)handleHistoryKeys:(NSString *)key;
+ (NSArray *)readHistoryKeys;
+ (void)clearHistorySearchKeys;
@end

