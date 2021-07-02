//
//  CMPhotoImageFlowLayout.m
//  CMToolDemo
//
//  Created by Joehuitan on 2018/1/19.
//  Copyright © 2018年 chinaMobile. All rights reserved.
//

#import "CMPhotoImageFlowLayout.h"

#define CMPhotoSelectorRowPhotoCount 4

@implementation CMPhotoImageFlowLayout

- (void)prepareLayout {
    [super prepareLayout];
    CGFloat itemW = ([UIScreen mainScreen].bounds.size.width - CMPhotoSelectorRowPhotoCount * 2) / CMPhotoSelectorRowPhotoCount;
    CGSize itemSize = self.itemSize;
    itemSize = CGSizeMake(itemW, itemW);
    self.itemSize = itemSize;
    self.minimumLineSpacing = 1;
    self.minimumInteritemSpacing = 1;
    self.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.collectionView.showsVerticalScrollIndicator = NO;
}
@end
