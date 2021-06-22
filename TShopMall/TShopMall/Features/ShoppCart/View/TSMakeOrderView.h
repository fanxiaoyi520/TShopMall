//
//  TSMakeOrderView.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/16.
//

#import <UIKit/UIKit.h>
#import "TSMakeOrderSection.h"

@interface TSMakeOrderView : UITableView
@property (nonatomic, strong) NSMutableArray<TSMakeOrderSection *> *sections;
@property (nonatomic, weak) id controller;
@end


