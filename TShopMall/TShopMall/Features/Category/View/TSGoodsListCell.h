//
//  TSGoodsListCell.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/13.
//

#import <UIKit/UIKit.h>

@class TSGoodsListRailCell;

@interface TSGoodsListCell : UICollectionViewCell
@property (nonatomic, strong) id obj;
@property (nonatomic, assign) BOOL isShowGardView;
@end

@interface TSGoodsListRailCell : TSGoodsListCell
@property (nonatomic, strong) UIView *line;
@end
