//
//  TSCategoryContentModel.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSCategoryContentModel : NSObject
@property(nonatomic, copy) NSString *typeValue;
@property(nonatomic, copy) NSString *objectValue;
@property(nonatomic, copy) NSString *OneLevelTitle;
@property(nonatomic, copy) NSString *OneLevelImg;
@property(nonatomic, strong) NSArray *TwoLevel;
@property(nonatomic, strong) NSArray *goodsList;


@end

NS_ASSUME_NONNULL_END
