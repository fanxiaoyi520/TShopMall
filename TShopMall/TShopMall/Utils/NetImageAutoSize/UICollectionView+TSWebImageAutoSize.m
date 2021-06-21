//
//  UICollectionView+TSWebImageAutoSize.m
//  TSale
//
//  Created by 陈洁 on 2021/1/11.
//  Copyright © 2021 TCL. All rights reserved.
//

#import "UICollectionView+TSWebImageAutoSize.h"
#import "TSWebImageAutoSize.h"

@implementation UICollectionView (TSWebImageAutoSize)

-(void)reloadDataForURL:(NSURL *)url{
    BOOL reloadState = [TSWebImageAutoSize reloadStateFromCacheForURL:url];
    if(!reloadState){
        [self reloadData];
        [TSWebImageAutoSize storeReloadState:YES forURL:url completed:^(BOOL result) {
            
        }];
    }
}

@end
