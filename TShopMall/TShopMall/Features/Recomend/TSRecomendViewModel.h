//
//  TSRecomendViewModel.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/22.
//

#import <Foundation/Foundation.h>
#import "TSRecomendModel.h"

@interface TSRecomendViewModel : NSObject
- (instancetype)iniWithGoods:(TSRecomendGoods *)goods;

@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *price;
@property (nonatomic, copy) NSString *earn;
@property (nonatomic, copy) NSString *thPrice;
@property (nonatomic, copy) NSString *uuid;
@end
