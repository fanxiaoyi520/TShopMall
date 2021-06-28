//
//  TSCartRecomendCell.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/25.
//

#import "TSCartBaseCell.h"
#import "TSRecomendWidthView.h"
#import "TSRecomendSlimView.h"

@interface TSCartRecomendCell : TSCartBaseCell
@property (nonatomic, strong) TSRecomendWidthView *recomendView;
@end

@interface TSCartRecomendGirdCell : TSCartBaseCell
@property (nonatomic, strong) TSRecomendSlimView *leftRecomendView;
@property (nonatomic, strong) TSRecomendSlimView *rightRecomendView;

@end
