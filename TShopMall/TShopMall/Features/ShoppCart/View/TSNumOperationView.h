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

@property (nonatomic, copy) void(^numberOperationDone)(NSInteger currentNumber, NumOperationType type);
//@property (nonatomic, copy) void(^maxOperationDone)(NSString *currentNumber);
//@property (nonatomic, copy) void(^minberOperationDone)(NSString *currentNumber);
@end


