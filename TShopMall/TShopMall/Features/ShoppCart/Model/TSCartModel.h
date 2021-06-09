//
//  TSCartModel.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/9.
//

#import <Foundation/Foundation.h>

@interface TSCartModel : NSObject
@property (nonatomic, assign) BOOL hasGift;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, assign) NSInteger num;
@property (nonatomic, copy) NSString *price;
@end

