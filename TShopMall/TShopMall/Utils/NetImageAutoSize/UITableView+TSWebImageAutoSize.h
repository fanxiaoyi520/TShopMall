//
//  UITableView+TSWebImageAutoSize.h
//  TSale
//
//  Created by 陈洁 on 2021/1/11.
//  Copyright © 2021 TCL. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (TSWebImageAutoSize)

/// tableView
/// @param url imageURL
-(void)reloadDataForURL:(NSURL *)url;

@end

NS_ASSUME_NONNULL_END
