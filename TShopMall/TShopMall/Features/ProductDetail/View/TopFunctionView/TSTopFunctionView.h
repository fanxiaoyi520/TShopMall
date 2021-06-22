//
//  TSTopFunctionView.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/22.
//

#import <UIKit/UIKit.h>

@class TSTopFunctionView;
@class TSFuncButton;

@protocol TSTopFunctionViewDelegate <NSObject>

-(void)topFunctionView:(TSTopFunctionView *_Nullable)topFunctionView closeClick:(UIButton *_Nonnull)sender;
-(void)topFunctionView:(TSTopFunctionView *_Nullable)topFunctionView changeClick:(TSFuncButton *_Nonnull)sender;
-(void)topFunctionView:(TSTopFunctionView *_Nullable)topFunctionView shareClick:(TSFuncButton *_Nonnull)sender;
-(void)topFunctionView:(TSTopFunctionView *_Nullable)topFunctionView downloadClick:(TSFuncButton *_Nonnull)sender;

@end

NS_ASSUME_NONNULL_BEGIN

@interface TSTopFunctionView : UIView

@property(nonatomic, weak) id<TSTopFunctionViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
