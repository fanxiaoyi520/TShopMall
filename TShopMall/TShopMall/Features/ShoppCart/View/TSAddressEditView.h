//
//  TSAddressEditView.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/17.
//

#import <UIKit/UIKit.h>
#import "TSAddressViewModel.h"

@class TSAddressEditItem;

@interface TSAddressEditView : UIScrollView
@property (nonatomic, weak) id controller;
@property (nonatomic, strong) TSAddressViewModel *vm;

- (void)updateAddress:(NSString *)address;
@end


@interface TSAddressEditItem : UIView<UITextFieldDelegate>
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIImageView *indeImg;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, assign) BOOL canEdit;
@property (nonatomic, assign) BOOL hasIndeImg;
@property (nonatomic, copy) void(^touchAction)(void);
@end

@interface TSAddressPastView : UIView

@end
