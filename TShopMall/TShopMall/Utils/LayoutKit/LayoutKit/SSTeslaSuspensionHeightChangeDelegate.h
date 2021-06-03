//
//  SSTeslaSuspensionHeightChangeDelegate.h
//  SSBaseTemplate
//
//  Created by 陈结 on 2021/5/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol SSTeslaSuspensionHeightChangeDelegate <NSObject>

-(void)teslaSuspensionHeaderShouldShowHeight:(CGFloat)showHeight;

@end

NS_ASSUME_NONNULL_END
