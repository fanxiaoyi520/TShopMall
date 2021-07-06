//
//  TSFeedbackViewController.m
//  TShopMall
//
//  Created by oneyian on 2021/7/6.
//

#import "TSFeedbackViewController.h"
#import "TSFeedbackDataController.h"
#import "UITextView+Holder.h"

@interface TSFeedbackViewController ()
@property (nonatomic, strong) UITextView * feedback_textView;
@property (nonatomic, strong) UIButton * submit_button;

@property (nonatomic, strong) TSFeedbackDataController * dataController;
@end

@implementation TSFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setupBasic {
    [super setupBasic];
    
    self.gk_navTitleFont = KRegularFont(18);
    self.gk_navTitleColor = KHexColor(@"#2D3132");
    self.gk_navTitle = @"意见反馈";
    
    self.dataController.context = self;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)fillCustomView {
    [self.submit_button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(24);
        make.right.offset(-24);
        make.bottom.offset(- 40 - GK_SAFEAREA_BTM).priorityHigh();
        make.height.offset(40).priorityHigh();
    }];
    
    [self.feedback_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10 + GK_STATUSBAR_NAVBAR_HEIGHT);
        make.left.offset(16);
        make.right.offset(-16);
        make.bottom.equalTo(self.submit_button.mas_top).offset(- 30);
    }];
}

#pragma mark - <懒加载>
- (UITextView *)feedback_textView {
    if (_feedback_textView == nil) {
        _feedback_textView = [UITextView new];
        _feedback_textView.backgroundColor = KWhiteColor;
        _feedback_textView.layer.cornerRadius = 8;
        _feedback_textView.layer.masksToBounds = YES;
        _feedback_textView.font = KRegularFont(14);
        _feedback_textView.placeholder = @"这里是产品意见收集，请写下您宝贵的意见……";
        _feedback_textView.placeholderColor = KPlaceholderColor;
        [self.view addSubview:_feedback_textView];
    }
    return _feedback_textView;
}

- (UIButton *)submit_button {
    if (_submit_button == nil) {
        _submit_button = [UIButton new];
        _submit_button.titleLabel.font = KRegularFont(16);
        [_submit_button setTitle:@"提交" forState:UIControlStateNormal];
        [_submit_button setTitleColor:KWhiteColor forState:UIControlStateNormal];
        [_submit_button setBackgroundImage:KImageMake(@"feedback_submit") forState:UIControlStateNormal];
        [_submit_button addTarget:self action:@selector(clickSubmitButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_submit_button];
    }
    return _submit_button;
}

- (TSFeedbackDataController *)dataController {
    if (_dataController == nil) {
        _dataController = [TSFeedbackDataController new];
    }
    return _dataController;
}

#pragma mark - <处理信号>
- (void)clickSubmitButton:(UIButton *)sender {
    @weakify(self);
    [self.dataController fetchFeedbackWithContent:self.feedback_textView.text Complete:^(BOOL isSucess) {
        @strongify(self);
        if (isSucess) {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }];
}

@end
