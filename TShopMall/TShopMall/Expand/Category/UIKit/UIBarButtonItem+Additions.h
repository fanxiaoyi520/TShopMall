//
//  UIBarButtonItem+Additions.h
//  TCLPlus
//
//  Created by lidan on 2020/8/24.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface UIBarButtonItem (Additions)

+ (instancetype)itemWithImage:(nullable UIImage *)image target:(nullable id)target action:(nullable SEL)action;

+ (instancetype)itemWithTitle:(nullable NSString *)title target:(nullable id)target action:(nullable SEL)action;

@end

NS_ASSUME_NONNULL_END
