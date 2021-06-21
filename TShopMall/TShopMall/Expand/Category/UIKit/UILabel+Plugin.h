//
//  UILabel+Plugin.h
//  TCLSmartHome
//
//  Created by LeonDeng on 2019/5/23.
//  Copyright © 2019 TCLIOT. All rights reserved.
//


#import <UIKit/UIKit.h>

#import "UIColor+Plugin.h"
#import "UIFont+Plugin.h"

NS_ASSUME_NONNULL_BEGIN

extern CGFloat const tcl_standardLineSpace18;
extern CGFloat const tcl_standardLineSpace16;
extern CGFloat const tcl_standardLineSpace14;
extern CGFloat const tcl_standardLineSpace13;
extern CGFloat const tcl_standardLineSpace12;
extern CGFloat const tcl_standardLineSpace10;


@interface UILabel (Plugin)


/// Label当前文字的行数
@property (nonatomic, assign, readonly) NSInteger lines;

/**
 设置带行间距的文字

 @param text 文字
 @param lineSpacing 行间距
 */
- (void)setText:(NSString *)text lineSpacing:(CGFloat)lineSpacing;


/**
 初始化使用TCL标准字体的label

 @param fontType 字体
 @param frame 边框
 @return Label
 */
- (instancetype)initWithTCLStandard:(TCLFontType)fontType Frame:(CGRect)frame;

/**
 显示当前文字需要几行
 @return 返回行数
 */
+ (NSArray *)linesArrayOfStringInLabel:(UILabel *)label;

/**
改变字间距
 */
+ (void)changeWordSpaceForLabel:(UILabel *)label WithSpace:(float)space;

@end

NS_ASSUME_NONNULL_END
