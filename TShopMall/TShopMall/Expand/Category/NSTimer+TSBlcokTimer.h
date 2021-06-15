//
//  NSTimer+TSBlcokTimer.h
//  TShopMall
//
//  Created by sway on 2021/6/15.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (TSBlcokTimer)
+ (NSTimer *)ts_scheduledTimerWithTimeInterval:(NSTimeInterval)interval block:(void (^)(void))block repeats:(BOOL)repeats;
@end

NS_ASSUME_NONNULL_END
