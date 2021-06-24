//
//  TSBankCardCell.m
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/24.
//

#import "TSBankCardCell.h"

@implementation TSBankCardCell {
    UIImageView * _bankImageCion;
    UILabel * _bankNameLabel;
    UILabel * _accountLabel;
     UIImageView * _masterLabelBackImageView;
    UILabel * _masterLabel;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 12;
        self.layer.shadowColor = [UIColor blackColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0, 0);
        self.layer.shadowRadius = 5.0f;
        self.layer.shadowOpacity = 1.f;
        self.layer.masksToBounds = NO;
        [self uiConfigue];
    }
    return self;
}
- (void)uiConfigue {
   _bankImageCion = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 40, 40)];
    _bankImageCion.backgroundColor=[UIColor colorWithRed: arc4random_uniform(256)/255.0f green: arc4random_uniform(256)/255.0f blue: arc4random_uniform(256)/255.0f alpha:1];
    _bankImageCion.image=[UIImage imageNamed:@""];
    _bankImageCion.layer.cornerRadius=_bankImageCion.width/2;
    _bankImageCion.layer.masksToBounds=YES;
    [self.contentView addSubview:_bankImageCion];
    
    _bankNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_bankImageCion.right+15, 18, 200, 40)];
    _bankNameLabel.font=[UIFont systemFontOfSize:18];
    _bankNameLabel.textColor=[UIColor whiteColor];
    [self.contentView addSubview:_bankNameLabel];
    
    
    _accountLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width - 200 - 10, 18, 200, 30)];
    _accountLabel.font=KRegularFont(16);
    _accountLabel.textColor=KWhiteColor;
    _accountLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:_accountLabel];

}

- (void)setUserName:(NSString *)userName {
    _userName=userName;
    _masterLabel.text=_userName;
}
- (void)setBankName:(NSString *)bankName {
    _bankName=bankName;
    _bankNameLabel.text=_bankName;
}
- (void)setAccount:(NSString *)account {
    _account=account;
    _accountLabel.text=_account;
}
@end

@interface TSBankCardHeader ()

@property (nonatomic ,strong) UIImageView *tipImageView;
@property (nonatomic ,strong) UILabel *tipLab;
@end

@implementation TSBankCardHeader

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self jaf_layoutSubview];
    }
    return self;
}

- (void)jaf_layoutSubview {
    
}

// MARK: get
- (UIImageView *)tipImageView {
    if (!_tipImageView) {
        _tipImageView = [UIImageView new];
        
    }
    return _tipImageView;
}
@end

@interface TSBankCardFooter ()

@property (nonatomic ,strong)UIButton *addBankCardBtn;
@end

@implementation TSBankCardFooter
- (void)layoutSubviews {
    [super layoutSubviews];
    [self jaf_layoutSubview];
}

- (void)jaf_layoutSubview {
    [self addSubview:self.addBankCardBtn];
    [self.addBankCardBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(27);
        make.left.equalTo(self).offset(24);
        make.right.equalTo(self).offset(-24);
        make.height.mas_equalTo(40);
    }];
    [_addBankCardBtn.layer setMasksToBounds:YES];
    [_addBankCardBtn.layer setCornerRadius:20];
    [_addBankCardBtn.layer setBorderWidth:1.0];
    [_addBankCardBtn.layer setBorderColor:KHexColor(@"#535558").CGColor];
}

// MARK: actions
- (void)addBankCardAction:(UIButton *)sender {
    if ([self.kDelegate respondsToSelector:@selector(bankCardFooterAddBankCardAction:)]) {
        [self.kDelegate bankCardFooterAddBankCardAction:sender];
    }
}

// MARK: get
- (UIButton *)addBankCardBtn {
    if (!_addBankCardBtn) {
        _addBankCardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _addBankCardBtn.backgroundColor = KWhiteColor;
        [_addBankCardBtn setTitle:@"+ 添加银行卡" forState:UIControlStateNormal];
        _addBankCardBtn.titleLabel.font = KRegularFont(16);
        [_addBankCardBtn setTitleColor:KHexColor(@"#2D3132") forState:UIControlStateNormal];
        [_addBankCardBtn addTarget:self action:@selector(addBankCardAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addBankCardBtn;
}
@end
