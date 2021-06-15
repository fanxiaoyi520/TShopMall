//
//  NSTimer+TSBlcokTimer.m
//  TShopMall
//
//  Created by sway on 2021/6/15.
//

#import "NSTimer+TSBlcokTimer.h"

@implementation NSTimer (TSBlcokTimer)
+ (NSTimer *)ts_scheduledTimerWithTimeInterval:(NSTimeInterval)interval block:(void (^)(void))block repeats:(BOOL)repeats {
    
    return [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(ts_blockSelector:) userInfo:[block copy] repeats:repeats];
}

+ (void)ts_blockSelector:(NSTimer *)timer {
    
    void(^block)(void) = timer.userInfo;
    if (block) {
        block();
    }
}
@end
