//
//  TSProductDetailBottomView.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/15.
//

#import <UIKit/UIKit.h>
#import "TSDetailFunctionButton.h"

@class TSProductDetailBottomView;
@protocol ProductDetailBottomViewDelegate <NSObject>

-(void)productDetailBottomView:(TSProductDetailBottomView *_Nullable)bottomView mallClick:(TSDetailFunctionButton *_Nullable)sender;
-(void)productDetailBottomView:(TSProductDetailBottomView *_Nullable)bottomView customClick:(TSDetailFunctionButton *_Nullable)sender;
-(void)productDetailBottomView:(TSProductDetailBottomView *_Nullable)bottomView addClick:(TSDetailFunctionButton *_Nullable)sender;

@end


NS_ASSUME_NONNULL_BEGIN

@interface TSProductDetailBottomView : UIView

@property(nonatomic, weak) id <ProductDetailBottomViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
