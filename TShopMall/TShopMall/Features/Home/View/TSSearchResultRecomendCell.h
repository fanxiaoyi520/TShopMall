//
//  TSSearchResultRecomendCell.h
//  TShopMall
//
//  Created by 橙子 on 2021/7/5.
//

#import "TSSearchBaseCell.h"
#import "TSRecomendSlimView.h"
#import "TSRecomendWidthView.h"

@class TSSearchResultRecomendWidthCell;

@interface TSSearchResultRecomendCell : TSSearchBaseCell
@property (nonatomic, strong) TSRecomendSlimView *recomendView;
@end


@interface TSSearchResultRecomendWidthCell : TSSearchBaseCell;
@property (nonatomic, strong) TSRecomendWidthView *recomendView;
@end


