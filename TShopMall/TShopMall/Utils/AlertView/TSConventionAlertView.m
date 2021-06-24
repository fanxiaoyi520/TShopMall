//
//  TSConventionAlertView.m
//  TSale
//
//  Created by Daisy  on 2020/12/7.
//  Copyright © 2020 TCL. All rights reserved.
//

#import "TSConventionAlertView.h"
#import "TSToolsManager.h"
#import "UIView+Frame.h"
#import "NSString+Frame.h"

@interface TCLAlertBtn : UIButton

@property (nonatomic, copy) void (^btnHandler)(TCLAlertBtn * btn);

+(instancetype)tcl_alertBtnWithTitle:(NSString *)title
                          titleColor:(UIColor *)titleColor
                           titleFont:(UIFont *)titleFont
                             bgColor:(UIColor *) bgColor
                          btnHandler:(void(^)(TCLAlertBtn * btn))btnHandler;

@end

@implementation TCLAlertBtn

+(instancetype)tcl_alertBtnWithTitle:(NSString *)title
                          titleColor:(UIColor *)titleColor
                           titleFont:(UIFont *)titleFont
                             bgColor:(UIColor *)bgColor
                          btnHandler:(void (^)(TCLAlertBtn *))btnHandler
{
    return [[TCLAlertBtn alloc]initWithTitle:title
                                  titleColor:titleColor
                                   titleFont:titleFont
                             backgroundColor:bgColor
                               buttonHandler:btnHandler];
}

- (instancetype)initWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleColor
                    titleFont:(UIFont *)titleFont
              backgroundColor:(UIColor *)backgroundColor
                buttonHandler:(void (^)(TCLAlertBtn *))buttonHandler {
    
    if (self = [super init]) {
        
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:titleColor forState:UIControlStateNormal];
        self.titleLabel.font = titleFont;
        self.backgroundColor = backgroundColor;
        
        self.btnHandler = buttonHandler;
        
        [self addTarget:self action:@selector(buttonClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}
- (void)buttonClick {
    
    if (self.btnHandler) {
        self.btnHandler(self);
    }
}

@end

@implementation TSConventionAlertItem

+ (instancetype)tcl_itemWithTile:(NSString *)title
                           style:(TCLAlertItemStyle)style
                          handle:(void (^)(TSConventionAlertItem *))handler
{
    return [self tcl_itemWithTitle:title
                         titleFont:KFont(PingFangSCRegular, 16)
                        titleColor:KMainColor
                   backgroundColor:KWhiteColor
                             style:style handler:handler];
}
+ (instancetype)tcl_itemWithTile:(NSString *)title
                 backgroundColor:(UIColor  *)bgColor
                           style:(TCLAlertItemStyle)style
                          handle:(void(^)(TSConventionAlertItem * item))handler
{
    return [self tcl_itemWithTitle:title
                         titleFont:KFont(PingFangSCRegular, 16)
                        titleColor:KMainColor
                   backgroundColor:bgColor
                             style:style
                           handler:handler];
}
+ (instancetype)tcl_itemWithTitle:(NSString *)title
                        titleFont:(UIFont *)titleFont
                            style:(TCLAlertItemStyle)style
                          handler:(void (^)(TSConventionAlertItem *item))handler
{
    return [self tcl_itemWithTitle:title
                         titleFont:titleFont
                        titleColor:KMainColor
                   backgroundColor:KWhiteColor
                             style:style
                           handler:handler];
}
+ (instancetype)tcl_itemWithTitle:(NSString *)title
                       titleColor:(UIColor *)titleColor
                            style:(TCLAlertItemStyle)style
                          handler:(void (^)(TSConventionAlertItem *item))handler
{
    return [self tcl_itemWithTitle:title
                         titleFont:KFont(PingFangSCRegular, 16)
                        titleColor:titleColor
                   backgroundColor:KWhiteColor
                             style:style handler:handler];
}
+ (instancetype)tcl_itemWithTitle:(NSString *)title
                        titleFont:(UIFont *)titleFont
                       titleColor:(UIColor *)titleColor
                            style:(TCLAlertItemStyle)style
                          handler:(void (^)(TSConventionAlertItem *item))handler
{
    return  [self tcl_itemWithTitle:title
                          titleFont:titleFont
                         titleColor:titleColor
                    backgroundColor:KWhiteColor
                              style:style
                            handler:handler];
}

+ (instancetype)tcl_itemWithTitle:(NSString *)title
                       titleColor:(UIColor *)titleColor
                  backgroundColor:(UIColor *)backgroundColor
                            style:(TCLAlertItemStyle)style
                          handler:(void (^)(TSConventionAlertItem *item))handler
{
    return  [self tcl_itemWithTitle:title
                          titleFont:KFont(PingFangSCRegular, 16)
                         titleColor:titleColor
                    backgroundColor:backgroundColor
                              style:style
                            handler:handler];
}
+ (instancetype)tcl_itemWithTitle:(NSString *)title
                        titleFont:(UIFont *)titleFont
                  backgroundColor:(UIColor *)backgroundColor
                            style:(TCLAlertItemStyle)style
                          handler:(void (^)(TSConventionAlertItem *item))handler
{
    return  [self tcl_itemWithTitle:title
                          titleFont:titleFont
                         titleColor:KMainColor
                    backgroundColor:backgroundColor
                              style:style handler:handler];
    
}
+ (instancetype)tcl_itemWithTitle:(NSString *)title
                        titleFont:(UIFont *)titleFont
                       titleColor:(UIColor *)titleColor
                  backgroundColor:(UIColor *)backgroundColor
                            style:(TCLAlertItemStyle)style
                          handler:(void (^)(TSConventionAlertItem *item))handler
{
    if (style == TCLAlertItemStyleCancel) {
        titleFont =  KFont(PingFangSCRegular, 16);
    }
    TSConventionAlertItem *item = [[TSConventionAlertItem alloc]initWithTitle:title
                                                                    titleFont:titleFont
                                                                   titleColor:titleColor
                                                              backgroundColor:backgroundColor
                                                                        style:style
                                                                      handler:handler];
    return  item;
}

- (instancetype)initWithTitle:(NSString *)title
                    titleFont:(UIFont *)titleFont
                   titleColor:(UIColor *)titleColor
              backgroundColor:(UIColor *)backgroundColor
                        style:(TCLAlertItemStyle)style
                      handler:(void (^)(TSConventionAlertItem *item))handler
{
    if(self  = [super init])
    {
        self.title = title;
        self.titleFont = titleFont;
        self.titleColor  = titleColor;
        self.backgrooundColor = backgroundColor;
        self.showStyle = style;
        self.handler =   handler;
    }
    return   self;
}
@end

@interface TSConventionAlertView()

@property (nonatomic, strong) NSMutableArray<TSConventionAlertItem *> * cancelItemArray; //存放按钮

@property (nonatomic, strong) NSMutableArray<TSConventionAlertItem *> * allItemArray;//存放总得item数组

@property (nonatomic, weak) UIView *wholeContainerView;  //整体容器视图

@property (nonatomic, weak) UILabel *titleLable;  //标题

@property (nonatomic, weak) UILabel *msgLable; //消息

@property (nonatomic, weak) UIView *btnContainerView;  //TODO:

@end

@implementation TSConventionAlertView


-(NSMutableArray<TSConventionAlertItem *> *)cancelItemArray
{
    if (!_cancelItemArray) {
        _cancelItemArray = [NSMutableArray array];
        
    }
    return _cancelItemArray;
}

-(NSMutableArray<TSConventionAlertItem *> *)allItemArray
{
    if (!_allItemArray) {
        _allItemArray = [NSMutableArray array];
        
    }
    return _allItemArray;
}

+(void)initialize
{
    if (self != [TSConventionAlertView class]) return;
    
    //设置整体外观
    TSConventionAlertView *appearance = [self appearance];
    appearance.viewBackgroundColor = KWhiteColor;
    appearance.titleColor =  KTextColor;
    appearance.msgColor = KTextColor;
    appearance.titleFont = KFont(PingFangSCRegular, 18);
}

+(instancetype)tcl_alertViewWithPreferredStyle:(TCLAlertViewStyle)preferredStyle
                                       msgFont:(UIFont *)msgFont
                                   widthMargin:(CGFloat)widthMargin
                               highlightedText:(NSString *)highlighted
                                  hasPrefixStr:(NSString *)prefixStr
                              highlightedColor:(UIColor *)highliaghtColor
{
    return  [self tcl_alertViewWithTitle:nil
                                 message:nil
                          preferredStyle:preferredStyle
                          animationStyle:TCLAlertViewAnimationStyleDefault
                                 msgFont:msgFont
                             widthMargin:widthMargin
                         highlightedText:highlighted
                            hasPrefixStr:prefixStr
                        highlightedColor:highliaghtColor];
}

+(instancetype)tcl_alertViewWithTitle:(NSString *)title
                              message:(NSString *)message
                       preferredStyle:(TCLAlertViewStyle)preferredStyle
                              msgFont:(UIFont *)msgFont
                          widthMargin:(CGFloat)widthMargin
                      highlightedText:(NSString *)highlighted
                         hasPrefixStr:(NSString *)prefixStr
                     highlightedColor:(UIColor *)highliaghtColor
{
    
    return  [self tcl_alertViewWithTitle:title
                                 message:message
                          preferredStyle:preferredStyle
                          animationStyle:TCLAlertViewAnimationStyleDefault
                                 msgFont:msgFont
                             widthMargin:widthMargin
                         highlightedText:highlighted
                            hasPrefixStr:prefixStr
                        highlightedColor:highliaghtColor];
}

+(instancetype)tcl_alertViewWithPreferredStyle:(TCLAlertViewStyle)preferredStyle
                                animationStyle:(TCLAlertViewAnimationStyle)animationStyle
                                       msgFont:(UIFont *)msgFont
                                   widthMargin:(CGFloat)widthMargin
                               highlightedText:(NSString *)highlighted
                                  hasPrefixStr:(NSString *)prefixStr
                              highlightedColor:(UIColor *)highliaghtColor
{
    return  [self tcl_alertViewWithTitle:nil
                                 message:nil
                          preferredStyle:preferredStyle
                          animationStyle:animationStyle
                                 msgFont:  msgFont
                             widthMargin:widthMargin
                         highlightedText:highlighted
                            hasPrefixStr:prefixStr
                        highlightedColor:highliaghtColor];
}

+(instancetype)tcl_alertViewWithTitle:(NSString *)title
                              message:(NSString *)message
                       preferredStyle:(TCLAlertViewStyle)preferredStyle
                       animationStyle:(TCLAlertViewAnimationStyle)animationStyle
                              msgFont:(UIFont *)msgFont
                          widthMargin:(CGFloat)widthMargin
                      highlightedText:(NSString *)highlighted
                         hasPrefixStr:(NSString *)prefixStr
                     highlightedColor:(UIColor *)highliaghtColor
{
    TSConventionAlertView *alertView  = [[TSConventionAlertView alloc]initWithTitle:title
                                                                            message:message
                                                                     preferredStyle:preferredStyle
                                                                     animationStyle:animationStyle
                                                                            msgFont:msgFont
                                                                        widthMargin:widthMargin
                                                                    highlightedText:highlighted
                                                                       hasPrefixStr:prefixStr
                                                                   highlightedColor:highliaghtColor];
    return alertView;
}

-(instancetype)initWithTitle:(NSString *)title
                     message:(NSString *)msg
              preferredStyle:(TCLAlertViewStyle)preferredStyle
              animationStyle:(TCLAlertViewAnimationStyle)animationStyle
                     msgFont:(UIFont *)msgFont
                 widthMargin:(CGFloat)widthMargin
             highlightedText:(NSString *)highlighted
                hasPrefixStr:(NSString *)prefixStr
            highlightedColor:(UIColor *)highliaghtColor
{
    if (self  = [super init]) {
        self.frame  = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        self.title  = title;
        self.msg = msg;
        self.preferredStyle = preferredStyle;
        self.animationStyle = animationStyle;
        self.msgFont = msgFont;
        self.widthMargin = widthMargin;
        self.highliaghtColor  = highliaghtColor;
        self.highliaghtStr = highlighted;
        self.prefixStr = prefixStr;
        [self tcl_setupView];
    }
    return self;
}
-(void)tcl_setupView
{
    UIView *bgView = [UIView new];
    bgView.backgroundColor = KClearColor;
    [self addSubview:bgView];
    self.wholeContainerView  = bgView;
    
    UIView *btnContainerView = [UIView new];
    btnContainerView.backgroundColor = self.viewBackgroundColor;
    [bgView addSubview:btnContainerView];
    self.btnContainerView = btnContainerView;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.textColor = self.titleColor;
    titleLabel.text = self.title;
    titleLabel.font = self.titleFont;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.numberOfLines = 0;
    [btnContainerView addSubview:titleLabel];
    self.titleLable = titleLabel;
    
    if (![self.msg isNotBlank]) {
        return;
    }
    UILabel *messageLabel = [[UILabel alloc] init];
    messageLabel.textColor = self.msgColor;
    messageLabel.font = self.msgFont;
    messageLabel.attributedText  = [[TSToolsManager shareManager] nomalText:self.msg highlightedText:self.highliaghtStr hasPrefixStr:self.prefixStr highlightedColor:self.highliaghtColor];
    
    messageLabel.numberOfLines = 0;
    messageLabel.textAlignment = NSTextAlignmentCenter;
    [btnContainerView addSubview:messageLabel];
    self.msgLable = messageLabel;
}
-(void)tcl_addAlertItem:(TSConventionAlertItem *)alertItem
{
    if (self.preferredStyle  == TCLAlertViewStyleActionSheet) {  //sheet 类型
        if (alertItem.showStyle == TCLAlertItemStyleCancel) { //取消
            [self.cancelItemArray addObject:alertItem];
        } else {  //其他 默认
            [self.allItemArray addObject:alertItem];
        }
        if (self.cancelItemArray.count > 0) {//如果取消类型得到按钮>1 时,保留最后一个放在 取消类型数组 其他的移到默认类型
            NSMutableArray *tempArr  = [NSMutableArray array];
            [tempArr addObjectsFromArray:self.cancelItemArray];
            
            for (NSInteger i = 0; i < self.cancelItemArray.count; i ++) {
                if (tempArr.count - 1 != i) {
                    TSConventionAlertItem *item = tempArr[i];
                    [self.cancelItemArray removeObject:item];
                    
                    [self.allItemArray addObject:item];
                }
            }
            
        }
    }  else {
        
        [self.allItemArray addObject:alertItem];
    }
}
-(void)setTitleColor:(UIColor *)titleColor
{
    _titleColor = titleColor;
    
    self.titleLable.textColor = titleColor;
}
-(void)setTitleFont:(UIFont *)titleFont
{
    _titleFont =  titleFont;
    
    self.titleLable.font = titleFont;
}
-(void)setMsgColor:(UIColor *)msgColor
{
    _msgColor  = msgColor;
    
}
-(void)setMsgFont:(UIFont *)msgFont
{
    _msgFont = msgFont;
    
    self.msgLable.font =  msgFont;
}
-(void)setWidthMargin:(CGFloat)widthMargin
{
    _widthMargin = widthMargin;
}
-(void)setHighliaghtColor:(UIColor *)highliaghtColor
{
    _highliaghtColor  = highliaghtColor;
}
-(void)setHighliaghtStr:(NSString *)highliaghtStr
{
    _highliaghtStr = highliaghtStr;
}
-(void)setPrefixStr:(NSString *)prefixStr
{
    _prefixStr  = prefixStr;
}
-(void)setViewBackgroundColor:(UIColor *)viewBackgroundColor

{
    _viewBackgroundColor  = viewBackgroundColor;
    
    self.btnContainerView.backgroundColor  = viewBackgroundColor;
}

-(void)tcl_showView
{
    if (self.title.length < 0 && self.msg.length <= 0 && self.allItemArray.count <= 0 && self.cancelItemArray.count <= 0) {
        return;
    }
    [self tcl_calculateFrame];
    
    UIWindow* window = nil;
    if (@available(iOS 13.0, *)) {
        
        for (UIWindowScene* windowScene in [UIApplication sharedApplication].connectedScenes)
        {
            if (windowScene.activationState == UISceneActivationStateForegroundActive)
            {
                window = windowScene.windows.firstObject;
                
                break;
            }
        }
        
    } else  {
        
        window = [UIApplication  sharedApplication].keyWindow;
        
    }
    [window addSubview:self];
    
    if (self.animationStyle == TCLAlertViewAnimationStyleDefault) {
        
        self.backgroundColor = KHexAlphaColor(@"#000000", 0.3);
        
    } else if (self.animationStyle  == TCLAlertViewAnimationStyleTransparent){
        
        self.backgroundColor  = KClearColor;
        
        self.wholeContainerView.alpha = 0;
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.backgroundColor =  KHexAlphaColor(@"#000000", 0.3);
            
            self.wholeContainerView.alpha  = 1;
        }];
    } else if (self.animationStyle == TCLAlertViewAnimationStyleSlideFromBottom){
        
        self.backgroundColor = KClearColor;
        
        self.wholeContainerView.tcl_y = kScreenHeight;
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.backgroundColor =  KHexAlphaColor(@"#000000", 0.3);
            
            if (self.preferredStyle == TCLAlertViewStyleActionSheet) {
                
                self.wholeContainerView.tcl_y = self.tcl_height - self.wholeContainerView.tcl_height;
                
            }  else if (self.preferredStyle == TCLAlertViewStyleAlert){
                
                self.wholeContainerView.tcl_y = (self.tcl_height - self.wholeContainerView.tcl_height) * 0.5;
            }
        }];
    }
}

//隐藏
-(void)tcl_hideView
{
    if (self.animationStyle == TCLAlertItemStyleDefault)
    {
        
        [self removeFromSuperview];
        
    } else if (self.animationStyle == TCLAlertViewAnimationStyleTransparent)
    {
        
        [UIView animateWithDuration:0.3 animations:^{
            
            self.backgroundColor = KClearColor;
            
            self.wholeContainerView.alpha = 0;
            
        } completion:^(BOOL finished) {
            
            [self removeFromSuperview];
        }];
    } else if (self.animationStyle == TCLAlertViewAnimationStyleSlideFromBottom)
    {
        [UIView animateWithDuration:0.3 animations:^{
            
            self.backgroundColor = KClearColor;
            
            self.wholeContainerView.tcl_y = self.tcl_height;
            
        } completion:^(BOOL finished) {
            
            [self removeFromSuperview];
            
        }];
    }
}
#pragma mark --计算
- (void)tcl_calculateFrame {
    
    if (self.preferredStyle == TCLAlertViewStyleAlert) {//alert
        [self tcl_calculateFrameForAlert];
    } else if (self.preferredStyle == TCLAlertViewStyleActionSheet) {//sheet
        [self tcl_calculateFrameForActionSheet];
    }
    
}



- (void)tcl_calculateFrameForAlert {
    
    CGFloat marginHeight = 15;
    
    CGFloat wholeContainerViewY = 0;
    CGFloat wholeContainerViewW = 314;
    CGFloat wholeContainerViewX = (self.tcl_width - wholeContainerViewW) * 0.5;
    CGFloat wholeContainerViewH = 0;
    
    
    CGFloat buttonContainerViewX = 0;
    CGFloat buttonContainerViewY = 0;
    CGFloat buttonContainerViewW = wholeContainerViewW;
    CGFloat buttonContainerViewH = 0;
    
    
    CGFloat titleLabelX = _widthMargin;
    CGFloat titleLabelY = marginHeight;
    CGFloat titleLabelW = wholeContainerViewW - titleLabelX * 2;
    CGSize titleLabelSize = [_titleLable.text sizeWithFont:_titleLable.font maxW:titleLabelW];
    CGFloat titleLabelH = titleLabelSize.height;
    self.titleLable.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    
    if (_titleLable.text.length > 0) {
        buttonContainerViewH = CGRectGetMaxY(self.titleLable.frame) + marginHeight;
    } else {
        
        if (_msgLable.text.length > 0) {
            buttonContainerViewH = 29;
        } else {
            buttonContainerViewH = 0;
        }
        
    }
    
    
    CGFloat messageLabelX = _widthMargin;
    CGFloat messageLabelY = buttonContainerViewH  + 10;
    CGFloat messageLabelW = wholeContainerViewW - messageLabelX * 2;
    CGSize messageLabelSize = [_msgLable.text sizeWithFont:_msgLable.font maxW:titleLabelW];
    CGFloat messageLabelH = messageLabelSize.height;
    self.msgLable.frame = CGRectMake(messageLabelX, messageLabelY, messageLabelW, messageLabelH);
    
    if (_msgLable.text.length > 0) {
        
        buttonContainerViewH = CGRectGetMaxY(self.msgLable.frame) + 20;
        
    } else {
        
        buttonContainerViewH = buttonContainerViewH + 0;
        
    }
    if (self.allItemArray.count > 0) {
        
        CALayer *firstLine = [CALayer layer];
        firstLine.backgroundColor = KlineColor.CGColor;
        [_btnContainerView.layer addSublayer:firstLine];
        
        CGFloat firstLineX = 0;
        CGFloat firstLineY = buttonContainerViewH + 20;
        CGFloat firstLineW = buttonContainerViewW;
        CGFloat firstLineH = 0.5;
        firstLine.frame = CGRectMake(firstLineX, firstLineY, firstLineW, firstLineH);
        
        buttonContainerViewH = CGRectGetMaxY(firstLine.frame);
        
        NSInteger itemCount = self.allItemArray.count;
        
        CGFloat buttonHeight = 54;
        CGFloat lineHeight = 0.5;
        
        for (NSInteger i = 0; i < itemCount; i++) {
            
            TSConventionAlertItem *item = self.allItemArray[i];
            
            CGFloat buttonX = 0;
            CGFloat buttonY = 0;
            CGFloat buttonW = 0;
            CGFloat buttonH = buttonHeight;
            
            __weak __typeof(self)weakSelf = self;
            TCLAlertBtn  *button  = [TCLAlertBtn tcl_alertBtnWithTitle:item.title titleColor:item.titleColor titleFont:item.titleFont bgColor:item.backgrooundColor btnHandler:^(TCLAlertBtn *btn) {
                __strong __typeof(weakSelf)strongSelf = weakSelf;
                if (item.handler) {
                    item.handler(item);
                }
                [strongSelf tcl_hideView];
                
            }];
            
            if (itemCount == 2) {//两个按钮一排
                
                buttonW = buttonContainerViewW * 1.0 / 2;
                buttonX = buttonW * i;
                buttonY = buttonContainerViewH;
                
            } else {
                
                buttonY = buttonContainerViewH + buttonH * i;
                buttonX = 0;
                buttonW = buttonContainerViewW ;
                
            }
            
            CGRect buttonF = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            
            button.frame = buttonF;
            
            [_btnContainerView addSubview:button];
            
            if (itemCount == 2) {
                if (i != itemCount - 1) {
                    CALayer *line = [CALayer layer];
                    line.backgroundColor = KlineColor.CGColor;
                    [_btnContainerView.layer addSublayer:line];
                    
                    CGFloat lineW = 0.5;
                    CGFloat lineX = buttonW * (i + 1) - lineW *0.5;
                    CGFloat lineY = buttonY;
                    CGFloat lineH = buttonH;
                    line.frame = CGRectMake(lineX, lineY, lineW, lineH);
                    line.zPosition = 10000000;
                }
                
            } else {
                
                if (i != itemCount - 1) {
                    CALayer *line = [CALayer layer];
                    line.backgroundColor = KlineColor.CGColor;
                    [_btnContainerView.layer addSublayer:line];
                    
                    CGFloat lineW = buttonContainerViewW;
                    CGFloat lineX = 0;
                    CGFloat lineH = lineHeight;
                    CGFloat lineY = buttonY + buttonH - lineH;
                    line.frame = CGRectMake(lineX, lineY, lineW, lineH);
                    line.zPosition = 10000000;
                }
                
            }
            
        }
        
        if (itemCount == 2) {
            buttonContainerViewH = buttonContainerViewH + buttonHeight;
        } else {
            buttonContainerViewH = buttonContainerViewH + (itemCount * (buttonHeight + lineHeight) - lineHeight);
        }
        
        wholeContainerViewH = buttonContainerViewH ;
        
    } else {
        wholeContainerViewH = buttonContainerViewH ;
    }
    
    
    _btnContainerView.frame = CGRectMake(buttonContainerViewX, buttonContainerViewY, buttonContainerViewW, buttonContainerViewH);
    [_btnContainerView tcl_cornerAllCornersWithCornerRadius:13];
    
    wholeContainerViewY = (self.tcl_height - wholeContainerViewH) * 0.5;
    _wholeContainerView.frame = CGRectMake(wholeContainerViewX, wholeContainerViewY, wholeContainerViewW, wholeContainerViewH);
    
}
-(void)tcl_calculateFrameForActionSheet {
    
    CGFloat marginHeight = 15;
    
    CGFloat wholeContainerViewY = 0;
    CGFloat wholeContainerViewW = 355;
    CGFloat wholeContainerViewX = (self.tcl_width - wholeContainerViewW) * 0.5;
    CGFloat wholeContainerViewH = 0;
    
    
    CGFloat buttonContainerViewX = 0;
    CGFloat buttonContainerViewY = 0;
    CGFloat buttonContainerViewW = wholeContainerViewW;
    CGFloat buttonContainerViewH = 0;
    
    
    CGFloat titleLabelX = _widthMargin;
    CGFloat titleLabelY = marginHeight;
    CGFloat titleLabelW = wholeContainerViewW - titleLabelX * 2;
    CGSize titleLabelSize = [_titleLable.text sizeWithFont:_titleLable.font maxW:titleLabelW];
    CGFloat titleLabelH = titleLabelSize.height;
    self.titleLable.frame = CGRectMake(titleLabelX, titleLabelY, titleLabelW, titleLabelH);
    
    if (_titleLable.text.length > 0) {
        buttonContainerViewH = CGRectGetMaxY(self.titleLable.frame) + marginHeight;
    } else {
        
        if (_msgLable.text.length > 0) {
            buttonContainerViewH = 29;
        } else {
            buttonContainerViewH = 0;
        }
        
    }
    CGFloat messageLabelX = _widthMargin;
    CGFloat messageLabelY = buttonContainerViewH;
    CGFloat messageLabelW = wholeContainerViewW - messageLabelX * 2;
    CGSize messageLabelSize = [_msgLable.text sizeWithFont:_msgLable.font maxW:titleLabelW];
    CGFloat messageLabelH = messageLabelSize.height;
    self.msgLable.frame = CGRectMake(messageLabelX, messageLabelY, messageLabelW, messageLabelH);
    
    if (_msgLable.text.length > 0) {
        
        buttonContainerViewH = CGRectGetMaxY(self.msgLable.frame) + 20;
        
    } else {
        
        buttonContainerViewH = buttonContainerViewH + 0;
        
    }
    
    NSInteger itemCount = self.allItemArray.count;
    NSInteger cancelItemCount = self.cancelItemArray.count;
    
    if (itemCount + cancelItemCount > 0) {
        
        
        CGFloat buttonHeight = 60;
        CGFloat lineHeight = 0.5;
        
        for (NSInteger i = 0; i < itemCount; i++) {
            
            CALayer *firstLine = [CALayer layer];
            firstLine.backgroundColor = KlineColor.CGColor;
            [_btnContainerView.layer addSublayer:firstLine];
            
            CGFloat firstLineX = 0;
            CGFloat firstLineY = buttonContainerViewH;
            CGFloat firstLineW = buttonContainerViewW;
            CGFloat firstLineH = lineHeight;
            firstLine.frame = CGRectMake(firstLineX, firstLineY, firstLineW, firstLineH);
            
            if (i == 0 && buttonContainerViewH == 0) {
                firstLine.hidden = YES;
            } else {
                firstLine.hidden = NO;
            }
            
            buttonContainerViewH = buttonContainerViewH + lineHeight;
            
            TSConventionAlertItem *item = self.allItemArray[i];
            
            CGFloat buttonX = 0;
            CGFloat buttonY = buttonContainerViewH;
            CGFloat buttonW = buttonContainerViewW;
            CGFloat buttonH = buttonHeight;
            
            CGRect buttonF = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            
            
            __weak __typeof(self)weakSelf = self;
            TCLAlertBtn *button = [TCLAlertBtn tcl_alertBtnWithTitle:item.title titleColor:item.titleColor titleFont:item.titleFont bgColor:item.backgrooundColor btnHandler:^(TCLAlertBtn *btn) {
                __strong __typeof(weakSelf)strongSelf = weakSelf;
                if (item.handler) {
                    item.handler(item);
                }
                [strongSelf tcl_hideView];
            }];
            
            
            button.frame = buttonF;
            
            [_btnContainerView addSubview:button];
            
            buttonContainerViewH = buttonContainerViewH + buttonH;
        }
        
        wholeContainerViewH = buttonContainerViewH;
        
        
        if (cancelItemCount > 0) {
            
            TSConventionAlertItem *item = [self.cancelItemArray firstObject];
            
            CGFloat buttonX = 0;
            CGFloat buttonY = buttonContainerViewH + 10;
            CGFloat buttonW = buttonContainerViewW;
            CGFloat buttonH = buttonHeight;
            __weak __typeof(self)weakSelf = self;
            TCLAlertBtn *button = [TCLAlertBtn tcl_alertBtnWithTitle:item.title titleColor:item.titleColor titleFont:item.titleFont bgColor:item.backgrooundColor btnHandler:^(TCLAlertBtn *btn) {
                __strong __typeof(weakSelf)strongSelf = weakSelf;
                if (item.handler) {
                    item.handler(item);
                }
                [strongSelf tcl_hideView];
            }];
            
            CGRect buttonF = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            button.frame = buttonF;
            
            [_wholeContainerView addSubview:button];
            [button tcl_cornerAllCornersWithCornerRadius:13];
            
            wholeContainerViewH = CGRectGetMaxY(buttonF) + marginHeight ;
        } else {
            
            wholeContainerViewH = buttonContainerViewH + marginHeight;
            
        }
        
    } else {
        wholeContainerViewH = buttonContainerViewH;
    }
    
    _btnContainerView.frame = CGRectMake(buttonContainerViewX, buttonContainerViewY, buttonContainerViewW, buttonContainerViewH);
    [_btnContainerView tcl_cornerAllCornersWithCornerRadius:13];
    
    
    wholeContainerViewY = self.tcl_height - wholeContainerViewH;
    _wholeContainerView.frame = CGRectMake(wholeContainerViewX, wholeContainerViewY, wholeContainerViewW, wholeContainerViewH);
    
}
@end
