//
//  CMPhotoGroup.h
//  CMToolDemo
//
//  Created by Joehuitan on 2018/1/18.
//  Copyright © 2018年 chinaMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CMPhotoALAssets;

@interface CMPhotoGroup : NSObject
/** 相册名称 */
@property (nonatomic, strong) NSString *groupName;
/** 相册图标 */
@property (nonatomic, strong) UIImage *groupIcon;
/** 相册里照片集合 */
@property (nonatomic, strong) NSMutableArray<CMPhotoALAssets *> *photoALAssets;

+ (instancetype)photGroupWithGroupName:(NSString *)groupName groupIcon:(UIImage *)groupIcon;

- (instancetype)initWithGroupName:(NSString *)groupName groupIcon:(UIImage *)groupIcon;

@end
