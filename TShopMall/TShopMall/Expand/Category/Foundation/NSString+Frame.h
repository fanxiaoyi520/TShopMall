//
//  NSString+Frame.h
//  TSale
//
//  Created by Daisy  on 2020/12/7.
//  Copyright © 2020 TCL. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (Frame)

- (CGSize)sizeWithFont:(UIFont *)font maxH:(CGFloat)maxH;

- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;

- (CGSize)sizeWithFont:(UIFont *)font;

- (CGFloat)ts_heightWithFont:(UIFont *)font constrainedToWidth:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
