//
//  TSSearchResultFittleView.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/13.
//

#import <UIKit/UIKit.h>

@protocol TSSearchResultFittleDelegate <NSObject>
- (void)operationType:(NSInteger)type sortType:(NSInteger)sortType;

@end

@interface TSSearchResultFittleView : UIView
@property (nonatomic, weak) id<TSSearchResultFittleDelegate> delegate;
@end

