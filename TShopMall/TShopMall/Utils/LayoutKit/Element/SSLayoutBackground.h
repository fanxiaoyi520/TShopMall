//
//  SSLayoutBackground.h
//  SSBaseTemplate
//
//  Created by 陈结 on 2021/5/12.
//

#import "SSSupplementaryElement.h"

UIKIT_EXTERN NSString * _Nullable const UICollectionElementKindSectionBackground;

NS_ASSUME_NONNULL_BEGIN

@interface SSLayoutBackground : SSSupplementaryElement

+(instancetype)backgroundWithViewClass:(Class)viewClass;

@end

NS_ASSUME_NONNULL_END
