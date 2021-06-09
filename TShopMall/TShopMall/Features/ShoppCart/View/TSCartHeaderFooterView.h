//
//  TSCartHeaderFooterView.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/9.
//

#import <UIKit/UIKit.h>

@class TSCartInvalidHeader;
@class TSCartRecomendHeader;

@interface TSCartHeaderFooterView : UITableViewHeaderFooterView

@end


@interface TSCartInvalidHeader : TSCartHeaderFooterView
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIButton *clear;
@property (nonatomic, strong) UIView *line;
@end


@interface TSCartRecomendHeader : TSCartHeaderFooterView
@property (nonatomic, strong) UILabel *title;
@end
