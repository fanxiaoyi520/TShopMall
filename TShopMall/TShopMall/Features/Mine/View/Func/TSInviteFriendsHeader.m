//
//  TSInviteFriendsHeader.m
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/27.
//

#import "TSInviteFriendsHeader.h"

@interface TSInviteFriendsHeader ()<TSInviteFriendsDelegate>

@property (nonatomic ,strong)UIImageView *leftImg;
@property (nonatomic ,strong)UIImageView *middleImg;
@property (nonatomic ,strong)UIImageView *rightImg;
@property (nonatomic ,strong)TSHeaderShareSubView *shareView;
@property (nonatomic ,strong)TSHeaderInvitationSubView *invitationView;
@property (nonatomic ,strong)TSHeaderIntroduceSubView *introduceView;
@property (nonatomic ,strong)TSHeaderCellView *headerCellView;
@end
@implementation TSInviteFriendsHeader
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self jaf_layoutSubView];
    }
    return self;
}

- (void)jaf_layoutSubView {
    [self addSubview:self.leftImg];
    [self.leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self);
        make.height.mas_equalTo(400);
        make.width.mas_equalTo(95);
    }];
    
    [self addSubview:self.rightImg];
    [self.rightImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self);
        make.height.mas_equalTo(400);
        make.width.mas_equalTo(95);
    }];
    
    [self addSubview:self.middleImg];
    [self.middleImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@[self.leftImg.mas_right]);
        make.right.equalTo(@[self.rightImg.mas_left]);
        make.height.mas_equalTo(400);
    }];
    
    [self addSubview:self.shareView];
    self.shareView.frame = CGRectMake(16, 412, kScreenWidth-32, 82);
    [self.shareView jaf_customFilletRectCorner:UIRectCornerAllCorners cornerRadii:CGSizeMake(12, 12)];
    
    [self addSubview:self.invitationView];
    self.invitationView.frame = CGRectMake(16, self.shareView.bottom+12, kScreenWidth-32, 56);
    [self.invitationView jaf_customFilletRectCorner:UIRectCornerAllCorners cornerRadii:CGSizeMake(12, 12)];
    
    [self addSubview:self.introduceView];
    self.introduceView.frame = CGRectMake(16, self.invitationView.bottom+12, kScreenWidth-32, 100);
    [self.introduceView jaf_customFilletRectCorner:UIRectCornerAllCorners cornerRadii:CGSizeMake(12, 12)];
    
    [self addSubview:self.headerCellView];
    self.headerCellView.frame = CGRectMake(0, self.introduceView.bottom+12, kScreenWidth, 99);
}

// MARK: model
- (void)setModel:(id)model {}

// MARK: delegate
- (void)inviteFriendsShareAction:(id)sender {//邀请微信好友
    if ([self.kDelegate respondsToSelector:@selector(inviteFriendsShareAction:)]) {
        [self.kDelegate inviteFriendsShareAction:sender];
    }
}

- (void)inviteFriendsFuncAction:(id)sender {
    if ([self.kDelegate respondsToSelector:@selector(inviteFriendsFuncAction:)]) {
        [self.kDelegate inviteFriendsFuncAction:sender];
    }
}

- (void)inviteFriendsInvitationAction:(id _Nullable)sender {
    if ([self.kDelegate respondsToSelector:@selector(inviteFriendsInvitationAction:)]) {
        [self.kDelegate inviteFriendsInvitationAction:sender];
    }
}

// MARK: set
- (UIImageView *)leftImg {
    if (!_leftImg) {
        _leftImg = [UIImageView new];
        _leftImg.image = KImageMake(@"");
        _leftImg.backgroundColor = [UIColor redColor];
    }
    return _leftImg;
}

- (UIImageView *)middleImg {
    if (!_middleImg) {
        _middleImg = [UIImageView new];
        _middleImg.image = KImageMake(@"");
        _middleImg.backgroundColor = [UIColor blueColor];
    }
    return _middleImg;
}

- (UIImageView *)rightImg {
    if (!_rightImg) {
        _rightImg = [UIImageView new];
        _rightImg.image = KImageMake(@"");
        _rightImg.backgroundColor = [UIColor redColor];
    }
    return _rightImg;
}

- (TSHeaderShareSubView *)shareView {
    if (!_shareView) {
        _shareView = [TSHeaderShareSubView new];
        _shareView.backgroundColor = KWhiteColor;
        _shareView.kDelegate = self;
    }
    return _shareView;
}

- (TSHeaderInvitationSubView *)invitationView {
    if (!_invitationView) {
        _invitationView = [[TSHeaderInvitationSubView alloc] init];
        _invitationView.userInteractionEnabled = YES;
        _invitationView.image = KImageMake(@"mine_bg_yaoqing");
        _invitationView.kDelegate = self;
    }
    return _invitationView;
}

- (TSHeaderIntroduceSubView *)introduceView {
    if (!_introduceView) {
        _introduceView = [TSHeaderIntroduceSubView new];
        _introduceView.backgroundColor = KWhiteColor;
    }
    return _introduceView;
}

- (TSHeaderCellView *)headerCellView {
    if (!_headerCellView) {
        _headerCellView = [TSHeaderCellView new];
        _headerCellView.backgroundColor = KWhiteColor;
        _headerCellView.kDelegate = self;
    }
    return _headerCellView;
}
@end


@interface TSInviteFriendsCell ()

@property (nonatomic ,strong) UIImageView *iconImageView;
@property (nonatomic ,strong) UILabel *nameLab;
@property (nonatomic ,strong) UILabel *iphoneLb;
@end
@implementation TSInviteFriendsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self jaf_layoutSubView];
    }
    return self;
}

- (void)jaf_layoutSubView {
    
    [self.contentView addSubview:self.iconImageView];
    [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(15);
        make.width.height.mas_equalTo(35);
    }];
    [self.iconImageView jaf_customFilletRectCorner:UIRectCornerAllCorners cornerRadii:CGSizeMake(17.5, 17.5)];
    
    [self.contentView addSubview:self.nameLab];
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(@[self.iconImageView.mas_right]).offset(57);
        make.height.mas_equalTo(30);
    }];
    
    [self.contentView addSubview:self.iphoneLb];
    [self.iphoneLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-16);
        make.height.mas_equalTo(30);
    }];
}

// MARK: model
- (void)setModel:(id _Nullable)model {}

// MARK: get
- (UIImageView *)iconImageView {
    if (!_iconImageView) {
        _iconImageView = [UIImageView new];
        _iconImageView.image = KImageMake(@"mine_icon_def_touxiang");
    }
    return _iconImageView;
}

- (UILabel *)nameLab {
    if (!_nameLab) {
        _nameLab = [UILabel new];
        _nameLab.textColor = KHexColor(@"#2D3132");
        _nameLab.font = KRegularFont(16);
        _nameLab.text = @"JERRYJUICE";
    }
    return _nameLab;
}

- (UILabel *)iphoneLb {
    if (!_iphoneLb) {
        _iphoneLb = [UILabel new];
        _iphoneLb.textColor = KHexColor(@"#2D3132");
        _iphoneLb.font = KRegularFont(16);
        _iphoneLb.text = @"185****8903";
    }
    return _iphoneLb;
}
@end


@interface TSHeaderShareSubView ()

@property (nonatomic ,strong) UIButton *shareBtn;
@property (nonatomic ,strong) NSMutableArray *shareBtnArray;
@property (nonatomic ,strong) NSMutableArray *lineViewArray;
@end
@implementation TSHeaderShareSubView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self jaf_layoutSubView];
    }
    return self;
}

- (void)jaf_layoutSubView {
    [self addSubview:self.shareBtn];
    [self.shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.height.mas_equalTo(28);
        make.width.mas_equalTo(210);
        make.centerX.equalTo(self);
    }];
    
    NSArray *imgArray = @[@"mine_wxpyq",@"mine_wxfx",@"mine_schb"];
    NSArray *titleArray = @[@"朋友圈分享",@"微信分享",@"生成海报"];
    [imgArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:btn];
        [btn addTarget:self action:@selector(funcAction:) forControlEvents:UIControlEventTouchUpInside];
        btn.titleLabel.font = KRegularFont(14);
        [btn setTitle:titleArray[idx] forState:UIControlStateNormal];
        [btn setImage:KImageMake(imgArray[idx]) forState:UIControlStateNormal];
        [btn setTitleColor:KHexAlphaColor(@"#2D3132", .5) forState:UIControlStateNormal];
        [btn setImageEdgeInsets:UIEdgeInsetsMake(0.0, -5, 0.0, 0.0)];
        btn.tag = 10+idx;
        [self.shareBtnArray addObject:btn];
        
        if (idx<2) {
            UIView *lineView = [UIView new];
            lineView.backgroundColor = KHexColor(@"#E6E6E6");
            [self addSubview:lineView];
            [self.lineViewArray addObject:lineView];
        }
    }];
    [self.shareBtnArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:10 leadSpacing:11 tailSpacing:11];
    [self.shareBtnArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@[self.shareBtn.mas_bottom]).offset(10);
        make.height.mas_equalTo(24);
    }];
    
    [self.lineViewArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:((kScreenWidth-32)/3-2) leadSpacing:((kScreenWidth-32)/3) tailSpacing:((kScreenWidth-32)/3)];
    [self.lineViewArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@[self.shareBtn.mas_bottom]).offset(15);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(14);
    }];
}

// MARK: actions
- (void)shareAction:(UIButton *)sender {
    if ([self.kDelegate respondsToSelector:@selector(inviteFriendsShareAction:)]) {
        [self.kDelegate inviteFriendsShareAction:sender];
    }
}

- (void)funcAction:(UIButton *)sender {
    if ([self.kDelegate respondsToSelector:@selector(inviteFriendsFuncAction:)]) {
        [self.kDelegate inviteFriendsFuncAction:sender];
    }
}

// MARK: get
- (UIButton *)shareBtn {
    if (!_shareBtn) {
        _shareBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareBtn setBackgroundImage:KImageMake(@"mine_yaoqinghaoyou") forState:UIControlStateNormal];
        [_shareBtn addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareBtn;
}

- (NSMutableArray *)shareBtnArray {
    if (!_shareBtnArray) {
        _shareBtnArray = [NSMutableArray array];
    }
    return _shareBtnArray;
}

- (NSMutableArray *)lineViewArray {
    if (!_lineViewArray) {
        _lineViewArray = [NSMutableArray array];
    }
    return _lineViewArray;
}
@end

@interface TSHeaderInvitationSubView ()

@property (nonatomic ,strong) UIView *lineView;
@property (nonatomic ,strong) UILabel *kcodeLab;
@property (nonatomic ,strong) UIButton *kCopyBtn;
@end
@implementation TSHeaderInvitationSubView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self jaf_layoutSubView];
    }
    return self;
}

- (void)jaf_layoutSubView {
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(23);
        make.height.mas_equalTo(22);
        make.width.mas_equalTo(2);
    }];
    
    [self addSubview:self.kcodeLab];
    [self.kcodeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(32);
        make.height.mas_equalTo(24);
    }];
    
    [self addSubview:self.kCopyBtn];
    [self.kCopyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).offset(-15);
        make.height.mas_equalTo(28);
        make.width.mas_equalTo(88);
    }];
    [self.kCopyBtn jaf_customFilletRectCorner:UIRectCornerAllCorners cornerRadii:CGSizeMake(14, 14)];
}

// MARK: actions
- (void)kCopyAction:(UIButton *)sender {
    UIPasteboard *pab = [UIPasteboard generalPasteboard];
    NSString *str = [self.kcodeLab.text stringByReplacingOccurrencesOfString:@"邀请码:" withString:@""];
    pab.string = str;
    if (str) {
        [Popover popToastOnWindowWithText:@"复制成功"];
    } else {
        [Popover popToastOnWindowWithText:@"复制失败"];
    }
}

// MARK: get
- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = KHexColor(@"#E64C3D");
    }
    return _lineView;
}

- (UILabel *)kcodeLab {
    if (!_kcodeLab) {
        _kcodeLab = [UILabel new];
        _kcodeLab.textColor = KHexAlphaColor(@"#2D3132", .5);
        _kcodeLab.font = KRegularFont(10);
        _kcodeLab.text = @"邀请码:DFY788889";
    }
    return _kcodeLab;
}

- (UIButton *)kCopyBtn {
    if (!_kCopyBtn) {
        _kCopyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _kCopyBtn.backgroundColor = KHexColor(@"#FF4D49");
        [_kCopyBtn setTitle:@"复制" forState:UIControlStateNormal];
        _kCopyBtn.titleLabel.font = KRegularFont(14);
        [_kCopyBtn setTitleColor:KHexColor(@"#FFFFFF") forState:UIControlStateNormal];
        [_kCopyBtn addTarget:self action:@selector(kCopyAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _kCopyBtn;
}
@end

@interface TSHeaderIntroduceSubView ()

@property (nonatomic, strong) NSMutableArray *textArray;
@property (nonatomic, strong) NSMutableArray *lineArray;
@end
@implementation TSHeaderIntroduceSubView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self jaf_layoutSubView];
    }
    return self;
}

- (void)jaf_layoutSubView {
    NSArray *array = @[@"1.分享链接或海报给好友\n2.好友通过分享链接下载APP\n3.注册时填写邀请码\n",@"好友通过您的分享注册后将\n成为您的合伙人，未来产生\n的订单都会给您带来收益"];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UITextView *textView = [UITextView new];
        [self addSubview:textView];
        textView.text = array[idx];
        textView.userInteractionEnabled = NO;
        [self.textArray addObject:textView];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        textView.contentInset = UIEdgeInsetsMake(-5, 0, 0, 0);
        paragraphStyle.lineSpacing = 10;
        NSDictionary *attributes = @{
                                     NSFontAttributeName:KRegularFont(10),
                                     NSParagraphStyleAttributeName:paragraphStyle,
                                     NSForegroundColorAttributeName:KHexAlphaColor(@"#2D3132", .5),
                                     };
        textView.attributedText = [[NSAttributedString alloc] initWithString:textView.text attributes:attributes];
        
        UIView *lineView = [UIView new];
        lineView.backgroundColor = KHexColor(@"#E64C3D");
        [textView addSubview:lineView];
        [self.lineArray addObject:lineView];
    }];
    
    [self.textArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:53 leadSpacing:16 tailSpacing:16];
    [self.textArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.height.mas_equalTo(72);
    }];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.lineArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIView *lineView = (UIView *)obj;
        lineView.frame = CGRectMake(0, 0, 2, 22);
    }];
}

// MARK: get
- (NSMutableArray *)textArray {
    if (!_textArray) {
        _textArray = [NSMutableArray array];
    }
    return _textArray;
}

- (NSMutableArray *)lineArray {
    if (!_lineArray) {
        _lineArray = [NSMutableArray array];
    }
    return _lineArray;
}

@end

@interface TSHeaderCellView ()

@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UIView *lineView;
@property (nonatomic ,strong) NSMutableArray *btnArray;
@property (nonatomic ,assign) NSInteger btnTag;
@end
@implementation TSHeaderCellView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self jaf_layoutSubView];
    }
    return self;
}

- (void)jaf_layoutSubView {
    [self addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(15);
        make.left.equalTo(self).offset(18);
        make.height.mas_equalTo(21);
    }];
    
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(40);
        make.left.equalTo(self).offset(17);
        make.right.equalTo(self).offset(-17);
        make.height.mas_equalTo(1);
    }];
    
    NSArray *array = @[@"今日邀请",@"全部邀请"];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn addTarget:self action:@selector(invitationAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        btn.tag = 10+idx;
        [btn setTitle:array[idx] forState:UIControlStateNormal];
        [btn setTitleColor:KHexAlphaColor(@"#2D3132", .5) forState:UIControlStateNormal];
        btn.titleLabel.font = KRegularFont(16);
        if (idx==1) {
            _btnTag = btn.tag;
            [btn setTitleColor:KHexColor(@"#E64C3D") forState:UIControlStateNormal];
        }
        [self.btnArray addObject:btn];
    }];
    
    [self.btnArray mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:1 leadSpacing:1 tailSpacing:1];
    [self.btnArray mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.height.mas_equalTo(56);
    }];
}

// MARK: actions
- (void)invitationAction:(UIButton *)sender {
    UIButton *oldBtn = [self viewWithTag:self.btnTag];
    [oldBtn setTitleColor:KHexAlphaColor(@"#2D3132", .5) forState:UIControlStateNormal];
    [sender setTitleColor:KHexColor(@"#E64C3D") forState:UIControlStateNormal];
    self.btnTag = sender.tag;
    if ([self.kDelegate respondsToSelector:@selector(inviteFriendsInvitationAction:)]) {
        [self.kDelegate inviteFriendsInvitationAction:sender];
    }
}

// MARK: get
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [UILabel new];
        _titleLab.textColor = KHexColor(@"#333333");
        _titleLab.font = KRegularFont(16);
        _titleLab.text = @"邀请记录";
    }
    return _titleLab;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = KHexColor(@"#E6E6E6");
    }
    return _lineView;
}

- (NSMutableArray *)btnArray {
    if (!_btnArray) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}
@end
