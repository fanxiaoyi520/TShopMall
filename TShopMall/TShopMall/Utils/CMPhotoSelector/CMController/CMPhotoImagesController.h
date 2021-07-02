//
//  CMPhotoImagesController.h
//  CMToolDemo
//
//  Created by Joehuitan on 2018/1/19.
//  Copyright © 2018年 chinaMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CMPhotoALAssets;

@interface CMPhotoImagesController : UICollectionViewController
/** 是否是多选 */
@property (nonatomic, assign, getter=isMultiSelection) BOOL multiSelection;
/** 如果是多选的话，最多选择多少张 */
@property (nonatomic, assign) NSInteger maxCount;
/** 数据源 */
@property (nonatomic, strong) NSArray<CMPhotoALAssets *> *dataSource;

@end
