//
//  TSSearchKeyViewModel.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/15.
//

#import "TSSearchKeyViewModel.h"

@implementation TSSearchKeyViewModel
+ (void)handleHistoryKeys:(NSString *)key{
    NSString *a = [key stringByReplacingOccurrencesOfString:@" " withString:@""];
    if (a.length == 0) {
        return;
    }
    NSArray *keys = [[NSUserDefaults standardUserDefaults] objectForKey:@"SearchHistoryKeys"];
    NSMutableArray *arr = [NSMutableArray array];
    BOOL exist = NO;
    for (NSString *str in keys) {
        if ([str isEqualToString:key]) {
            exist = YES;
            return ;
        }
    }
    if (keys.count == 0) {
        [arr addObject:key];
    } else {
        [arr addObjectsFromArray:keys];
        [arr insertObject:key atIndex:0];
    }
    [[NSUserDefaults standardUserDefaults] setObject:arr forKey:@"SearchHistoryKeys"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSArray *)readHistoryKeys{
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"SearchHistoryKeys"];
}

+ (void)clearHistorySearchKeys{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SearchHistoryKeys"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
@end
