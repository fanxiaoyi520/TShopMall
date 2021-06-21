//
//  TSSexSelectingView.h
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TSSexSelectingViewDelegate <NSObject>

- (void)selectedSex:(Sex)sex;

@end

@interface TSSexSelectingView : UIView
/** 代理 */
@property (nonatomic, weak) id<TSSexSelectingViewDelegate> delegate;
/** 默认 */
@property(nonatomic, assign) Sex sex;

+ (instancetype)sexSelectingView;

- (void)show;

@end

NS_ASSUME_NONNULL_END
