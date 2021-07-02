//
//  CMGroupsViewController.h
//  CMToolDemo
//
//  Created by Joehuitan on 2018/1/18.
//  Copyright © 2018年 chinaMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CMPhotoGroupsController : UITableViewController
/** 是否是多选 */
@property (nonatomic, assign, getter=isMultiSelection) BOOL multiSelection;
/** 如果是多选的话，最多选择多少张 */
@property (nonatomic, assign) NSInteger maxCount;

@end
