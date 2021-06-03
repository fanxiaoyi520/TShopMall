//
//  SSKVOArrayObject.m
//  SSBaseTemplate
//
//  Created by 陈结 on 2021/5/12.
//

#import "SSKVOArrayObject.h"

@implementation SSKVOArrayObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.targetArray = [NSMutableArray array];
    }
    return self;
}

@end
