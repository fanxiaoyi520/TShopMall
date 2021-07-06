//
//  TSAgreementView.m
//  TShopMall
//
//  Created by edy on 2021/6/25.
//

#import "TSAgreementView.h"
#import "TSUniversalFlowLayout.h"
#import "TSWKWebView.h"
@implementation TSAgreementSectionModel

@end

@implementation TSAgreementSectionItemModel

@end

@interface TSAgreementDataController ()
@property(nonatomic, strong) TSAgreementModel *agreementModel ;
@end

@implementation TSAgreementDataController
 
 
- (void)fetchAgreementContentsWithState:(NSString *)state Complete:(void (^)(BOOL))complete {
    NSMutableDictionary *body = [NSMutableDictionary dictionary];
    [body setValue:state forKey:@"state"];
    SSGenaralRequest *request = [[SSGenaralRequest alloc] initWithRequestUrl:kShopStatement
                                                               requestMethod:YTKRequestMethodPOST
                                                       requestSerializerType:YTKRequestSerializerTypeHTTP
                                                      responseSerializerType:YTKResponseSerializerTypeJSON
                                                               requestHeader:@{}
                                                                 requestBody:body
                                                              needErrorToast:NO];
    [request startWithCompletionBlockWithSuccess:^(__kindof SSGenaralRequest * _Nonnull request) {
        if (request.responseModel.isSucceed) {
            NSArray *data = request.responseObject[@"data"];
            if (data != nil && data.count) {
                NSMutableArray *_agreementModels = [NSMutableArray array];
                for (int i = 0; i < data.count; i++) {
                    NSDictionary *dict = data[i];
                    TSAgreementModel *agreementModel = [[TSAgreementModel alloc] init];
                    agreementModel.serverUrl = dict[@"serverUrl"];
                    agreementModel.title = dict[@"title"];
                    self.agreementModel = agreementModel;
                }
                if (complete) {
                    complete(YES);
                }
            }
        } else {
            if (complete) {
                complete(NO);
            }
        }
    } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
        if (complete) {
            complete(NO);
        }
    }];
}

@end

@interface TSAgreementCell ()
/** 内容  */
@property(nonatomic, weak) UILabel *contentLabel;

@end

@implementation TSAgreementCell

- (void)fillCustomContentView {
    [super fillCustomContentView];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(0);
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        make.top.equalTo(self.contentView.mas_top).with.offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(0);
    }];
}

- (UILabel *)contentLabel {
    if (_contentLabel == nil) {
        UILabel *contentLabel = [[UILabel alloc] init];
        _contentLabel = contentLabel;
        _contentLabel.font = KRegularFont(12);
        _contentLabel.textColor = KTextColor;
        _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _contentLabel.numberOfLines = 0;
        [self.contentView addSubview: _contentLabel];
    }
    return _contentLabel;
}

- (void)setDelegate:(id<UniversalCollectionViewCellDataDelegate>)delegate {
    TSAgreementSectionItemModel *item = [delegate universalCollectionViewCellModel:self.indexPath];
    self.contentLabel.text = item.content;
}

@end


@interface TSAgreementView ()
/** 背景视图 */
@property(nonatomic, strong) UIView *contentView;
/** 标题  */
@property(nonatomic, strong) UILabel *titleLabel;
/** 关闭按钮  */
@property(nonatomic, strong) UIButton *closeButton;
/** data */
@property (nonatomic, strong) TSAgreementDataController *dataController;
/** title  */
@property(nonatomic, copy) NSString *title;



@property(nonatomic, strong) TSWKWebView *webView;
@end

@implementation TSAgreementView

- (instancetype)initWithTitle:(NSString *)title AndState:(NSString *)state {
    if (self = [super init]) {
        _title = title;
        [self setUpInit];
        __weak __typeof(self)weakSelf = self;
        [self.dataController  fetchAgreementContentsWithState:state Complete:^(BOOL isSucess) {
            weakSelf.titleLabel.text  = weakSelf.dataController.agreementModel.title;
            NSString *url = [weakSelf.dataController.agreementModel.serverUrl stringByAppendingString:@"&mode=webview"];
            [weakSelf.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
        }];
    }
    return self;
}

+ (instancetype)agreementViewWithTitle:(NSString *)title AndState:(NSString *)state   {
    return [[self alloc] initWithTitle:title AndState:state];
}
 
- (void)show {
   
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:.5 animations:^{
        CGRect rect = self.contentView.frame;
        rect.origin.y = GK_STATUSBAR_NAVBAR_HEIGHT;
        self.contentView.frame = rect;
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:.5 animations:^{
        CGRect rect = self.contentView.frame;
        rect.origin.y += self.contentView.bounds.size.height;
        self.contentView.frame = rect;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)setUpInit {
    self.contentView.backgroundColor = KWhiteColor;
   
    self.frame = [[UIScreen mainScreen] bounds];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    self.contentView.frame = CGRectMake(KRateW(36), kScreenHeight, kScreenWidth - KRateW(36) * 2, kScreenHeight - GK_STATUSBAR_NAVBAR_HEIGHT * 2);
    [self addSubview:self.contentView];
    [self.contentView addSubview: self.titleLabel];
    [self.contentView addSubview:self.webView];
    [self.contentView addSubview:self.closeButton];
  
    [self.contentView setCorners:UIRectCornerAllCorners radius:12];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(42);
        make.right.equalTo(self.contentView.mas_right).with.offset(-42);
        make.top.equalTo(self.contentView.mas_top).with.offset(24);
    }];
    
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.top.equalTo(self.titleLabel.mas_bottom);
    }];
    
 
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_right).with.offset(0);
        make.centerY.equalTo(self.contentView.mas_top).with.offset(0);
        make.width.height.mas_equalTo(24);
    }];
}


- (UIView *)contentView {
    if (_contentView == nil) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}

 

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = KFont(PingFangSCMedium, 16);
        _titleLabel.textColor = KTextColor;
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
       
    }
    return _titleLabel;
}

- (UIButton *)closeButton {
    if (_closeButton == nil) {
        UIButton *closeButton = [[UIButton alloc] init];
        _closeButton = closeButton;
        //_closeButton.hidden = YES;
        [_closeButton setBackgroundImage:KImageMake(@"close_icon") forState:(UIControlStateNormal)];
        [_closeButton addTarget:self action:@selector(closeAction) forControlEvents:(UIControlEventTouchUpInside)];
      
    }
    return _closeButton;
}

- (TSAgreementDataController *)dataController {
    if (_dataController == nil) {
        _dataController = [[TSAgreementDataController alloc] init];
    }
    return _dataController;
}

- (TSWKWebView *)webView {
    if (!_webView) {
        _webView = [[TSWKWebView alloc]init];
    }
    return _webView;
}

#pragma mark - Actions
- (void)closeAction {
    [self dismiss];
}
 

@end
