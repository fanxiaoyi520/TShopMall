//
//  SSCollectionViewLayoutAttributes.h
//  SSBaseTemplate
//
//  Created by 陈结 on 2021/5/12.
//

#import <UIKit/UIKit.h>
#import "SSLayoutBaseSection.h"

NS_ASSUME_NONNULL_BEGIN

@interface SSCollectionViewLayoutAttributes : UICollectionViewLayoutAttributes

/// 布局方向
@property(nonatomic, assign) SSLayoutDirection direction;

+(instancetype)headerAttributesWithSection:(SSLayoutBaseSection *)baseSection;
-(instancetype)updateHeaderAttributesWithSection:(SSLayoutBaseSection *)baseSection;

+(instancetype)suspensionHeaderAttributesWithSection:(SSLayoutBaseSection *)baseSection;

+(instancetype)footerAttributesWithSection:(SSLayoutBaseSection *)baseSection;
-(instancetype)updateFooterAttributesWithSection:(SSLayoutBaseSection *)baseSection;

+(instancetype)backgroundAttributesWithSection:(SSLayoutBaseSection *)baseSection;
-(instancetype)updateBackgroundAttributesWithSection:(SSLayoutBaseSection *)baseSection;

@end

NS_ASSUME_NONNULL_END
