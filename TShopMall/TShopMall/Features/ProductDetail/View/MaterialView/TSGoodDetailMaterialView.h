//
//  TSGoodDetailMaterialView.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/21.
//

#import <UIKit/UIKit.h>
#import "TSMaterialImageCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface TSGoodDetailMaterialView : UIView

@property(nonatomic, strong) NSArray <TSMaterialImageModel *> *models;

-(instancetype)initWithMaterialModels:(NSArray <TSMaterialImageModel *> *)model;

-(void)reloadMaterialView;

@end

NS_ASSUME_NONNULL_END
