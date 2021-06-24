//
//  Popover+TSDefaultConfig.m
//  TShopMall
//
//  Created by  on 2021/6/24.
//

#import "Popover+TSDefaultConfig.h"

@implementation Popover (TSDefaultConfig)
+ (ProgressModel *)defaultConfig{
    ProgressModel *model = [ProgressModel new];
    model.text = @"加载中";
    model.inProgress = YES;
    model.showMaskView = NO;
    return model;
}
@end
