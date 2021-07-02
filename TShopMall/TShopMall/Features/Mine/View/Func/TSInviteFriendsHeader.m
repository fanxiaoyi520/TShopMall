//
//  TSInviteFriendsHeader.m
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/27.
//

#import "TSInviteFriendsHeader.h"
@interface TSInviteFriendsHeader ()

@property (nonatomic ,strong) UILabel *titleLab;
@property (nonatomic ,strong) UIView *lineView;
@property (nonatomic ,strong) UIButton *todayBtn;
@property (nonatomic ,strong) UIButton *allBtn;
@end
@implementation TSInviteFriendsHeader
 
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self jaf_layoutSubView];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}


- (void)jaf_layoutSubView {
    [self addSubview:self.titleLab];
    [self addSubview:self.todayBtn];
    [self addSubview:self.lineView];
    [self addSubview:self.allBtn];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(15);
        make.left.equalTo(self).offset(18);
        make.height.mas_equalTo(21);
    }];
    
   
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(40);
        make.left.equalTo(self).offset(17);
        make.right.equalTo(self).offset(-17);
        make.height.mas_equalTo(1);
    }];
  
    [@[_todayBtn,_allBtn] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:1 leadSpacing:1 tailSpacing:1];
    [@[_todayBtn,_allBtn] mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.height.mas_equalTo(44);
    }];
}
- (void)setDataControl:(TSInviteFriendsDataController *)dataControl {
    _dataControl = dataControl;
    _todayBtn.selected = !_dataControl.showAll;
    _allBtn.selected = _dataControl.showAll;
    _allBtn.alpha = _allBtn.selected  ? 1 : 0.4;
    _todayBtn.alpha = _todayBtn.selected ? 1 : 0.4;
}
// MARK: actions
- (void)invitationAction:(UIButton *)sender {
    _allBtn.selected = _allBtn == sender;
    _todayBtn.selected = _todayBtn == sender;
    _allBtn.alpha = _allBtn.selected  ? 1 : 0.4;
    _todayBtn.alpha = _todayBtn.selected ? 1 : 0.4;
    [self.dataControl setShowAll:_allBtn.isSelected];
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

- (UIButton *)todayBtn {
    
    if (!_todayBtn) {
        _todayBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_todayBtn addTarget:self action:@selector(invitationAction:) forControlEvents:UIControlEventTouchUpInside];
        [_todayBtn setTitle:@"今日邀请" forState:UIControlStateNormal];
        [_todayBtn setTitleColor:KHexColor(@"#2D3132") forState:UIControlStateNormal];
        [_todayBtn setTitleColor:KHexColor(@"#E64C3D") forState:UIControlStateSelected];
        _todayBtn.titleLabel.font = KFont(PingFangSCRegular, 14);
        _todayBtn.selected = YES;
    }
    return _todayBtn;
}

- (UIButton *)allBtn {
    
    if (!_allBtn) {
        _allBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_allBtn addTarget:self action:@selector(invitationAction:) forControlEvents:UIControlEventTouchUpInside];
        [_allBtn setTitle:@"全部邀请" forState:UIControlStateNormal];
        [_allBtn setTitleColor:KHexColor(@"#2D3132") forState:UIControlStateNormal];
        [_allBtn setTitleColor:KHexColor(@"#E64C3D") forState:UIControlStateSelected];
        _allBtn.titleLabel.font = KFont(PingFangSCRegular, 14);
        _allBtn.alpha = 0.4;
    }
    return _allBtn;
}
 
@end
