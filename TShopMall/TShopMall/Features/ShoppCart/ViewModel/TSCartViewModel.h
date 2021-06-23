//
//  TSCartViewModel.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/9.
//

#import <Foundation/Foundation.h>
#import "TSCartGoodsSection.h"
#import "TSCartHeaderFooterView.h"
#import "TSCartModel.h"

@interface TSCartViewModel : NSObject
@property (nonatomic, assign) BOOL checked;
@property (nonatomic, copy) NSString *imgUrl;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *guige;
@property (nonatomic, assign) NSInteger buyNum;
@property (nonatomic, copy) NSString *thPrice;

- (instancetype)initWith:(TSCart *)goods;
@end
