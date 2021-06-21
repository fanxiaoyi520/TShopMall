//
//  UIImage+Extension.m
//  TCLPlus
//
//  Created by kobe on 2020/9/19.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import <Accelerate/Accelerate.h>

#import "UIImage+Extension.h"


@implementation UIImage (Extension)

+ (UIImage *)originImage:(UIImage *)image scaleToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaleImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaleImage;
}


+ (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect {
    CGImageRef sourceImageRef = [image CGImage];
    sourceImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:sourceImageRef];
    CGImageRelease(sourceImageRef);
    return newImage;
}

+ (UIImage *)blurImage:(UIImage *)image blurLevel:(CGFloat)blur {
    if (image == nil) return [UIImage new];
    if (blur < 0.0f || blur > 1.0f) {
        blur = 0.5f;
    }

    int boxSize = (int)(blur * 40);
    boxSize = boxSize - (boxSize % 2) + 1;
    CGImageRef imgRef = image.CGImage;
    vImage_Buffer inBuffer, outBuffer;
    vImage_Error error;
    void *pixelBuffer;
    CGDataProviderRef inProvider = CGImageGetDataProvider(imgRef);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);
    inBuffer.width = CGImageGetWidth(imgRef);
    inBuffer.height = CGImageGetHeight(imgRef);
    inBuffer.rowBytes = CGImageGetBytesPerRow(imgRef);
    inBuffer.data = (void *)CFDataGetBytePtr(inBitmapData);
    pixelBuffer = malloc(CGImageGetBytesPerRow(imgRef) * CGImageGetHeight(imgRef));

    if (pixelBuffer == NULL) NSLog(@"no pixelBuffer");
    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(imgRef);
    outBuffer.height = CGImageGetHeight(imgRef);
    outBuffer.rowBytes = CGImageGetBytesPerRow(imgRef);
    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);

    if (error) NSLog(@"error from convolution %ld", error);

    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx =
        CGBitmapContextCreate(outBuffer.data, outBuffer.width, outBuffer.height, 8, outBuffer.rowBytes, colorSpaceRef, kCGImageAlphaNoneSkipLast);
    CGImageRef targetImageRef = CGBitmapContextCreateImage(ctx);
    UIImage *targetImage = [UIImage imageWithCGImage:targetImageRef];

    CGContextRelease(ctx);
    CGColorSpaceRelease(colorSpaceRef);
    free(pixelBuffer);
    CFRelease(inBitmapData);
    CGImageRelease(targetImageRef);
    return targetImage;
}


+ (UIImage *)blurImage:(UIImage *)image {
    if (image == nil) return [UIImage new];
    int boxSize = (NSInteger)(10 * 5);
    boxSize = boxSize - (boxSize % 2) + 1;

    CGImageRef img = image.CGImage;
    vImage_Buffer inBuffer, outBuffer, rgbOutBuffer;
    vImage_Error error;

    void *pixelBuffer, *convertBuffer;

    CGDataProviderRef inProvider = CGImageGetDataProvider(img);
    CFDataRef inBitmapData = CGDataProviderCopyData(inProvider);

    convertBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    rgbOutBuffer.width = CGImageGetWidth(img);
    rgbOutBuffer.height = CGImageGetHeight(img);
    rgbOutBuffer.rowBytes = CGImageGetBytesPerRow(img);
    rgbOutBuffer.data = convertBuffer;

    inBuffer.width = CGImageGetWidth(img);
    inBuffer.height = CGImageGetHeight(img);
    inBuffer.rowBytes = CGImageGetBytesPerRow(img);
    inBuffer.data = (void *)CFDataGetBytePtr(inBitmapData);

    pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));

    if (pixelBuffer == NULL) {
        NSLog(@"No pixelbuffer");
    }

    outBuffer.data = pixelBuffer;
    outBuffer.width = CGImageGetWidth(img);
    outBuffer.height = CGImageGetHeight(img);
    outBuffer.rowBytes = CGImageGetBytesPerRow(img);

    void *rgbConvertBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img));
    vImage_Buffer outRGBBuffer;
    outRGBBuffer.width = CGImageGetWidth(img);
    outRGBBuffer.height = CGImageGetHeight(img);
    outRGBBuffer.rowBytes = 3;
    outRGBBuffer.data = rgbConvertBuffer;

    error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, NULL, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);

    if (error) {
        NSLog(@"error from convolution %ld", error);
    }
    const uint8_t mask[] = {2, 1, 0, 3};

    vImagePermuteChannels_ARGB8888(&outBuffer, &rgbOutBuffer, mask, kvImageNoFlags);

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx =
        CGBitmapContextCreate(rgbOutBuffer.data, rgbOutBuffer.width, rgbOutBuffer.height, 8, rgbOutBuffer.rowBytes, colorSpace, kCGImageAlphaNoneSkipLast);
    CGImageRef imageRef = CGBitmapContextCreateImage(ctx);
    UIImage *returnImage = [UIImage imageWithCGImage:imageRef];

    // clean up
    CGContextRelease(ctx);

    free(pixelBuffer);
    free(convertBuffer);
    free(rgbConvertBuffer);
    CFRelease(inBitmapData);

    CGColorSpaceRelease(colorSpace);
    CGImageRelease(imageRef);
    return returnImage;
}

+ (NSData *)compressImageData:(NSData *)imageData length:(NSInteger)lenght {
    CGFloat tempRate = lenght * 1.f / imageData.length;
    UIImage *tempImage = [UIImage imageWithData:imageData];
    NSData *data = UIImageJPEGRepresentation(tempImage, tempRate);
    if (tempRate < 1.f) {
        data = UIImageJPEGRepresentation(tempImage, tempRate);
    }
    return data;
}

@end
