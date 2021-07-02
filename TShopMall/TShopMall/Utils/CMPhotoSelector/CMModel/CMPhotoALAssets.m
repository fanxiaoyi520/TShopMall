//
//  CMPhotoALAssets.m
//  CMToolDemo
//
//  Created by Joehuitan on 2018/1/18.
//  Copyright © 2018年 chinaMobile. All rights reserved.
//

#import "CMPhotoALAssets.h"

@implementation CMPhotoALAssets

- (instancetype)initWithPhotoAsset:(PHAsset *)photoAsset isSelected:(BOOL)selected {
    if (self = [super init]) {
        _photoAsset = photoAsset;
        _selected = selected;
    }
    return self;
}

@end
