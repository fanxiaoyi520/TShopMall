//
//  TSHomePageContainerCollectionViewCell.h
//  TShopMall
//
//  Created by sway on 2021/6/15.
//

#import <UIKit/UIKit.h>
#import "TSProductBaseModel.h"
#import "TSUniversalCollectionViewCell.h"
NS_ASSUME_NONNULL_BEGIN

@interface TSHomePageContainerCollectionViewCell : TSUniversalCollectionViewCell
@property (nonatomic, strong) TSProductBaseModel *item;
@end

NS_ASSUME_NONNULL_END
