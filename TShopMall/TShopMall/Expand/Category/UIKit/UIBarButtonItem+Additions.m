//
//  UIBarButtonItem+Additions.m
//  TCLPlus
//
//  Created by lidan on 2020/8/24.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import "UIBarButtonItem+Additions.h"


@implementation UIBarButtonItem (Additions)

+ (instancetype)itemWithImage:(UIImage *)image target:(id)target action:(SEL)action {
    return [[self alloc] initWithImage:image style:UIBarButtonItemStylePlain target:target action:action];
}

+ (instancetype)itemWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    return [[self alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:target action:action];
}

@end
