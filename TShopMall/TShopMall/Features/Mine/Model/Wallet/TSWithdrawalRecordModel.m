//
//  TSWithdrawalRecordModel.m
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/24.
//

#import "TSWithdrawalRecordModel.h"

@implementation TSWithdrawalRecordModel

+ (NSArray *)getFixedFata {
    NSArray *array = nil;
    array = @[@"全部",@"审批中",@"付款中",@"已完成"];
    return array;
}


@end
