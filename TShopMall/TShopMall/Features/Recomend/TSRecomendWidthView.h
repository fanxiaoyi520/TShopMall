//
//  TSRecomendWidthView.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/25.
//

#import <UIKit/UIKit.h>
#import "TSRecomendViewModel.h"
#import "TSEarnView.h"

@interface TSRecomendWidthView : UIView
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *price;
@property (nonatomic, strong) TSEarnView *earnView;
@property (nonatomic, strong) UILabel *thPrice;
@property (nonatomic, strong) UIView *line;

@property (nonatomic, strong) TSRecomendViewModel *vm;
@end

