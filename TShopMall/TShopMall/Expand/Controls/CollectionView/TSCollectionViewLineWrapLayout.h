//
//  TSCollectionViewLineWrapLayout.h
//
//
//  Created by sway on 2020/10/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSCollectionViewLineWrapLayout : UICollectionViewFlowLayout
@property (nonatomic, assign, readonly) CGFloat itemsHeight;

- (instancetype)initWithColumnSpacing:(CGFloat)columnSpacing rowSpacing:(CGFloat)rowSpacing itemsHeight:(CGFloat)height padding:(UIEdgeInsets)padding isVertical:(BOOL)isVertical;

@end

NS_ASSUME_NONNULL_END
