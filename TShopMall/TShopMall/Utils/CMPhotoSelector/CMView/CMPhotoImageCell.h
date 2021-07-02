//
//  CMPhotoImageCell.h
//  CMToolDemo
//
//  Created by Joehuitan on 2018/1/19.
//  Copyright © 2018年 chinaMobile. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CMPhotoALAssets;

@interface CMPhotoImageCell : UICollectionViewCell
/** 模型数据 */
@property (nonatomic, strong) CMPhotoALAssets *photoALAssets;

@end
