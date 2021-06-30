//
//  Dialog+Common.m
//  TCLPlus
//
//  Created by OwenChen on 2021/1/4.
//  Copyright © 2021 TCL Electronics Holdings Ltd. All rights reserved.
//

#import "DialogModelEditor.h"

#import "Dialog+Common.h"


@implementation Dialog (Common)

/// 显示普通标题和副标题
+ (DialogView *)showDialogWithTitle:(NSString *)title
                           subtitle:(NSString *)subtitle
                            buttons:(NSArray<NSString *> *)buttons
                        resultBlock:(ResultBlock)resultBlock {
    DialogView *view = [self dialogWithTitle:title subtitle:subtitle buttons:buttons resultBlock:resultBlock];
    [self addDialogView:view];
    return view;
}

/// 显示普通标题和副标题（副标题是富文本）
+ (DialogView *)showDialogWithTitle:(NSString *)title
                 attributedSubtitle:(NSAttributedString *)attributedSubtitle
                            buttons:(NSArray<NSString *> *)buttons
                        resultBlock:(ResultBlock)resultBlock {
    DialogView *view = [self dialogWithTitle:title attributedSubtitle:attributedSubtitle buttons:buttons resultBlock:resultBlock];
    [self addDialogView:view];

    return view;
}

/// 普通标题和副标题
+ (DialogView *)dialogWithTitle:(NSString *)title
                       subtitle:(NSString *)subtitle
                        buttons:(NSArray<NSString *> *)buttons
                    resultBlock:(ResultBlock)resultBlock {
    NSMutableArray *array = [NSMutableArray array];
    if (title.length > 0) {
        TextDialogModel *textModel = [DialogModelEditor createTextDialogModelWithTitle:title titleColor:nil];
        [array addObject:textModel];
    }

    if (subtitle.length > 0) {
        TextDialogModel *textModel1 = [DialogModelEditor createTextDialogModelWithSubtitle:subtitle subtitleColor:nil];
        [array addObject:textModel1];
    }

    [DialogModelEditor createModelMarginWithModels:array existTitle:title.length > 0];

    if (buttons.count > 0) {
        ButtonsDialogModel *buttonsModel = [DialogModelEditor createButtonsDialogModelWithButtons:buttons buttonColors:nil];
        [array addObject:buttonsModel];
    }

    DialogView *view = [[DialogView alloc] initWithDialogModels:array animation:[Dialog sharedInstance].animationType position:DialogPositionMiddle sideTap:YES
                                                         bounce:YES];
    view.resultBlock = resultBlock;

    return view;
}

/// 普通标题和副标题（副标题是富文本）
+ (DialogView *)dialogWithTitle:(NSString *)title
             attributedSubtitle:(NSAttributedString *)attributedSubtitle
                        buttons:(NSArray<NSString *> *)buttons
                    resultBlock:(ResultBlock)resultBlock {
    NSMutableArray *array = [NSMutableArray array];
    if (title.length > 0) {
        TextDialogModel *textModel = [DialogModelEditor createTextDialogModelWithTitle:title titleColor:nil];
        [array addObject:textModel];
    }

    if (attributedSubtitle.string.length > 0) {
        TextDialogModel *textModel1 = [DialogModelEditor createTextDialogModelWithAttributedSubtitle:attributedSubtitle subtitleColor:nil];
        [array addObject:textModel1];
    }

    [DialogModelEditor createModelMarginWithModels:array existTitle:title.length > 0];

    if (buttons.count > 0) {
        ButtonsDialogModel *buttonsModel = [DialogModelEditor createButtonsDialogModelWithButtons:buttons buttonColors:nil];
        [array addObject:buttonsModel];
    }

    DialogView *view = [[DialogView alloc] initWithDialogModels:array animation:[Dialog sharedInstance].animationType position:DialogPositionMiddle sideTap:YES
                                                         bounce:YES];
    view.resultBlock = resultBlock;

    return view;
}

@end
