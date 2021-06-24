//
//  TSShareView.h
//  TSale
//
//  Created by 陈洁 on 2021/2/24.
//  Copyright © 2021 TCL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger,ShareType){
    ShareTypeFriends,
    ShareTypeTimeline
};

@interface TSShareView : UIView

@property (nonatomic, copy) void (^shareItemClick) (ShareType type);

-(instancetype)initWithParams:(NSDictionary *)params;

/// 展示
- (void)show;

@end

NS_ASSUME_NONNULL_END
