//
//  TSCartDataController.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/9.
//

#import <UIKit/UIKit.h>
#import "TSCartModel.h"

@interface TSCartDataController : UIViewController
@property (nonatomic, strong) TSCartModel *cartModel;
+ (instancetype)getInfoFinished:(void(^)(TSCartModel *cartModel, NSError *))finished;
@end

