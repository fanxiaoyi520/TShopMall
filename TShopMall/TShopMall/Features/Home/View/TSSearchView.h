//
//  TSSearchView.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/12.
//

#import <UIKit/UIKit.h>
#import "TSSearchSection.h"

@interface TSSearchView : UIView
@property (nonatomic, strong) NSArray<TSSearchSection *> *sections;
@property (nonatomic, weak) id controller;
@end
