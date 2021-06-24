//
//  TSShareView.m
//  TSale
//
//  Created by 陈洁 on 2021/2/24.
//  Copyright © 2021 TCL. All rights reserved.
//

@interface TSShareButton : UIButton

@end

@implementation TSShareButton

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupBasic];
    }
    return self;
}

-(void)setupBasic{
    self.backgroundColor = [UIColor whiteColor];
    self.titleLabel.font = KRegularFont(14);
    [self setTitleColor:KHexAlphaColor(@"#2D3132", 0.6) forState:UIControlStateNormal];
    [self setTitleColor:KHexAlphaColor(@"#2D3132", 0.6) forState:UIControlStateHighlighted];
    self.imageView.contentMode = UIViewContentModeCenter;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleX = 0;
    CGFloat titleY = 48 + 11;
    CGFloat titleW = contentRect.size.width;
    CGFloat titleH = 18;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageW = 48;
    CGFloat imageH = 48;
    CGFloat imageX = (contentRect.size.width - imageW) * 0.5;
    CGFloat imageY = 0;

    return CGRectMake(imageX, imageY, imageW, imageH);
}

@end

#import "TSShareView.h"
#import "WechatShareManager.h"

@interface TSShareView()

@property (nonatomic, strong) UILabel *shareTitleLabel;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *lineV;
@property (nonatomic, strong) UIButton *cancleButton;

@property (nonatomic, strong) NSDictionary *params;

@end

@implementation TSShareView

-(instancetype)initWithParams:(NSDictionary *)params{
    if (self = [super init]) {
        self.params = params;
        self.frame = [UIScreen mainScreen].bounds;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hidden)];
        [self addGestureRecognizer:tap];
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    }
    return self;
}

- (void)show{
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [self addSubview:self.bgView];
    [UIView animateWithDuration:.3f animations:^{
        CGRect frame = self.bgView.frame;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height - 225;
        self.bgView.frame = frame;
    }];
}

- (void)removeChildView{
    [UIView animateWithDuration:.3f animations:^{
        CGRect frame = self.bgView.frame;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height;
        self.bgView.frame = frame;
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

#pragma mark - Actions
-(void)shareAction:(UIButton *)sender{
    NSDictionary *data = self.params[@"data"];
    NSDictionary *paramsDic = data[@"params"];

    WechatShareType type = WechatShareTypeFriends;
    if (sender.tag == 1) {
        type = WechatShareTypeTimeline;
    }
    
    NSURL *url = [NSURL URLWithString:paramsDic[@"pictureUrl"]];
    
    [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:url completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        [[WechatShareManager shareInstance] shareWXWithTitle:paramsDic[@"title"]
                                              andDescription:paramsDic[@"subTitle"]
                                                 andShareURL:paramsDic[@"webUrl"]
                                               andThumbImage:image
                                                  andWXScene:type];
    }];
    [self removeChildView];
}

-(void)cancleButtonAction:(UIButton *)sender{
    [self removeChildView];
}

-(void)hidden{
    [self removeChildView];
}

#pragma mark - Setter and Getter
- (UIView *)bgView{
    if (!_bgView) {
        
        CGFloat height = [UIScreen mainScreen].bounds.size.height;
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, height - 225, width,225)];
        _bgView.backgroundColor = UIColor.whiteColor;
        [_bgView addSubview:self.shareTitleLabel];
        
        NSArray *titles = @[@"微信好友",@"朋友圈"];
        NSArray *images = @[@"wechat_friends",@"wechat_timeline"];
        
        for (int i = 0; i < titles.count; i++) {
            NSString *title = titles[i];
            NSString *image = images[i];
            
            CGFloat x = ([UIScreen mainScreen].bounds.size.width - (70 * 2 + 71)) * 0.5;
            if (i == titles.count - 1) {
                x = [UIScreen mainScreen].bounds.size.width * 0.5 + 35;
            }
            
            TSShareButton *button = [TSShareButton buttonWithType:UIButtonTypeCustom];
            [button setTitle:title forState:UIControlStateNormal];
            button.tag = i;
            [button setImage:KImageMake(image) forState:UIControlStateNormal];
            [button addTarget:self action:@selector(shareAction:) forControlEvents:UIControlEventTouchUpInside];
            button.frame = CGRectMake(x, 73, 80, 77);

            
            [_bgView addSubview:button];
        }
        

        [_bgView addSubview:self.lineV];
        [_bgView addSubview:self.cancleButton];
    }
    return _bgView;
}

- (UILabel *)shareTitleLabel{
    if (!_shareTitleLabel) {
        _shareTitleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 16, [UIScreen mainScreen].bounds.size.width, 26)];
        _shareTitleLabel.text = @"分享到";
        _shareTitleLabel.backgroundColor = [UIColor clearColor];
        _shareTitleLabel.textColor = KHexColor(@"#2D3132");
        _shareTitleLabel.textAlignment = NSTextAlignmentCenter;
        _shareTitleLabel.font = KRegularFont(16);
    }
    return _shareTitleLabel;
}

-(UIView *)lineV{
    if (!_lineV) {
        _lineV = [[UIView alloc] init];
        _lineV.frame = CGRectMake(0, 170, [UIScreen mainScreen].bounds.size.width, 10);
        _lineV.backgroundColor = KHexColor(@"#F3F4F5");
    }
    return _lineV;
}

- (UIButton *)cancleButton{
    if (!_cancleButton) {
        _cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleButton.frame = CGRectMake(0, 180, [UIScreen mainScreen].bounds.size.width, 45);
        _cancleButton.backgroundColor = UIColor.whiteColor;
        [_cancleButton setTitle:@"取消" forState:UIControlStateNormal];
        [_cancleButton setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        _cancleButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_cancleButton addTarget:self action:@selector(cancleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancleButton;
}

@end
