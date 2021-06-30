//
//  CMPhotoSelectorController.h
//  CMToolDemo
//
//  Created by Joehuitan on 2018/1/18.
//  Copyright © 2018年 chinaMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CMPhotoSelectorController, CMPhotoALAssets;

@protocol CMPhotoSelectorControllerDelegate<NSObject>

@required
- (void)finishMultiSelectionWithData:(NSArray<CMPhotoALAssets *> *)photoAssets;

- (void)finishSingleSelectionWithImage:(UIImage *)image;

@end

@interface CMPhotoSelectorController : UINavigationController
/** 代理 */
@property (nonatomic, weak) id<CMPhotoSelectorControllerDelegate> selectorDelegate;

- (instancetype)initWithMultiSelection:(BOOL)isMultiSelection maxCount:(NSInteger)maxCount;

+ (instancetype)photoSelectorControllerWithMultiSelection:(BOOL)isMultiSelection maxCount:(NSInteger)maxCount;

+ (instancetype)photoSelectorController;

@end
