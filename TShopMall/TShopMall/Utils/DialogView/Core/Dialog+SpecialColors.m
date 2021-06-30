//
//  Dialog+SpecialColors.m
//  TCLPlus
//
//  Created by OwenChen on 2021/1/4.
//  Copyright © 2021 TCL Electronics Holdings Ltd. All rights reserved.
//

#import "DialogModelEditor.h"

#import "Dialog+SpecialColors.h"


@implementation Dialog (SpecialColors)

/// 显示普通标题和副标题（颜色自定义）
+ (DialogView *)showDialogWithTitle:(NSString *)title
                         titleColor:(NSString *)titleColor
                           subtitle:(NSString *)subtitle
                      subtitleColor:(NSString *)subtitleColor
                            buttons:(NSArray<NSString *> *)buttons
                       buttonColors:(NSArray<NSString *> *)buttonColors
                        resultBlock:(ResultBlock)resultBlock {
    DialogView *view = [self dialogWithTitle:title titleColor:titleColor subtitle:subtitle subtitleColor:subtitleColor buttons:buttons buttonColors:buttonColors
                                 resultBlock:resultBlock];

    [self addDialogView:view];

    return view;
}

/// 普通标题和副标题（颜色自定义）
+ (DialogView *)dialogWithTitle:(NSString *)title
                     titleColor:(NSString *)titleColor
                       subtitle:(NSString *)subtitle
                  subtitleColor:(NSString *)subtitleColor
                        buttons:(NSArray<NSString *> *)buttons
                   buttonColors:(NSArray<NSString *> *)buttonColors
                    resultBlock:(ResultBlock)resultBlock {
    NSMutableArray *array = [NSMutableArray array];
    if (title.length > 0) {
        TextDialogModel *textModel = [DialogModelEditor createTextDialogModelWithTitle:title titleColor:titleColor];
        [array addObject:textModel];
    }

    if (subtitle.length > 0) {
        TextDialogModel *textModel1 = [DialogModelEditor createTextDialogModelWithSubtitle:subtitle subtitleColor:subtitleColor];
        [array addObject:textModel1];
    }

    [DialogModelEditor createModelMarginWithModels:array existTitle:title.length > 0];

    if (buttons.count > 0) {
        ButtonsDialogModel *buttonsModel = [DialogModelEditor createButtonsDialogModelWithButtons:buttons buttonColors:buttonColors];
        [array addObject:buttonsModel];
    }

    DialogView *view = [[DialogView alloc] initWithDialogModels:array animation:[Dialog sharedInstance].animationType position:DialogPositionMiddle sideTap:YES
                                                         bounce:YES];
    view.resultBlock = resultBlock;

    return view;
}

@end
