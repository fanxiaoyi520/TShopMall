//
//  TSNumOperationView.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/10.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, NumOperationType) {
    Add = 0,
    Divi    ,
    Edit
};

@interface TSNumOperationView : UIView
@property (nonatomic, strong) UIButton *addBtn;
@property (nonatomic, strong) UIButton *diviBtn;
@property (nonatomic, assign) NSInteger max;
@property (nonatomic, assign) NSInteger min;
@property (nonatomic, strong) UITextField *number;
- (void)updateNumberText:(NSString *)numberText;

@property (nonatomic, copy) void(^numberOperationDone)(NSInteger currentNumber, NumOperationType type);

@end


