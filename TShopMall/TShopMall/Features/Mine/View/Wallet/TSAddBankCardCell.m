//
//  TSAddBankCardCell.m
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/25.
//

#import "TSAddBankCardCell.h"
#import "UITextField+ExtendRange.h"

//每组个数
static NSInteger const kGroupSize = 4;

@interface TSAddBankCardCell ()<UITextFieldDelegate>

@property (nonatomic ,strong)UILabel *infoLab;
@property (nonatomic ,strong)UIView *lineView;
@property (nonatomic ,strong)UIImageView *tipsImgView;
@property (nonatomic ,strong)UITextField *inputInfoTextField;
@property (nonatomic ,strong)UIButton *funcBtn;
@property (nonatomic ,strong)UITextField *bankCardNoField;
@end

@implementation TSAddBankCardCell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self jaf_layoutSubviews];
    }
    return self;
}

- (void)jaf_layoutSubviews {
    [self addSubview:self.infoLab];
    [self.infoLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(16);
        make.height.mas_equalTo(22);
    }];
    
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self).offset(25);
        make.right.equalTo(self).offset(-25);
        make.height.mas_equalTo(1);
    }];
    
    [self addSubview:self.tipsImgView];
    [self.tipsImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-16);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(16);
    }];
    
    [self addSubview:self.inputInfoTextField];
    [self.inputInfoTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(127);
        make.height.mas_equalTo(40);
        make.right.equalTo(self).offset(-16);
    }];
    
    [self addSubview:self.funcBtn];
    [self.funcBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(127);
        make.height.mas_equalTo(40);
        make.right.equalTo(self).offset(-16);
    }];
}

// MARK: model
- (void)setModel:(id _Nullable)model indexPath:(NSIndexPath *)indexPath {
    //if (!model) return;
//    TSAddBankCardModel *kModel
    _infoLab.text = (NSString *)model;
    if (indexPath.row == 0) {
        _inputInfoTextField.placeholder = @"请输入持卡本人的真实姓名";
        _inputInfoTextField.keyboardType = UIKeyboardTypeNamePhonePad;
        _inputInfoTextField.tag = 15;
    }
    
    if (indexPath.row == 1) {
        _inputInfoTextField.hidden = NO;
        _inputInfoTextField.placeholder = @"请绑定持卡本人的银行卡";
        _inputInfoTextField.keyboardType = UIKeyboardTypeNumberPad;
        _bankCardNoField = _inputInfoTextField;
        _bankCardNoField.delegate = self;
        _bankCardNoField.tag = 20;
    }
    
    if (indexPath.row == 4) {
        _inputInfoTextField.hidden = NO;
        _inputInfoTextField.placeholder = @"请输入开户银行";
        _inputInfoTextField.keyboardType = UIKeyboardTypeNamePhonePad;
    }
    
    if (indexPath.row == 2 || indexPath.row == 3){
        _inputInfoTextField.userInteractionEnabled = NO;
        _funcBtn.hidden = NO;
        _tipsImgView.hidden = NO;
        _funcBtn.tag = 10+indexPath.row;
    }
}

// MARK: actions
- (void)inputInfoTextFieldAction:(UITextField *)textField {
    if ([self.kDelegate respondsToSelector:@selector(addBankCardInputInfoTextFieldAction:)]) {
        [self.kDelegate addBankCardInputInfoTextFieldAction:textField];
    }
}

- (void)inputInfoTextFieldEditingDidBeginAction:(UITextField *)textField {
    if ([self.kDelegate respondsToSelector:@selector(addBankCardInputInfoTextFieldEditingDidBeginAction:)]) {
        [self.kDelegate addBankCardInputInfoTextFieldEditingDidBeginAction:textField];
    }
}

- (void)funcAction:(UIButton *)sender {
    if ([self.kDelegate respondsToSelector:@selector(addBankCardfuncAction:)]) {
        [self.kDelegate addBankCardfuncAction:sender];
    }
}

//MARK: UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.bankCardNoField) {
        NSString *text = textField.text;
        NSString *beingString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        NSString *cardNo = [self removingSapceString:beingString];
        //校验卡号只能是数字，且不能超过20位
        if ( (string.length != 0 && ![self isValidNumbers:cardNo]) || cardNo.length > 20) {
            return NO;
        }
        //获取【光标右侧的数字个数】
        NSInteger rightNumberCount = [self removingSapceString:[text substringFromIndex:textField.selectedRange.location + textField.selectedRange.length]].length;
        //输入长度大于4 需要对数字进行分组，每4个一组，用空格隔开
        if (beingString.length > kGroupSize) {
            textField.text = [self groupedString:beingString];
        } else {
            textField.text = beingString;
        }
        text = textField.text;
        /**
         * 计算光标位置(相对末尾)
         * 光标右侧空格数 = 所有的空格数 - 光标左侧的空格数
         * 光标位置 = 【光标右侧的数字个数】+ 光标右侧空格数
         */
        NSInteger rightOffset = [self rightOffsetWithCardNoLength:cardNo.length rightNumberCount:rightNumberCount];
        NSRange currentSelectedRange = NSMakeRange(text.length - rightOffset, 0);
        
        //如果光标左侧是一个空格，则光标回退一格
        if (currentSelectedRange.location > 0 && [[text substringWithRange:NSMakeRange(currentSelectedRange.location - 1, 1)] isEqualToString:@" "]) {
            currentSelectedRange.location -= 1;
        }
        [textField setSelectedRange:currentSelectedRange];
        if ([self.kDelegate respondsToSelector:@selector(addBankCardInputInfoTextFieldAction:)]) {
            [self.kDelegate addBankCardInputInfoTextFieldAction:textField];
        }
        return NO;
    }
    return YES;
}

//MARK: Helper
/**
 *  计算光标相对末尾的位置偏移
 *
 *  @param length           卡号的长度(不包括空格)
 *  @param rightNumberCount 光标右侧的数字个数
 *
 *  @return 光标相对末尾的位置偏移
 */
- (NSInteger)rightOffsetWithCardNoLength:(NSInteger)length rightNumberCount:(NSInteger)rightNumberCount {
    NSInteger totalGroupCount = [self groupCountWithLength:length];
    NSInteger leftGroupCount = [self groupCountWithLength:length - rightNumberCount];
    NSInteger totalWhiteSpace = totalGroupCount -1 > 0? totalGroupCount - 1 : 0;
    NSInteger leftWhiteSpace = leftGroupCount -1 > 0? leftGroupCount - 1 : 0;
    return rightNumberCount + (totalWhiteSpace - leftWhiteSpace);
}

/**
 *  校验给定字符串是否是纯数字
 *
 *  @param numberStr 字符串
 *
 *  @return 字符串是否是纯数字
 */
- (BOOL)isValidNumbers:(NSString *)numberStr {
    NSString* numberRegex = @"^[0-9]+$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numberRegex];
    return [numberPre evaluateWithObject:numberStr];
}

/**
 *  去除字符串中包含的空格
 *
 *  @param str 字符串
 *
 *  @return 去除空格后的字符串
 */
- (NSString *)removingSapceString:(NSString *)str {
    return [str stringByReplacingOccurrencesOfString:@" " withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, str.length)];
}

/**
 *  根据长度计算分组的个数
 *
 *  @param length 长度
 *
 *  @return 分组的个数
 */
- (NSInteger)groupCountWithLength:(NSInteger)length {
    return (NSInteger)ceilf((CGFloat)length /kGroupSize);
}

/**
 *  给定字符串根据指定的个数进行分组，每一组用空格分隔
 *
 *  @param string 字符串
 *
 *  @return 分组后的字符串
 */
- (NSString *)groupedString:(NSString *)string {
    NSString *str = [self removingSapceString:string];
    NSInteger groupCount = [self groupCountWithLength:str.length];
    NSMutableArray *components = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < groupCount; i++) {
        if (i*kGroupSize + kGroupSize > str.length) {
            [components addObject:[str substringFromIndex:i*kGroupSize]];
        } else {
            [components addObject:[str substringWithRange:NSMakeRange(i*kGroupSize, kGroupSize)]];
        }
    }
    NSString *groupedString = [components componentsJoinedByString:@" "];
    return groupedString;
}

// MARK: get
- (UILabel *)infoLab {
    if (!_infoLab) {
        _infoLab = [UILabel new];
        _infoLab.textColor = KHexColor(@"#2D3132");
        _infoLab.font = KRegularFont(14);
    }
    return _infoLab;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = KlineColor;
    }
    return _lineView;
}

- (UIImageView *)tipsImgView {
    if (!_tipsImgView) {
        _tipsImgView = [UIImageView new];
        _tipsImgView.image = KImageMake(@"mine_tips_right");
        _tipsImgView.hidden = YES;
    }
    return _tipsImgView;
}

- (UITextField *)inputInfoTextField {
    if (!_inputInfoTextField) {
        _inputInfoTextField = [[UITextField alloc] init];
        [_inputInfoTextField addTarget:self action:@selector(inputInfoTextFieldAction:) forControlEvents:UIControlEventEditingChanged];
        [_inputInfoTextField addTarget:self action:@selector(inputInfoTextFieldEditingDidBeginAction:) forControlEvents:UIControlEventEditingDidBegin];
        _inputInfoTextField.textColor = KHexColor(@"#2D3132");
        _inputInfoTextField.font = KRegularFont(14);
        _inputInfoTextField.textAlignment = NSTextAlignmentLeft;
    }
    return _inputInfoTextField;
}

- (UIButton *)funcBtn {
    if (!_funcBtn) {
        _funcBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _funcBtn.hidden = YES;
        [_funcBtn addTarget:self action:@selector(funcAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _funcBtn;
}
@end

@interface TSAddBankCardHeader ()

@property (nonatomic ,strong) UILabel *titleLable;
@property (nonatomic ,strong) UIImageView *tipsImgView;
@property (nonatomic ,strong) UILabel *tipsLable;
@end
@implementation TSAddBankCardHeader
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self jaf_layoutSubViews];
    }
    return self;
}

- (void)jaf_layoutSubViews {
    [self addSubview:self.titleLable];
    [self.titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(23);
        make.height.mas_equalTo(24);
        make.left.equalTo(self).offset(16);
    }];
    
    [self addSubview:self.tipsImgView];
    [self.tipsImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@[self.titleLable.mas_bottom]).offset(16);
        make.height.mas_equalTo(16);
        make.width.mas_equalTo(16);
        make.left.equalTo(self).offset(16);
    }];
    
    [self addSubview:self.tipsLable];
    [self.tipsLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@[self.titleLable.mas_bottom]).offset(12);
        make.height.mas_equalTo(24);
        make.left.equalTo(@[self.tipsImgView.mas_right]).offset(5);
    }];
}

// MARK: model
- (void)setModel:(id _Nullable)model {}

// MARK: get
- (UILabel *)titleLable {
    if (!_titleLable) {
        _titleLable = [UILabel new];
        _titleLable.textColor = KHexColor(@"#2D3132");
        _titleLable.font = KRegularFont(16);
        _titleLable.text = [NSString stringWithFormat:@"您好,%@",[TSGlobalManager shareInstance].currentUserInfo.userName];
    }
    return _titleLable;
}

- (UIImageView *)tipsImgView {
    if (!_tipsImgView) {
        _tipsImgView = [UIImageView new];
        _tipsImgView.image = KImageMake(@"mine_tips_add");
    }
    return _tipsImgView;
}

- (UILabel *)tipsLable {
    if (!_tipsLable) {
        _tipsLable = [UILabel new];
        _tipsLable.textColor = KHexAlphaColor(@"#2D3132",.5);
        _tipsLable.font = KRegularFont(10);
        _tipsLable.text = @"将为您加密处理信息，放心使用";
    }
    return _tipsLable;
}
@end

@implementation TSAddBankCardFooter
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self jaf_layoutSubViews];
    }
    return self;
}

- (void)jaf_layoutSubViews {
    
    [self addSubview:self.sureBtn];
    [self.sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(16);
        make.left.equalTo(self).offset(24);
        make.right.equalTo(self).offset(-24);
        make.height.mas_equalTo(40);
    }];
    
}

// MARK: model
- (void)setModel:(id)model {}

// MARK: actions
- (void)sureAction:(UIButton *)sender {
    if ([self.kDelegate respondsToSelector:@selector(addBankCardFooterSureAction:)]) {
        [self.kDelegate addBankCardFooterSureAction:sender];
    }
}

// MARK: get
- (UIButton *)sureBtn {
    if (!_sureBtn) {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_sureBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_sureBtn setBackgroundImage:KImageMake(@"btn_large_black_norm") forState:UIControlStateNormal];
        _sureBtn.titleLabel.font = KRegularFont(16);
        [_sureBtn setTitleColor:KWhiteColor forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(sureAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sureBtn;
}

@end

