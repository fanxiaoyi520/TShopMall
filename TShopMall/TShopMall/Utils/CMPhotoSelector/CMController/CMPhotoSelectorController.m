//
//  CMPhotoSelectorController.m
//  CMToolDemo
//
//  Created by Joehuitan on 2018/1/18.
//  Copyright © 2018年 chinaMobile. All rights reserved.
//

#import "CMPhotoSelectorController.h"
#import "CMPhotoGroupsController.h"

@interface CMPhotoSelectorController ()
/** 是否是多选 */
@property (nonatomic, assign, getter=isMultiSelection) BOOL multiSelection;
/** 如果是多选的话，最多选择多少张 */
@property (nonatomic, assign) NSInteger maxCount;
/** 子控制器 */
@property (nonatomic, strong) CMPhotoGroupsController *photoGroupsController;

@end

@implementation CMPhotoSelectorController

- (CMPhotoGroupsController *)photoGroupsController {
    if (_photoGroupsController == nil) {
        _photoGroupsController = [[CMPhotoGroupsController alloc] init];
    }
    return _photoGroupsController;
}

- (instancetype)initWithMultiSelection:(BOOL)isMultiSelection maxCount:(NSInteger)maxCount {
    if (self = [super init]) {
        _multiSelection = isMultiSelection;
        _maxCount = maxCount;
        self.photoGroupsController.multiSelection = isMultiSelection;
        if (_multiSelection == NO) {
            _maxCount = 1;
        }
        self.photoGroupsController.maxCount = maxCount;
    }
    return [self initWithRootViewController:self.photoGroupsController];
}

+ (instancetype)photoSelectorController {
    
    return [[self alloc] initWithMultiSelection:NO maxCount:1];
}

+ (instancetype)photoSelectorControllerWithMultiSelection:(BOOL)isMultiSelection maxCount:(NSInteger)maxCount {
    return [[self alloc] initWithMultiSelection:isMultiSelection maxCount:maxCount];
}

@end
