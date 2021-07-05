//
//  TSMakeOrderOperationCell.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/16.
//

#import "TSMakeOrderOperationCell.h"
#import "TSMakeOrderInvoiceViewModel.h"

@interface TSMakeOrderOperationView : UIView<UITextFieldDelegate>
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIImageView *indeImg;
@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, assign) BOOL hasIndeImg;
@property (nonatomic, assign) BOOL canEdit;
@property (nonatomic, copy) void(^touchAction)(void);
@end

@interface TSMakeOrderOperationCell()
@property (nonatomic, strong) TSMakeOrderOperationView *deliveryView;
@property (nonatomic, strong) TSMakeOrderOperationView *billView;
@property (nonatomic, strong) TSMakeOrderOperationView *messageView;
@end

@implementation TSMakeOrderOperationCell

- (void)setObj:(id)obj{
    if (obj != nil &&[obj isKindOfClass:[TSMakeOrderInvoiceViewModel class]]) {
        TSMakeOrderInvoiceViewModel *vm = (TSMakeOrderInvoiceViewModel *)obj;
        self.messageView.textField.text = vm.message;
        if (vm.invoice != nil) {
            if (vm.invoice.formType == 1) {
                self.billView.textField.text = @"电子普通发票 - 个人";
            } else if (vm.invoice.formType == 2) {
                self.billView.textField.text = @"电子普通发票 - 企业";
            } else {
                self.billView.textField.text = @"增值税发票";
            }
        }
    }
}

//选择配送
- (void)toChoiceDelivery{
    [self.delegate operationForChangeDelivery];
}

//选择发票
- (void)toChoiceBill{
    [self.delegate operationForChangeBill];
}

- (void)messageEditingEnd:(UITextField *)textField{
    
}

- (void)messageEditingChange:(UITextField *)textField{
    if (textField.text.length > 50) {
        textField.text = [textField.text substringWithRange:NSMakeRange(0, 50)];
    }
    [self.delegate operationForMessageEditEnd:textField.text];
}

- (void)configUI{
    self.deliveryView.title.text = @"配送";
    self.deliveryView.textField.text = @"快递配送  免运费";
    self.billView.title.text = @"发票";
    self.billView.textField.text = @"选择发票抬头";
    self.messageView.title.text = @"给商家留言";
    self.messageView.textField.placeholder = @"留言建议提前协商（50字以内）";
}

- (void)layoutSubviews{
    [self.deliveryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.height.mas_equalTo(KRateW(56.0));
    }];
    
    [self.billView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(self.deliveryView);
        make.top.equalTo(self.deliveryView.mas_bottom);
    }];
    
    [self.messageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.mas_equalTo(self.deliveryView);
        make.top.equalTo(self.billView.mas_bottom);
    }];
}

- (TSMakeOrderOperationView *)deliveryView{
    if (_deliveryView) {
        return _deliveryView;
    }
    self.deliveryView = [TSMakeOrderOperationView new];
    self.deliveryView.canEdit = NO;
    [self.contentView addSubview:self.deliveryView];
    __weak typeof(self) weakSelf = self;
    self.deliveryView.touchAction = ^{
        [weakSelf toChoiceDelivery];
    };
    
    return self.deliveryView;
}

- (TSMakeOrderOperationView *)billView{
    if (_billView) {
        return _billView;
    }
    self.billView = [TSMakeOrderOperationView new];
    self.billView.hasIndeImg = YES;
    self.billView.canEdit = NO;
    [self.contentView addSubview:self.billView];
    
    __weak typeof(self) weakSelf = self;
    self.billView.touchAction = ^{
        [weakSelf toChoiceBill];
    };
    
    return self.billView;
}

- (TSMakeOrderOperationView *)messageView{
    if (_messageView) {
        return _messageView;
    }
    self.messageView = [TSMakeOrderOperationView new];
    [self.messageView.textField addTarget:self action:@selector(messageEditingChange:) forControlEvents:UIControlEventEditingChanged];
    [self.messageView.textField addTarget:self action:@selector(messageEditingEnd:) forControlEvents:UIControlEventEditingDidEnd];
    [self.contentView addSubview:self.messageView];
    
    return self.messageView;
}

@end


@implementation TSMakeOrderOperationView

- (instancetype)init{
    if (self == [super init]) {
        self.canEdit = YES;
    }
    return self;
}

- (void)layoutSubviews{
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(KRateW(16.0));
        make.top.bottom.equalTo(self);
        make.width.mas_equalTo(KRateW(70.0));
    }];
    
    self.indeImg.hidden = !self.hasIndeImg;
    [self.indeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-KRateW(16.0));
        make.centerY.equalTo(self);
        make.width.height.mas_equalTo(KRateW(16.0));
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.title.mas_right).offset(KRateW(18.0));
        make.top.bottom.equalTo(self);
        make.right.equalTo(self.indeImg.mas_right).offset(self.hasIndeImg==YES? -KRateW(28.0):0);
    }];
    
    [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(0.33);
    }];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (self.canEdit == NO) {
        if (self.touchAction) self.touchAction();
    }
    return self.canEdit;
}

-  (UILabel *)title{
    if (_title) {
        return _title;
    }
    self.title = [UILabel new];
    self.title.font = KRegularFont(14.0);
    self.title.textColor = KHexColor(@"#2D3132");
    [self addSubview:self.title];
    
    return self.title;
}

- (UIImageView *)indeImg{
    if (_indeImg) {
        return _indeImg;
    }
    self.indeImg = [UIImageView new];
    self.indeImg.image = KImageMake(@"inde_right_small");
    [self addSubview:self.indeImg];
    
    return self.indeImg;
}

- (UITextField *)textField{
    if (_textField) {
        return _textField;
    }
    self.textField = [UITextField new];
    self.textField.delegate = self;
    self.textField.textAlignment = NSTextAlignmentRight;
    self.textField.font = KRegularFont(14.0);
    self.textField.textColor = KHexColor(@"#2D3132");
    [self.textField setPlaceholderColor:[KHexColor(@"#2D3132") colorWithAlphaComponent:0.4] fontType:PingFangSCRegular fontSize:14.0];
    [self addSubview:self.textField];
    
    return self.textField;
}

- (UIView *)line{
    if (_line) {
        return _line;
    }
    self.line = [UIView new];
    self.line.backgroundColor = KHexColor(@"#E6E6E6");
    [self addSubview:self.line];
    
    return self.line;
}
@end
