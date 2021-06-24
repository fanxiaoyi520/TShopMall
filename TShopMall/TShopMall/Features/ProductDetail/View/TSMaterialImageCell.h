//
//  TSMaterialImageCell.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/16.
//

#import "TSUniversalCollectionViewCell.h"

@interface TSMaterialImageModel :NSObject

@property(nonatomic, copy) NSString * _Nullable url;
@property(nonatomic, assign) BOOL selected;

@property(nonatomic, strong) UIImage * _Nullable materialImage;

@end

NS_ASSUME_NONNULL_BEGIN

@interface TSMaterialImageCell : TSUniversalCollectionViewCell

@property(nonatomic, strong) TSMaterialImageModel *model;

@end

NS_ASSUME_NONNULL_END
