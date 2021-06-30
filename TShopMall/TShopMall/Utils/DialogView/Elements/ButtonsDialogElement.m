//
//  ButtonsDialogElement.m
//  TCLPlus
//
//  Created by OwenChen on 2020/8/18.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import "ButtonsDialogElement.h"

#define DefaultTextColor @"#000000"          // 默认文本颜色
#define LineColor @"#DDDDDD"                 // 默认线条颜色
static const CGFloat DefaultFontSize = 15.0; // 默认字体大小
static const CGFloat ButtonHeight = 50.0;
static const CGFloat LineHeight = 0.5;
static const NSInteger basicButtonTag = 777;


@interface ButtonsDialogElement ()


@end


@implementation ButtonsDialogElement

#pragma mark - Setter Methods
- (void)setModel:(BasicDialogModel *)model {
    [super setModel:model];

    ButtonsDialogModel *buttonsModel = (ButtonsDialogModel *)self.model;

    CGFloat fontSize = buttonsModel.fontSize > 0 ? buttonsModel.fontSize : DefaultFontSize;
    CGFloat buttonWidth = CGRectGetWidth(self.frame) / buttonsModel.buttonTitles.count;
    for (NSInteger i = 0; i < buttonsModel.buttonTitles.count; i++) {
        NSString *textColor;
        if (buttonsModel.textColors.count > i) {
            textColor = buttonsModel.textColors[i];
        } else {
            textColor = DefaultTextColor;
        }

        NSString *title = buttonsModel.buttonTitles[i];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(i * buttonWidth, 0, buttonWidth, ButtonHeight);
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:textColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:textColor alpha:0.5] forState:UIControlStateHighlighted];
        [button setTitleColor:[UIColor colorWithHexString:textColor alpha:0.3] forState:UIControlStateDisabled];
        button.titleLabel.font = buttonsModel.bold ? [UIFont boldSystemFontOfSize:fontSize] : [UIFont systemFontOfSize:fontSize];
        [self addSubview:button];
        button.tag = basicButtonTag + i;

        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];

        if (i != buttonsModel.buttonTitles.count - 1) {
            UIView *rightLine = [[UIView alloc] init];
            rightLine.frame = CGRectMake(buttonWidth - LineHeight, 0, LineHeight, ButtonHeight);
            rightLine.backgroundColor = [UIColor colorWithHexString:LineColor];
            [button addSubview:rightLine];
        }
    }

    UIView *topLine = [[UIView alloc] init];
    topLine.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), LineHeight);
    topLine.backgroundColor = [UIColor colorWithHexString:LineColor];
    [self addSubview:topLine];
}

#pragma mark - Target Methods
- (void)clickButton:(UIButton *)sender {
    if (self.clickBlock) {
        self.clickBlock(sender.tag - basicButtonTag);
    }
}

#pragma mark - Public Methods
/** 使某个按钮重新恢复点击事件 */
- (void)enableButtonAtIndex:(NSInteger)buttonIndex {
    UIButton *button = [self viewWithTag:buttonIndex + basicButtonTag];
    button.enabled = YES;
}

/**使某个按钮无法点击。*/
- (void)disabledButtonAtIndex:(NSInteger)buttonIndex {
    UIButton *button = [self viewWithTag:buttonIndex + basicButtonTag];
    button.enabled = NO;
}

#pragma mark - Element Height
+ (CGFloat)elementHeightWithModel:(BasicDialogModel *)model elementWidth:(CGFloat)elementWidth {
    return ButtonHeight;
}

@end
