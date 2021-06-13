//
//  TSSearchTextView.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/12.
//

#import <UIKit/UIKit.h>


@interface TSSearchTextView : UIView<UITextFieldDelegate>
@property (nonatomic, strong) UIImageView *indeImg;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, copy) void(^startSearch)(NSString *);
@end

