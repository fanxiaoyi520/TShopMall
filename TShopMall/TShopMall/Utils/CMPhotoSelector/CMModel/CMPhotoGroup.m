//
//  CMPhotoGroup.m
//  CMToolDemo
//
//  Created by Joehuitan on 2018/1/18.
//  Copyright © 2018年 chinaMobile. All rights reserved.
//

#import "CMPhotoGroup.h"
#import "CMPhotoALAssets.h"

@implementation CMPhotoGroup

- (instancetype)initWithGroupName:(NSString *)groupName groupIcon:(UIImage *)groupIcon {
    if (self = [super init]) {
        _groupName = groupName;
        _groupIcon = groupIcon;
        _photoALAssets = [NSMutableArray array];
    }
    return self;
}

+ (instancetype)photGroupWithGroupName:(NSString *)groupName groupIcon:(UIImage *)groupIcon {
    return [[self alloc] initWithGroupName: groupName groupIcon: groupIcon];
}

@end
