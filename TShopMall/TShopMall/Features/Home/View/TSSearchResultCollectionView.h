//
//  TSSearchResultCollectionView.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/21.
//

#import <UIKit/UIKit.h>
#import "TSSearchSection.h"

@interface TSSearchResultCollectionView : UICollectionView
@property (nonatomic, strong) NSArray<TSSearchSection *> *sections;
@end

