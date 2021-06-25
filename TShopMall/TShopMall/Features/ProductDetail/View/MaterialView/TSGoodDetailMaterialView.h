//
//  TSGoodDetailMaterialView.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/21.
//

#import <UIKit/UIKit.h>
#import "TSMaterialImageCell.h"

@class TSGoodDetailMaterialView;

@protocol GoodDetailMaterialViewDelegate <NSObject>

-(void)goodDetailMaterialView:(TSGoodDetailMaterialView *_Nullable)materialView downloadClick:(UIButton *_Nullable)sender;

@end

NS_ASSUME_NONNULL_BEGIN

@interface TSGoodDetailMaterialView : UIView

@property(nonatomic, weak) id<GoodDetailMaterialViewDelegate> delegate;

@property(nonatomic, strong) NSArray <TSMaterialImageModel *> *models;

-(instancetype)initWithMaterialModels:(NSArray <TSMaterialImageModel *> *)model;

-(void)reloadMaterialView;

@end

NS_ASSUME_NONNULL_END
