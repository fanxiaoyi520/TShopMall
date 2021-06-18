//
//  TSDatePickerView.h
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TSDatePickerViewDelegate <NSObject>

- (void)selectedDateString:(NSString *)dateString;

@end

@interface TSDatePickerView : UIView

/** 开始日期 */
@property(nonatomic, copy) NSString *startDateString;

/** 代理 */
@property (nonatomic, weak) id<TSDatePickerViewDelegate> delegate;

+ (instancetype)datePickerView;

- (void)show;

@end

NS_ASSUME_NONNULL_END
