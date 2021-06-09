//
//  TSCartInvalidCell.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/9.
//

#import "TSCartBaseCell.h"

@class TSCartInvalideGoodView;
@class TSCartInvalidTaoCanCell;

@interface TSCartInvalidCell : TSCartBaseCell

@end

@interface TSCartInvalidTaoCanCell : TSCartBaseCell
@property (nonatomic, strong) UILabel *tips;
@property (nonatomic, strong) UILabel *taocanName;

@end

@interface TSCartInvalideGoodView : UIView
@property (nonatomic, strong) UILabel *tips;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *name;
@property (nonatomic, strong) UILabel *mark;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, assign) BOOL isTaoCan;
@end
