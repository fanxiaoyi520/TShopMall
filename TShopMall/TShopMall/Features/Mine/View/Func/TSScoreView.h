//
//  TSScoreView.h
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol TSScoreViewDelegate <NSObject>
@optional
- (void)scoreViewScoreAction:(id _Nullable)sender;
- (void)scoreViewTextViewDidChange:(UITextView *)textView;
@end

@interface TSScoreView : UIView

@property (nonatomic ,assign) id<TSScoreViewDelegate> kDelegate;
@end

NS_ASSUME_NONNULL_END
