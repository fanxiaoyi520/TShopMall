//
//  TSCartView.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/8.
//

#import <UIKit/UIKit.h>
#import "TSCartViewModel.h"

@interface TSCartView : UIView
@property (nonatomic, strong) NSArray<TSCartGoodsSection *> *sections;
@property (nonatomic, weak) id controller;
@end


