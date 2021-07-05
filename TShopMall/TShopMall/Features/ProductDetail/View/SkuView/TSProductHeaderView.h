//
//  TSProductHeaderView.h
//  TSale
//
//  Created by Daisy  on 2020/12/9.
//  Copyright © 2020 TCL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TSGoodDetailItemModel.h"

@interface TSProductHeaderView : UIView

@property(nonatomic, copy) NSString *num;

@property(nonatomic, copy) void(^buyNumChangeBlock) (NSString *buyNum);

@property(nonatomic, copy) void(^closeBlock) ();

@property(nonatomic, strong) TSGoodDetailItemPurchaseModel *purchaseModel;

@end


