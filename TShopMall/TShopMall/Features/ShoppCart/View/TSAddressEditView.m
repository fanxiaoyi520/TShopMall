//
//  TSAddressEditView.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/17.
//

#import "TSAddressEditView.h"
#import "TSAddressEditPastView.h"
#import "TSAddressMarkView.h"

@interface TSAddressEditView()
@property (nonatomic, strong) TSAddressEditItem *nameItem;
@property (nonatomic, strong) TSAddressEditItem *phoneItem;
@property (nonatomic, strong) TSAddressEditItem *addressItem;
@property (nonatomic, strong) TSAddressEditItem *detailItem;
@property (nonatomic, strong) TSAddressEditPastView *pastView;
@property (nonatomic, strong) TSAddressMarkView *markView;
@end

@implementation TSAddressEditView

- (instancetype)init{
    if (self == [super init]) {
        [self layouView];
        [self configUI];
        [self initObserver];
        
    }
    return self;
}

- (void)gotoSelectedAddress{}
- (void)shouldUpdateSaveStatus:(id)obj{}

- (void)initObserver{
    [self.nameItem.textField addObserver:self forKeyPath:@"text" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
    [self.phoneItem.textField addObserver:self forKeyPath:@"text" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
    [self.addressItem.textField addObserver:self forKeyPath:@"text" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
    [self.detailItem.textField addObserver:self forKeyPath:@"text" options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld) context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqual:@"text"]) {
        if (self.nameItem.textField.text.length != 0 &&
            self.phoneItem.textField.text.length != 0 &&
            self.addressItem.textField.text.length != 0 &&
            self.detailItem.textField.text.length != 0) {
            [self.controller performSelector:@selector(shouldUpdateSaveStatus:) withObject:@(YES)];
        } else {
            [self.controller performSelector:@selector(shouldUpdateSaveStatus:) withObject:@(NO)];
        }
    }
    if (object == self.nameItem.textField) {
        self.addressModel.name = self.nameItem.textField.text;
    } else if (object == self.phoneItem.textField) {
        self.addressModel.phone = self.addressItem.textField.text;
    } else if (object == self.addressItem.textField) {
        self.addressModel.address = self.addressItem.textField.text;
    } else if (object == self.detailItem.textField) {
        self.addressModel.detailAddress = self.detailItem.textField.text;
    }
}

//- (void)textFieldEditingEnd:(UITextField *)textField{
//
//}

- (void)configUI{
    self.nameItem.title.text = @"姓名";
    self.nameItem.textField.placeholder = @"输入收货人姓名";
    self.phoneItem.title.text = @"电话";
    self.phoneItem.textField.placeholder = @"输入收货人手机号码";
    self.addressItem.title.text = @"所在地区";
    self.addressItem.textField.placeholder = @"选择所在地区";
    self.detailItem.title.text = @"详细地址";
    self.detailItem.textField.placeholder = @"填写小区、门牌号等";
    self.nameItem.textField.text = self.addressModel.name;
    self.phoneItem.textField.text = self.addressModel.phone;
    self.addressItem.textField.text = self.addressModel.address;
    self.detailItem.textField.text = self.addressModel.detailAddress;
}

- (void)layouView{
    [self layoutIfNeeded];
    [self.nameItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.width.mas_equalTo(kScreenWidth);
        make.top.equalTo(self.mas_top).offset(KRateW(10.0));
        make.height.mas_equalTo(KRateW(56.0));
    }];
    
    [self.phoneItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.nameItem);
        make.top.equalTo(self.nameItem.mas_bottom);
    }];
    
    [self.addressItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.nameItem);
        make.top.equalTo(self.phoneItem.mas_bottom);
    }];
    
    [self.detailItem mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.nameItem);
        make.top.equalTo(self.addressItem.mas_bottom);
    }];
    
    [self.pastView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.nameItem);
        make.top.equalTo(self.detailItem.mas_bottom);
    }];
    
    [self.markView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.nameItem);
        make.top.equalTo(self.pastView.mas_bottom);
        make.bottom.equalTo(self.mas_bottom);
    }];
}

- (TSAddressEditItem *)nameItem{
    if (_nameItem) {
        return _nameItem;
    }
    self.nameItem = [TSAddressEditItem new];
    [self addSubview:self.nameItem];
//    [self.nameItem.textField addTarget:self action:@selector(textFieldEditingEnd:) forControlEvents:UIControlEventEditingDidEnd];
    
    return self.nameItem;
}

- (TSAddressEditItem *)phoneItem{
    if (_phoneItem) {
        return _phoneItem;
    }
    self.phoneItem = [TSAddressEditItem new];
    self.phoneItem.textField.keyboardType = UIKeyboardTypePhonePad;
    [self addSubview:self.phoneItem];
//    [self.phoneItem.textField addTarget:self action:@selector(textFieldEditingEnd:) forControlEvents:UIControlEventEditingDidEnd];
    
    return self.phoneItem;
}

- (TSAddressEditItem *)addressItem{
    if (_addressItem) {
        return _addressItem;
    }
    self.addressItem = [TSAddressEditItem new];
    self.addressItem.canEdit = NO;
    self.addressItem.hasIndeImg = YES;
    [self addSubview:self.addressItem];
    __weak typeof(self) weakSelf = self;
    self.addressItem.touchAction = ^{
        [weakSelf.controller performSelector:@selector(gotoSelectedAddress)];
    };
//    [self.addressItem.textField addTarget:self action:@selector(textFieldEditingEnd:) forControlEvents:UIControlEventEditingDidEnd];
    
    return self.addressItem;
}

- (TSAddressEditItem *)detailItem{
    if (_detailItem) {
        return _detailItem;
    }
    self.detailItem = [TSAddressEditItem new];
    [self addSubview:self.detailItem];
//    [self.detailItem.textField addTarget:self action:@selector(textFieldEditingEnd:) forControlEvents:UIControlEventEditingDidEnd];
    
    return self.detailItem;
}

- (TSAddressEditPastView *)pastView{
    if (_pastView) {
        return _pastView;
    }
    self.pastView = [TSAddressEditPastView new];
    [self addSubview:self.pastView];
    
    return self.pastView;
}

- (TSAddressMarkView *)markView{
    if (_markView) {
        return _markView;
    }
    self.markView = [TSAddressMarkView new];
    [self addSubview:self.markView];
    
    return self.markView;
}

@end


@implementation TSAddressEditItem

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
        make.right.top.equalTo(self);
        make.left.equalTo(self.title.mas_left);
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
    self.textField.textAlignment = NSTextAlignmentLeft;
    self.textField.font = KRegularFont(14.0);
    self.textField.textColor = KHexColor(@"#2D3132");
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
