//
//  TSGridButtonCollectionViewCell.h
//  TSPaaS
//
//  Created by sway on 2020/9/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@interface TSGridButtonItem : NSObject

@property (nonatomic, copy)   NSString *title;
@property (nonatomic, copy)   NSString *uri;
@property (nonatomic, assign) BOOL isSelected;
@property (nonatomic, assign) NSInteger index;

@end
@interface TSGridButtonCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UILabel *title;


@end

NS_ASSUME_NONNULL_END
