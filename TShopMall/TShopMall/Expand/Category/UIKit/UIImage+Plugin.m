//
//  UIImage+Plugin.m
//  TCLSmartHome
//
//  Created by LeonDeng on 2019/5/31.
//  Copyright © 2019 TCLIOT. All rights reserved.
//

#import "UIImage+Plugin.h"


@implementation UIImage (Plugin)

+ (UIImage *)imageScreenShot {
    CGSize size = [UIScreen mainScreen].bounds.size;
    CGFloat scale = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContextWithOptions(size, YES, scale);
    [[UIApplication sharedApplication].keyWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);

    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIImage *)getImageFromURL:(NSString *)fileURL {
    UIImage *result;
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    return result;
}

- (UIImage *)drawRectWithRoundedCorner:(CGFloat)radius Size:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);

    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:rect byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(radius, radius)];
    CGContextAddPath(ctx, path.CGPath);
    CGContextClip(ctx);
    [self drawInRect:rect];
    CGContextDrawPath(ctx, kCGPathFillStroke);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)imageWithView:(UIView *)view Translucent:(BOOL)translucent {
    CGSize size = view.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(size, !translucent, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)gradientColorImageFromColors:(NSArray<UIColor *> *)colors gradientType:(GradientType)gradientType imgSize:(CGSize)imgSize {
    NSMutableArray *ar = [NSMutableArray array];

    for (UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }

    UIGraphicsBeginImageContextWithOptions(imgSize, YES, 1);

    CGContextRef context = UIGraphicsGetCurrentContext();

    CGContextSaveGState(context);

    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);

    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);

    CGPoint start;

    CGPoint end;

    switch (gradientType) {
        case GradientTypeTopToBottom:

            start = CGPointMake(0.0, 0.0);

            end = CGPointMake(0.0, imgSize.height);

            break;

        case GradientTypeLeftToRight:

            start = CGPointMake(0.0, 0.0);

            end = CGPointMake(imgSize.width, 0.0);

            break;

        case GradientTypeUpleftToLowright:

            start = CGPointMake(0.0, 0.0);

            end = CGPointMake(imgSize.width, imgSize.height);

            break;

        case GradientTypeUprightToLowleft:

            start = CGPointMake(imgSize.width, 0.0);

            end = CGPointMake(0.0, imgSize.height);

            break;

        default:

            break;
    }

    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();

    CGGradientRelease(gradient);

    CGContextRestoreGState(context);

    CGColorSpaceRelease(colorSpace);

    UIGraphicsEndImageContext();

    return image;
}


- (UIImage *)appendImageInCenterWithImage:(UIImage *)image {
    NSAssert(image, @"image is missing.");

    if (image.size.width >= self.size.width && image.size.height >= self.size.height) {
        // DDLogDebug(@"image size is greater than image");
        return self;
    }

    UIGraphicsBeginImageContextWithOptions(self.size, NO, 0.0);
    [self drawAtPoint:CGPointZero blendMode:kCGBlendModeNormal alpha:1.0];

    CGPoint point = CGPointMake((self.size.width / 2) - (image.size.width / 2), (self.size.height / 2) - (image.size.height / 2));
    [image drawAtPoint:point blendMode:kCGBlendModeNormal alpha:1.0];

    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();

    UIGraphicsEndImageContext();
    return resultImage;
}


+ (UIImage *)imageScaledFromImage:(UIImage *)image Size:(CGSize)size {
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}


- (UIColor *)colorAtPixel:(CGPoint)point {
    // Cancel if point is outside image coordinates
    if (!CGRectContainsPoint(CGRectMake(0.0f, 0.0f, self.size.width, self.size.height), point)) {
        return nil;
    }

    NSInteger pointX = trunc(point.x);
    NSInteger pointY = trunc(point.y);
    CGImageRef cgImage = self.CGImage;
    NSUInteger width = self.size.width;
    NSUInteger height = self.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    int bytesPerPixel = 4;
    int bytesPerRow = bytesPerPixel * 1;
    NSUInteger bitsPerComponent = 8;
    unsigned char pixelData[4] = {0, 0, 0, 0};
    CGContextRef context =
        CGBitmapContextCreate(pixelData, 1, 1, bitsPerComponent, bytesPerRow, colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextSetBlendMode(context, kCGBlendModeCopy);

    // Draw the pixel we are interested in onto the bitmap context
    CGContextTranslateCTM(context, -pointX, pointY - (CGFloat)height);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, (CGFloat)width, (CGFloat)height), cgImage);
    CGContextRelease(context);

    // Convert color values [0..255] to floats [0.0..1.0]
    CGFloat red = (CGFloat)pixelData[0] / 255.0f;
    CGFloat green = (CGFloat)pixelData[1] / 255.0f;
    CGFloat blue = (CGFloat)pixelData[2] / 255.0f;
    CGFloat alpha = (CGFloat)pixelData[3] / 255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIImage *)imageWithName:(NSString *)imageName Bundle:(NSString *)bundleName {
    NSString *bundlePath = [[NSBundle mainBundle] pathForResource:bundleName ofType:@"bundle"];
    NSString *imageDirectoryPath = [bundlePath stringByAppendingPathComponent:@"image"];
    NSString *imagePath = [imageDirectoryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", imageName]];
    return [UIImage imageNamed:imagePath];
}

+ (UIImage *)grayImage:(UIImage *)sourceImage {
    int width = sourceImage.size.width;
    int height = sourceImage.size.height;

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpace, kCGImageAlphaNone);
    CGColorSpaceRelease(colorSpace);

    if (context == NULL) {
        return nil;
    }

    CGContextDrawImage(context, CGRectMake(0, 0, width, height), sourceImage.CGImage);
    CGImageRef grayImageRef = CGBitmapContextCreateImage(context);
    UIImage *grayImage = [UIImage imageWithCGImage:grayImageRef];
    CGContextRelease(context);
    CGImageRelease(grayImageRef);
    return grayImage;
}

+ (UIImage *)cutImage:(UIImage *)originalImage withRect:(CGRect)rect {
    CGImageRef imageRef = originalImage.CGImage;
    CGImageRef cgImage = CGImageCreateWithImageInRect(imageRef, rect);
    UIImage *cutImage = [[UIImage alloc] initWithCGImage:cgImage];
    return cutImage;
}

- (UIImage *)strechedInCenter {
    CGFloat imageWidth = self.size.width;
    CGFloat imageHeight = self.size.height;
    return [self resizableImageWithCapInsets:UIEdgeInsetsMake(imageHeight / 2, imageWidth / 2, imageHeight / 2, imageWidth / 2)];
}

@end
