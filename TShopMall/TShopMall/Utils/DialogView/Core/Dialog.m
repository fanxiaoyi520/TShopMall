//
//  Dialog.m
//  TCLPlus
//
//  Created by OwenChen on 2020/8/18.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import "Dialog.h"


@implementation DialogPriorityModel

+ (DialogPriorityModel *)createDialogPriorityModelWithDialogView:(DialogView *)dialogView {
    DialogPriorityModel *model = [[DialogPriorityModel alloc] init];
    model.dialogView = dialogView;
    model.priorityType = DialogPriorityS;
    model.priorityValue = @(0);
    return model;
}

+ (DialogPriorityModel *)createDialogPriorityModelWithDialogView:(DialogView *)dialogView
                                                    priorityType:(DialogPriorityType)priorityType
                                                   priorityValue:(NSNumber *)priorityValue {
    DialogPriorityModel *model = [[DialogPriorityModel alloc] init];
    model.dialogView = dialogView;
    model.priorityType = priorityType;
    model.priorityValue = priorityValue ? priorityValue : @(0);
    return model;
}

- (void)setDialogView:(DialogView *)dialogView {
    _dialogView = dialogView;

    if (_dialogView) {
        self.status = DialogStatusReady;
    } else {
        self.status = DialogStatusUnknown;
    }
}

@end


@interface Dialog ()

@property (nonatomic, strong) NSMutableArray<DialogPriorityModel *> *prioritySArray;
@property (nonatomic, strong) NSMutableArray<DialogPriorityModel *> *priorityAArray;
@property (nonatomic, strong) NSMutableArray<DialogPriorityModel *> *priorityBArray;
@property (nonatomic, strong) NSMutableArray<DialogPriorityModel *> *priorityCArray;
@property (nonatomic, strong) NSArray *allPriorityArray;
@property (nonatomic, strong) DialogPriorityModel *currentPriorityModel;

@end


@implementation Dialog

#pragma mark - 单例
+ (instancetype)sharedInstance {
    static Dialog *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[Dialog alloc] init];
        _instance.animationType = ShowAnimationFade;
        _instance.bounce = YES;
    });
    return _instance;
}

#pragma mark - Public Methods
/// 添加一个弹框
+ (void)addDialogView:(DialogView *)dialogView
       dialogPriority:(DialogPriorityType)priorityType
        priorityValue:(NSNumber *)priorityValue {
    [[Dialog sharedInstance] addDialogView:dialogView dialogPriority:priorityType priorityValue:priorityValue];
    [[Dialog sharedInstance] checkCurrentPriorityModel];
}

/// 添加一个弹框（priorityType 为 DialogPriorityA， priorityValue 为0）
+ (void)addDialogView:(DialogView *)dialogView {
    [[Dialog sharedInstance] addDialogView:dialogView dialogPriority:DialogPriorityA priorityValue:@(0)];
    [[Dialog sharedInstance] checkCurrentPriorityModel];
}

/// 添加多个弹框（priorityType 为 DialogPriorityA， priorityValue 为0），依次弹出
+ (void)addDialogViews:(NSArray<DialogView *> *)dialogViews {
    NSMutableArray<DialogPriorityModel *> *models = [NSMutableArray array];
    for (NSInteger i = 0; i < dialogViews.count; i++) {
        DialogPriorityModel *priorityModel = [DialogPriorityModel createDialogPriorityModelWithDialogView:[dialogViews objectAtIndex:i]
                                                                                             priorityType:DialogPriorityA
                                                                                            priorityValue:@(0)];
        [models addObject:priorityModel];
    }
    [[Dialog sharedInstance] addDialogPriorityModels:models];
    [[Dialog sharedInstance] checkCurrentPriorityModel];
}

/// 添加多个弹框模型
+ (void)addDialogPriorityModels:(NSArray<DialogPriorityModel *> *)priorityModels {
    [[Dialog sharedInstance] addDialogPriorityModels:priorityModels];
    [[Dialog sharedInstance] checkCurrentPriorityModel];
}

/// 移除所有弹框
+ (void)removeAllDialog {
    [[Dialog sharedInstance] removeAllDialog];
}

/// 移除指定弹框
+ (void)removeDialogWithTag:(NSInteger)tag {
    [[Dialog sharedInstance] removeDialogWithTag:tag];
}

#pragma mark - Private Methods
/// 添加一个弹框
- (void)addDialogView:(DialogView *)dialogView
       dialogPriority:(DialogPriorityType)priorityType
        priorityValue:(NSNumber *)priorityValue {
    DialogPriorityModel *priorityModel = [DialogPriorityModel createDialogPriorityModelWithDialogView:dialogView priorityType:priorityType
                                                                                        priorityValue:priorityValue];

    [self addDialogPriorityModel:priorityModel];
}

- (void)addDialogPriorityModel:(DialogPriorityModel *)priorityModel {
    NSMutableArray<DialogPriorityModel *> *priorityArray;
    switch (priorityModel.priorityType) {
        case DialogPriorityS:
            priorityArray = self.prioritySArray;
            break;
        case DialogPriorityA:
            priorityArray = self.priorityAArray;
            break;
        case DialogPriorityB:
            priorityArray = self.priorityBArray;
            break;
        case DialogPriorityC:
            priorityArray = self.priorityCArray;
            break;
        default:
            break;
    }

    [self insertPriorityArray:priorityArray withPriorityModel:priorityModel];
}

- (void)addDialogPriorityModels:(NSArray<DialogPriorityModel *> *)priorityModels {
    for (NSInteger i = 0; i < priorityModels.count; i++) {
        DialogPriorityModel *model = [priorityModels objectAtIndex:i];
        [self addDialogPriorityModel:model];
    }
}

- (void)insertPriorityArray:(NSMutableArray<DialogPriorityModel *> *)priorityArray withPriorityModel:(DialogPriorityModel *)priorityModel {
    @synchronized(self) {
        if (!priorityArray || ![priorityArray isKindOfClass:[NSMutableArray class]] || !priorityModel) {
            return;
        }

        priorityModel.dialogView.hidden = YES;

        if (priorityArray.count == 0) {
            [priorityArray addObject:priorityModel];
        } else {
            for (NSInteger i = 0; i < priorityArray.count; i++) {
                DialogPriorityModel *existModel = [priorityArray objectAtIndex:i];
                if ([existModel.priorityValue floatValue] < [priorityModel.priorityValue floatValue]) {
                    [priorityArray insertObject:priorityModel atIndex:i];
                    break;
                } else if (i == priorityArray.count - 1) {
                    [priorityArray addObject:priorityModel];
                    break;
                }
            }
        }
    }
}

- (void)checkCurrentPriorityModel {
    @synchronized(self) {
        for (NSInteger i = 0; i < self.allPriorityArray.count; i++) {
            NSMutableArray<DialogPriorityModel *> *priorityArray = [self.allPriorityArray objectAtIndex:i];
            if (priorityArray.count > 0) {
                DialogPriorityModel *priorityModel = [priorityArray firstObject];

                if (priorityModel != self.currentPriorityModel) {
                    if (self.currentPriorityModel) {
                        [self.currentPriorityModel.dialogView closeDialogViewWithHoldInQueue:YES];
                    }

                    self.currentPriorityModel = priorityModel;
                    [self.currentPriorityModel.dialogView showDialogView];
                }

                __weak typeof(self) weakSelf = self;
                self.currentPriorityModel.dialogView.unholdInQueueBlock = ^{
                    [weakSelf deleteFirstPriorityModelAtIndex:i];
                    weakSelf.currentPriorityModel = nil;
                    [weakSelf checkCurrentPriorityModel];
                };

                break;
            }
        }
    }
}

- (void)deleteFirstPriorityModelAtIndex:(NSInteger)index {
    @synchronized(self) {
        if (self.allPriorityArray.count >= index + 1) {
            NSMutableArray<DialogPriorityModel *> *array = [self.allPriorityArray objectAtIndex:index];
            if (array.count > 0) {
                [array removeObjectAtIndex:0];
            }
        }
    }
}

- (void)removeAllDialog {
    @synchronized(self) {
        for (NSMutableArray<DialogPriorityModel *> *models in self.allPriorityArray) {
            for (DialogPriorityModel *model in models) {
                [model.dialogView closeDialogViewWithAnimation:NO holdInQueue:NO];
            }

            [models removeAllObjects];
        }

        self.currentPriorityModel = nil;
    }
}

- (void)removeDialogWithTag:(NSInteger)tag {
    @synchronized(self) {
        for (NSMutableArray<DialogPriorityModel *> *models in self.allPriorityArray) {
            NSMutableArray<DialogPriorityModel *> *needRemove = [NSMutableArray array];
            for (DialogPriorityModel *model in models) {
                if (model.dialogView.tag == tag) {
                    [model.dialogView closeDialogViewWithAnimation:NO holdInQueue:NO];

                    [needRemove addObject:model];
                }
            }

            [models removeObjectsInArray:[needRemove copy]];
        }

        if (self.currentPriorityModel.dialogView.tag == tag) {
            self.currentPriorityModel = nil;
        }
    }
}

#pragma mark - Lazy Loading Methods
- (NSMutableArray<DialogPriorityModel *> *)prioritySArray {
    if (!_prioritySArray) {
        _prioritySArray = [NSMutableArray array];
    }
    return _prioritySArray;
}

- (NSMutableArray<DialogPriorityModel *> *)priorityAArray {
    if (!_priorityAArray) {
        _priorityAArray = [NSMutableArray array];
    }
    return _priorityAArray;
}

- (NSMutableArray<DialogPriorityModel *> *)priorityBArray {
    if (!_priorityBArray) {
        _priorityBArray = [NSMutableArray array];
    }
    return _priorityBArray;
}

- (NSMutableArray<DialogPriorityModel *> *)priorityCArray {
    if (!_priorityCArray) {
        _priorityCArray = [NSMutableArray array];
    }
    return _priorityCArray;
}

- (NSArray *)allPriorityArray {
    if (!_allPriorityArray) {
        _allPriorityArray = @[self.prioritySArray, self.priorityAArray, self.priorityBArray, self.priorityCArray];
    }
    return _allPriorityArray;
}

@end
