//
//  TSChangeMobileCell.h
//  TShopMall
//
//  Created by edy on 2021/6/25.
//

#import "TSUniversalCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, ChangeMobileValueType){
    ChangeMobileValueTypeCommit = 1,///提交按钮
    ChangeMobileValueTypeSendCode = 2,///发送验证码
};

@interface TSChangeMobileCell : TSUniversalCollectionViewCell

@end

NS_ASSUME_NONNULL_END
