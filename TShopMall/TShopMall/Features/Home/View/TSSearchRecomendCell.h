//
//  TSSearchRecomendCell.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/13.
//

#import "TSSearchBaseCell.h"
#import "TSRecomendWidthView.h"
#import "TSRecomendSlimView.h"
#import "TSRecomendModel.h"

@class TSSearchRecomendSlimCell;

@interface TSSearchRecomendCell : TSSearchBaseCell
@property (nonatomic, strong) TSRecomendWidthView *recomendView;
@end


@interface TSSearchRecomendSlimCell : TSSearchBaseCell
@property (nonatomic, strong) TSRecomendSlimView *recomendView;
@end
