//
//  CMPhotoGroupsViewModel.h
//  CMToolDemo
//
//  Created by Joehuitan on 2018/1/18.
//  Copyright © 2018年 chinaMobile. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@class CMPhotoGroup, CMPhotoALAssets;

@interface CMPhotoGroupsViewModel : NSObject

interfaceSingleton(CMPhotoGroupsViewModel);
/** 已选中的图片 */
@property (nonatomic, strong) NSMutableArray<CMPhotoALAssets *> *selectedPhotoImages;

- (void)getAllPhotoGroupsWithCompletedBlock:(void(^)(NSArray<CMPhotoGroup *> *dataSource))completionBlock unAuthorizedStatus:(void(^)(void))unAuthorizedBlock;

@end
