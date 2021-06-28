//
//  TSPaySuccessView.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/28.
//

#import <UIKit/UIKit.h>
#import "TSUniversalFlowLayout.h"
#import "TSPaySuccessSection.h"


@interface TSPaySuccessView : UICollectionView<UniversalFlowLayoutDelegate>
@property (nonatomic, strong) NSArray<TSPaySuccessSection *> *sections;

@property (nonatomic, weak) UIViewController *con;
@end

