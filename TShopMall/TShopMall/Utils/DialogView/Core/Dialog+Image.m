//
//  Dialog+Image.m
//  TCLPlus
//
//  Created by OwenChen on 2021/1/4.
//  Copyright © 2021 TCL Electronics Holdings Ltd. All rights reserved.
//

#import "DialogModelEditor.h"

#import "Dialog+Common.h"
#import "Dialog+Image.h"


@implementation Dialog (Image)

/// 显示普通标题和副标题（顶部有icon图片）
+ (DialogView *)showDialogWithTopIcon:(UIImage *)topIcon
                              bigIcon:(BOOL)bigIcon
                                title:(NSString *)title
                             subtitle:(NSString *)subtitle
                              buttons:(NSArray<NSString *> *)buttons
                          resultBlock:(ResultBlock)resultBlock {
    DialogView *view = [self dialogWithTopIcon:topIcon bigIcon:bigIcon title:title subtitle:subtitle buttons:buttons resultBlock:resultBlock];

    [self addDialogView:view];

    return view;
}

/// 显示普通标题和副标题（副标题是富文本， 顶部icon图片）
+ (DialogView *)showDialogWithTopIcon:(UIImage *)topIcon
                              bigIcon:(BOOL)bigIcon
                                title:(NSString *)title
                   attributedSubtitle:(NSAttributedString *)attributedSubtitle
                              buttons:(NSArray<NSString *> *)buttons
                          resultBlock:(ResultBlock)resultBlock {
    DialogView *view = [self dialogWithTopIcon:topIcon bigIcon:bigIcon title:title attributedSubtitle:attributedSubtitle buttons:buttons resultBlock:resultBlock];

    [self addDialogView:view];

    return view;
}

/// 显示本地图片弹框
+ (DialogView *)showImageDialogWithTitle:(NSString *)title
                                subtitle:(NSString *)subtitle
                                   image:(UIImage *)image
                                 buttons:(NSArray<NSString *> *)buttons
                             resultBlock:(ResultBlock)resultBlock {
    DialogView *view = [Dialog imageDialogWithTitle:title subtitle:subtitle image:image buttons:buttons imageFitWidth:NO resultBlock:resultBlock];

    [self addDialogView:view];

    return view;
}

/// 显示本地图片弹框（图片宽度适应组件）
+ (DialogView *)showFitWidthImageDialogWithTitle:(NSString *)title
                                        subtitle:(NSString *)subtitle
                                           image:(UIImage *)image
                                         buttons:(NSArray<NSString *> *)buttons
                                     resultBlock:(ResultBlock)resultBlock {
    DialogView *view = [Dialog imageDialogWithTitle:title subtitle:subtitle image:image buttons:buttons imageFitWidth:YES resultBlock:resultBlock];

    [self addDialogView:view];

    return view;
}

/// 显示网络图片弹框
+ (DialogView *)showImageDialogWithTitle:(NSString *)title
                                subtitle:(NSString *)subtitle
                                imageUrl:(NSString *)imageUrl
                              imageWidth:(CGFloat)imageWidth
                             imageHeight:(CGFloat)imageHeight
                                 buttons:(NSArray<NSString *> *)buttons
                             resultBlock:(ResultBlock)resultBlock {
    DialogView *view = [Dialog imageDialogWithTitle:title subtitle:subtitle imageUrl:imageUrl imageWidth:imageWidth imageHeight:imageHeight buttons:buttons
                                      imageFitWidth:NO
                                        resultBlock:resultBlock];

    [self addDialogView:view];

    return view;
}

/// 显示网络图片弹框（图片宽度适应组件）
+ (DialogView *)showFitWidthImageDialogWithTitle:(NSString *)title
                                        subtitle:(NSString *)subtitle
                                        imageUrl:(NSString *)imageUrl
                                      imageWidth:(CGFloat)imageWidth
                                     imageHeight:(CGFloat)imageHeight
                                         buttons:(NSArray<NSString *> *)buttons
                                     resultBlock:(ResultBlock)resultBlock {
    DialogView *view = [Dialog imageDialogWithTitle:title subtitle:subtitle imageUrl:imageUrl imageWidth:imageWidth imageHeight:imageHeight buttons:buttons
                                      imageFitWidth:YES
                                        resultBlock:resultBlock];

    [self addDialogView:view];

    return view;
}

/// 显示网络图片弹框--图片在最上
+ (DialogView *)showImageDialogWithImageUrl:(NSString *)imageUrl
                                placeholder:(UIImage *)placeholder
                                      Title:(NSString *)title
                                   subtitle:(NSString *)subtitle
                          imageWithTitleGap:(CGFloat)imageWithTitleGap
                       titleWithSubTitleGap:(CGFloat)titleWithSubTitleGap
                                 imageWidth:(CGFloat)imageWidth
                                imageHeight:(CGFloat)imageHeight
                                    buttons:(NSArray<NSString *> *)buttons
                                resultBlock:(ResultBlock)resultBlock {
    DialogView *view = [self imageDialogWithImageUrl:imageUrl placeholder:placeholder Title:title subtitle:subtitle imageWithTitleGap:imageWithTitleGap
                                titleWithSubTitleGap:titleWithSubTitleGap
                                          imageWidth:imageWidth
                                         imageHeight:imageHeight
                                             buttons:buttons
                                         resultBlock:resultBlock];

    [self addDialogView:view];

    return view;
}

/// 普通标题和副标题（顶部有icon图片）
+ (DialogView *)dialogWithTopIcon:(UIImage *)topIcon
                          bigIcon:(BOOL)bigIcon
                            title:(NSString *)title
                         subtitle:(NSString *)subtitle
                          buttons:(NSArray<NSString *> *)buttons
                      resultBlock:(ResultBlock)resultBlock {
    if (topIcon) {
        NSMutableArray *array = [NSMutableArray array];

        CGSize imageSize = bigIcon ? topIcon.size : CGSizeMake(34.0, 34.0);
        ImageDialogModel *imageModel = [DialogModelEditor createImageDialogModelWithImage:topIcon imageSize:imageSize imageFitWidth:bigIcon];
        [array addObject:imageModel];

        TextDialogModel *textModel;
        if (title.length > 0) {
            textModel = [DialogModelEditor createTextDialogModelWithTitle:title titleColor:nil];
            [array addObject:textModel];
        }

        TextDialogModel *textModel1;
        if (subtitle.length > 0) {
            textModel1 = [DialogModelEditor createTextDialogModelWithSubtitle:subtitle subtitleColor:nil];
            [array addObject:textModel1];
        }

        [DialogModelEditor createModelMarginWithModels:array existTitle:title.length > 0];

        if (buttons.count > 0) {
            ButtonsDialogModel *buttonsModel = [DialogModelEditor createButtonsDialogModelWithButtons:buttons buttonColors:nil];
            [array addObject:buttonsModel];
        }

        if (bigIcon) {
            imageModel.margin = UIEdgeInsetsMake(0, 0, 0, 0);

            UIEdgeInsets textModelMargin = textModel.margin;
            textModelMargin.top = 25.0;
            textModel.margin = textModelMargin;

            UIEdgeInsets textModel1Margin = textModel1.margin;
            textModel1Margin.top = 12.0;
            textModel1.margin = textModel1Margin;
        }

        DialogView *view = [[DialogView alloc] initWithDialogModels:array animation:[Dialog sharedInstance].animationType position:DialogPositionMiddle
                                                            sideTap:YES
                                                             bounce:YES];
        view.resultBlock = resultBlock;

        return view;
    } else {
        return [Dialog dialogWithTitle:title subtitle:subtitle buttons:buttons resultBlock:resultBlock];
    }
}

/// 普通标题和副标题（副标题是富文本， 顶部icon图片）
+ (DialogView *)dialogWithTopIcon:(UIImage *)topIcon
                          bigIcon:(BOOL)bigIcon
                            title:(NSString *)title
               attributedSubtitle:(NSAttributedString *)attributedSubtitle
                          buttons:(NSArray<NSString *> *)buttons
                      resultBlock:(ResultBlock)resultBlock {
    if (topIcon) {
        NSMutableArray *array = [NSMutableArray array];

        CGSize imageSize = bigIcon ? topIcon.size : CGSizeMake(34.0, 34.0);
        ImageDialogModel *imageModel = [DialogModelEditor createImageDialogModelWithImage:topIcon imageSize:imageSize imageFitWidth:bigIcon];
        [array addObject:imageModel];

        TextDialogModel *textModel;
        if (title.length > 0) {
            textModel = [DialogModelEditor createTextDialogModelWithTitle:title titleColor:nil];
            [array addObject:textModel];
        }

        TextDialogModel *textModel1;
        if (attributedSubtitle.string.length > 0) {
            textModel1 = [DialogModelEditor createTextDialogModelWithAttributedSubtitle:attributedSubtitle subtitleColor:nil];
            [array addObject:textModel1];
        }

        [DialogModelEditor createModelMarginWithModels:array existTitle:title.length > 0];

        if (buttons.count > 0) {
            ButtonsDialogModel *buttonsModel = [DialogModelEditor createButtonsDialogModelWithButtons:buttons buttonColors:nil];
            [array addObject:buttonsModel];
        }

        if (bigIcon) {
            imageModel.margin = UIEdgeInsetsMake(0, 0, 0, 0);

            UIEdgeInsets textModelMargin = textModel.margin;
            textModelMargin.top = 25.0;
            textModel.margin = textModelMargin;

            UIEdgeInsets textModel1Margin = textModel1.margin;
            textModel1Margin.top = 12.0;
            textModel1.margin = textModel1Margin;
        }

        DialogView *view = [[DialogView alloc] initWithDialogModels:array animation:[Dialog sharedInstance].animationType position:DialogPositionMiddle
                                                            sideTap:YES
                                                             bounce:YES];
        view.resultBlock = resultBlock;

        return view;
    } else {
        return [Dialog dialogWithTitle:title attributedSubtitle:attributedSubtitle buttons:buttons resultBlock:resultBlock];
    }
}

/// 本地图片弹框
+ (DialogView *)imageDialogWithTitle:(NSString *)title
                            subtitle:(NSString *)subtitle
                               image:(UIImage *)image
                             buttons:(NSArray<NSString *> *)buttons
                         resultBlock:(ResultBlock)resultBlock {
    DialogView *view = [Dialog imageDialogWithTitle:title subtitle:subtitle image:image buttons:buttons imageFitWidth:NO resultBlock:resultBlock];

    return view;
}

/// 本地图片弹框（图片宽度适应组件）
+ (DialogView *)fitWidthImageDialogWithTitle:(NSString *)title
                                    subtitle:(NSString *)subtitle
                                       image:(UIImage *)image
                                     buttons:(NSArray<NSString *> *)buttons
                                 resultBlock:(ResultBlock)resultBlock {
    DialogView *view = [Dialog imageDialogWithTitle:title subtitle:subtitle image:image buttons:buttons imageFitWidth:YES resultBlock:resultBlock];

    return view;
}

/// 网络图片弹框
+ (DialogView *)imageDialogWithTitle:(NSString *)title
                            subtitle:(NSString *)subtitle
                            imageUrl:(NSString *)imageUrl
                          imageWidth:(CGFloat)imageWidth
                         imageHeight:(CGFloat)imageHeight
                             buttons:(NSArray<NSString *> *)buttons
                         resultBlock:(ResultBlock)resultBlock {
    DialogView *view = [Dialog imageDialogWithTitle:title subtitle:subtitle imageUrl:imageUrl imageWidth:imageWidth imageHeight:imageHeight buttons:buttons
                                      imageFitWidth:NO
                                        resultBlock:resultBlock];

    return view;
}

/// 网络图片弹框（图片宽度适应组件）
+ (DialogView *)fitWidthImageDialogWithTitle:(NSString *)title
                                    subtitle:(NSString *)subtitle
                                    imageUrl:(NSString *)imageUrl
                                  imageWidth:(CGFloat)imageWidth
                                 imageHeight:(CGFloat)imageHeight
                                     buttons:(NSArray<NSString *> *)buttons
                                 resultBlock:(ResultBlock)resultBlock {
    DialogView *view = [Dialog imageDialogWithTitle:title subtitle:subtitle imageUrl:imageUrl imageWidth:imageWidth imageHeight:imageHeight buttons:buttons
                                      imageFitWidth:YES
                                        resultBlock:resultBlock];

    return view;
}


/// 网络图片弹框--图片在最上
+ (DialogView *)imageDialogWithImageUrl:(NSString *)imageUrl
                            placeholder:(UIImage *)placeholder
                                  Title:(NSString *)title
                               subtitle:(NSString *)subtitle
                      imageWithTitleGap:(CGFloat)imageWithTitleGap
                   titleWithSubTitleGap:(CGFloat)titleWithSubTitleGap
                             imageWidth:(CGFloat)imageWidth
                            imageHeight:(CGFloat)imageHeight
                                buttons:(NSArray<NSString *> *)buttons
                            resultBlock:(ResultBlock)resultBlock {
    NSMutableArray *array = [NSMutableArray array];
    if (imageWidth > 0 && imageHeight > 0) {
        ImageDialogModel *model = [DialogModelEditor createImageDialogModelWithImageUrl:imageUrl placeholder:placeholder
                                                                              imageSize:CGSizeMake(imageWidth, imageHeight)
                                                                          imageFitWidth:NO];
        model.margin = UIEdgeInsetsMake(TopGapWithTile, LeftGap, imageWithTitleGap, RightGap);

        [array addObject:model];
    }
    if (title.length > 0) {
        TextDialogModel *textModel = [DialogModelEditor createTextDialogModelWithTitle:title titleColor:nil];
        textModel.margin = UIEdgeInsetsMake(0, LeftGap, titleWithSubTitleGap, RightGap);
        [array addObject:textModel];
    }

    if (subtitle.length > 0) {
        TextDialogModel *textModel1 = [DialogModelEditor createTextDialogModelWithSubtitle:subtitle subtitleColor:nil];
        textModel1.margin = UIEdgeInsetsMake(0, LeftGap, 20, RightGap);
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

#pragma mark - Private Mehotds
/// 显示本地图片弹框
+ (DialogView *)imageDialogWithTitle:(NSString *)title
                            subtitle:(NSString *)subtitle
                               image:(UIImage *)image
                             buttons:(NSArray<NSString *> *)buttons
                       imageFitWidth:(BOOL)imageFitWidth
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

    if (image) {
        ImageDialogModel *model = [DialogModelEditor createImageDialogModelWithImage:image imageSize:image.size imageFitWidth:imageFitWidth];
        [array addObject:model];
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

/// 显示网络图片弹框
+ (DialogView *)imageDialogWithTitle:(NSString *)title
                            subtitle:(NSString *)subtitle
                            imageUrl:(NSString *)imageUrl
                          imageWidth:(CGFloat)imageWidth
                         imageHeight:(CGFloat)imageHeight
                             buttons:(NSArray<NSString *> *)buttons
                       imageFitWidth:(BOOL)imageFitWidth
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

    if (imageUrl.length > 0 && imageWidth > 0 && imageHeight > 0) {
        ImageDialogModel *model = [DialogModelEditor createImageDialogModelWithImageUrl:imageUrl placeholder:nil imageSize:CGSizeMake(imageWidth, imageHeight)
                                                                          imageFitWidth:imageFitWidth];
        [array addObject:model];
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
