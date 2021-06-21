//
//  UIImage+Extension.h
//  TCLPlus
//
//  Created by kobe on 2020/9/19.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface UIImage (Extension)

+ (UIImage *)originImage:(UIImage *)image scaleToSize:(CGSize)size;

+ (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect;

+ (UIImage *)blurImage:(UIImage *)image blurLevel:(CGFloat)blur;

+ (UIImage *)blurImage:(UIImage *)image;

+ (NSData *)compressImageData:(NSData *)imageData length:(NSInteger)lenght;

@end

NS_ASSUME_NONNULL_END
