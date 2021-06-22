//
//  TSSearchResultCell.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/21.
//

#import "TSSearchBaseCell.h"

@class TSSearchResultRailCell;

@interface TSSearchResultCell : TSSearchBaseCell

@end


@interface TSSearchResultRailCell : TSSearchResultCell
@property (nonatomic, strong) UIView *line;
@end
