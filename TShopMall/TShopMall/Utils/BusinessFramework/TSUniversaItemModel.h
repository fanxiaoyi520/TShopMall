//
//  TSUniversaItemModel.h
//  TSale
//
//  Created by 陈洁 on 2020/12/8.
//  Copyright © 2020 TCL. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSUniversaItemModel : NSObject

/// cell唯一标识
@property (nonatomic, copy) NSString *identify;
/// cell高
@property (nonatomic, assign) CGFloat cellHeight;

@end

NS_ASSUME_NONNULL_END
