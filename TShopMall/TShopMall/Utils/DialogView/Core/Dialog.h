//
//  Dialog.h
//  TCLPlus
//
//  Created by OwenChen on 2020/8/18.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DialogView.h"

#ifdef DEBUG
#define DIALOG_LOG(fmt, ...) NSLog((fmt), ##__VA_ARGS__);
#else
#define DIALOG_LOG(...) ;
#endif

// 弹框状态
typedef NS_ENUM(NSInteger, DialogStatus) {
    DialogStatusUnknown = 0,
    DialogStatusReady = 1,
    DialogStatusShown = 2,
    DialogStatusClosed = 3,
};

// 弹框优先级
typedef NS_ENUM(NSInteger, DialogPriorityType) {
    DialogPriorityS = 0,
    DialogPriorityA = 1,
    DialogPriorityB = 2,
    DialogPriorityC = 3,
};


@interface DialogPriorityModel : NSObject

@property (nonatomic, strong) DialogView *dialogView;
@property (nonatomic, assign) DialogPriorityType priorityType;
@property (nonatomic, strong) NSNumber *priorityValue;
@property (nonatomic, assign) DialogStatus status;

/// 根据弹框创建 DialogPriorityModel，（priorityType 为 DialogPriorityS， priorityValue 为0）
/// @param dialogView 弹框
+ (DialogPriorityModel *)createDialogPriorityModelWithDialogView:(DialogView *)dialogView;

/// 创建 DialogPriorityModel
/// @param dialogView 弹框
/// @param priorityType 优先级
/// @param priorityValue 优先值
+ (DialogPriorityModel *)createDialogPriorityModelWithDialogView:(DialogView *)dialogView
                                                    priorityType:(DialogPriorityType)priorityType
                                                   priorityValue:(NSNumber *)priorityValue;

@end


@interface Dialog : NSObject

@property (nonatomic, assign) ShowAnimation animationType;  //弹框动画
@property (nonatomic, assign, getter=isBounce) BOOL bounce; //动画是否有弹性

@property (nonatomic, strong, readonly) NSMutableArray<DialogPriorityModel *> *prioritySArray;
@property (nonatomic, strong, readonly) NSMutableArray<DialogPriorityModel *> *priorityAArray;
@property (nonatomic, strong, readonly) NSMutableArray<DialogPriorityModel *> *priorityBArray;
@property (nonatomic, strong, readonly) NSMutableArray<DialogPriorityModel *> *priorityCArray;
@property (nonatomic, strong, readonly) NSArray *allPriorityArray;

+ (instancetype)sharedInstance;

/// 添加一个弹框
/// @param dialogView 弹框
/// @param priorityType 优先级
/// @param priorityValue 优先值
+ (void)addDialogView:(DialogView *)dialogView
       dialogPriority:(DialogPriorityType)priorityType
        priorityValue:(NSNumber *)priorityValue;

/// 添加一个弹框（priorityType 为 DialogPriorityA， priorityValue 为0）
/// @param dialogView 弹框
+ (void)addDialogView:(DialogView *)dialogView;

/// 添加多个弹框（priorityType 为 DialogPriorityA， priorityValue 为0），依次弹出
/// @param dialogViews 弹框集合
+ (void)addDialogViews:(NSArray<DialogView *> *)dialogViews;

/// 添加多个弹框模型
/// @param priorityModels 弹框模型集合
+ (void)addDialogPriorityModels:(NSArray<DialogPriorityModel *> *)priorityModels;

/// 移除所有弹框
+ (void)removeAllDialog;

/// 移除指定弹框
/// @param tag tag
+ (void)removeDialogWithTag:(NSInteger)tag;


@end
