//
//  CMPhotoALAssets.h
//  CMToolDemo
//
//  Created by Joehuitan on 2018/1/18.
//  Copyright © 2018年 chinaMobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

@interface CMPhotoALAssets : NSObject

@property(nonatomic, strong) PHAsset *photoAsset;
/**
 * 是否是被选择
 */
@property(nonatomic, assign, getter=isSelected) BOOL selected;

- (instancetype)initWithPhotoAsset:(PHAsset *)photoAsset isSelected:(BOOL)selected;

@end
