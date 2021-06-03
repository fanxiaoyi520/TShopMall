//
//  SSNetworkAlertUtil.m
//  SSBaseTemplate
//
//  Created by 陈结 on 2021/5/21.
//

#import "SSNetworkAlertUtil.h"
#import "UIView+Extension.h"

@interface SSLoadView : UIView<CAAnimationDelegate>

@property(nonatomic, strong) UIView *circleOne;
@property(nonatomic, strong) UIView *circleTwo;
@property(nonatomic, strong) UIView *circleThree;

@property(nonatomic, assign) CGFloat animationRepeatTime;
@property(nonatomic, assign) CGFloat animationTime;

+ (SSLoadView *)showLoadingInView:(UIView *)view;
- (void)hideLoadingView;

@end

@implementation SSLoadView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.animationTime = 1.5;
        self.animationRepeatTime = 50;
        [self fillCustomView];
    }
    return self;
}

-(void)fillCustomView
{
    [self addSubview:self.circleOne];
    [self addSubview:self.circleTwo];
    [self addSubview:self.circleThree];
    
    self.circleTwo.centerX = self.centerX;
    self.circleTwo.centerY = self.centerY;
    
    self.circleOne.centerX = self.circleTwo.centerX - 20;
    self.circleOne.centerY = self.circleTwo.centerY - 20;
    
    self.circleThree.centerX = self.circleTwo.centerX + 20;
    self.circleThree.centerY = self.circleThree.centerY;
    
    [self startAnim];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.circleTwo.centerX = self.centerX;
    self.circleTwo.centerY = self.centerY;
    
    self.circleOne.centerX = self.circleTwo.centerX - 20;
    self.circleOne.centerY = self.circleTwo.centerY - 20;
    
    self.circleThree.centerX = self.circleTwo.centerX + 20;
    self.circleThree.centerY = self.circleThree.centerY;
}

+ (SSLoadView *)showLoadingInView:(UIView *)view
{
    SSLoadView *loadView = [[self alloc] initWithFrame:view.bounds];
    return loadView;
}

- (void)hideLoadingView
{
    [self.circleOne.layer removeAllAnimations];
    [self.circleTwo.layer removeAllAnimations];
    [self.circleThree.layer removeAllAnimations];
    [self removeFromSuperview];
}

#pragma mark - CAAnimationDelegate
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    [self.circleOne.layer removeAllAnimations];
    [self.circleTwo.layer removeAllAnimations];
    [self.circleThree.layer removeAllAnimations];
    [self removeFromSuperview];
}

#pragma mark - Private
- (void)startAnim
{
    CGPoint otherRoundCenter1 = CGPointMake(self.circleOne.centerX + 10, self.circleTwo.centerY);
    CGPoint otherRoundCenter2 = CGPointMake(self.circleTwo.centerX + 10, self.circleTwo.centerY);
    //圆1的路径
    UIBezierPath *path1 = [[UIBezierPath alloc] init];
    [path1 addArcWithCenter:otherRoundCenter1 radius:10 startAngle:-M_PI endAngle:0 clockwise:true];
    UIBezierPath *path1_1 = [[UIBezierPath alloc] init];
    [path1_1 addArcWithCenter:otherRoundCenter2 radius:10 startAngle:-M_PI endAngle:0 clockwise:false];
    [path1 appendPath:path1_1];
    
    [self viewMovePathAnimWith:self.circleOne path:path1 andTime:self.animationTime];
    [self viewColorAnimWith:self.circleOne fromColor:self.circleOne.backgroundColor toColor:self.circleThree.backgroundColor andTime:self.animationTime];
    
    UIBezierPath *path2 = [[UIBezierPath alloc] init];
    [path2 addArcWithCenter:otherRoundCenter1 radius:10 startAngle:0 endAngle:-M_PI clockwise:true];
    [self viewMovePathAnimWith:self.circleTwo path:path2 andTime:self.animationTime];
    [self viewColorAnimWith:self.circleTwo fromColor:self.circleTwo.backgroundColor toColor:self.circleOne.backgroundColor andTime:self.animationTime];

    UIBezierPath *path3 = [[UIBezierPath alloc] init];
    [path3 addArcWithCenter:otherRoundCenter2 radius:10 startAngle:0 endAngle:-M_PI clockwise:false];
    [self viewMovePathAnimWith:self.circleThree path:path3 andTime:self.animationTime];
    [self viewColorAnimWith:self.circleThree fromColor:self.circleThree.backgroundColor toColor:self.circleOne.backgroundColor andTime:self.animationTime];
}

///设置view的移动路线，这样抽出来因为每个圆的只有路径不一样
- (void)viewMovePathAnimWith:(UIView *)view path:(UIBezierPath *)path andTime:(CGFloat)time
{
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    anim.path = [path CGPath];
    anim.removedOnCompletion = false;
    anim.fillMode = kCAFillModeForwards;
    anim.calculationMode = kCAAnimationCubic;
    anim.repeatCount = self.animationRepeatTime;
    anim.duration = time;
    anim.autoreverses = NO;
    anim.delegate = self;
    anim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [view.layer addAnimation:anim forKey:@"animation"];
    
}
///设置view的颜色动画
- (void)viewColorAnimWith:(UIView *)view fromColor:(UIColor *)fromColor toColor:(UIColor *)toColor andTime:(CGFloat)time
{
    CABasicAnimation *colorAnim = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    colorAnim.toValue = (__bridge id _Nullable)([toColor CGColor]);
    colorAnim.fromValue = (__bridge id _Nullable)([fromColor CGColor]);
    colorAnim.duration = time;
    colorAnim.autoreverses = NO;
    colorAnim.fillMode = kCAFillModeForwards;
    colorAnim.removedOnCompletion = NO;
    colorAnim.repeatCount = self.animationRepeatTime;
    [view.layer addAnimation:colorAnim forKey:@"backgroundColor"];
    
}

#pragma mark - Setter & Getter
-(UIView *)circleOne
{
    if (!_circleOne) {
        
        UIColor *color = [UIColor colorWithRed:206/255.0 green:7/255.0 blue:85/255.0 alpha:1.0];
        
        _circleOne = [[UIView alloc] init];
        _circleOne.size = CGSizeMake(10, 10);
        _circleOne.backgroundColor = color;
        _circleOne.layer.cornerRadius = 5;
    }
    return _circleOne;
}

-(UIView *)circleTwo
{
    if (!_circleTwo) {
        
        UIColor *color = [UIColor colorWithRed:206/255.0 green:7/255.0 blue:85/255.0 alpha:0.6];
        
        _circleTwo = [[UIView alloc] init];
        _circleTwo.size = CGSizeMake(10, 10);
        _circleTwo.backgroundColor = color;
        _circleTwo.layer.cornerRadius = 5;
    }
    return _circleTwo;
}

-(UIView *)circleThree
{
    if (!_circleThree) {
        
        UIColor *color = [UIColor colorWithRed:206/255.0 green:7/255.0 blue:85/255.0 alpha:0.3];
        
        _circleThree = [[UIView alloc] init];
        _circleThree.size = CGSizeMake(10, 10);
        _circleThree.backgroundColor = color;
        _circleThree.layer.cornerRadius = 5;
    }
    return _circleThree;
}


@end

@implementation SSNetworkAlertUtil

+(void)showLoadingAlertViewInView:(__kindof UIView *)inView
{
    SSLoadView *loadView = [inView viewWithTag:999];
    if (loadView) {
        [loadView hideLoadingView];
    }
    
    loadView = [SSLoadView showLoadingInView:inView];
    loadView.tag = 999;
    [inView addSubview:loadView];
}

+(void)hideLoadingAlertView:(__kindof UIView *)inView
{
    SSLoadView *loadView = [inView viewWithTag:999];
    [loadView hideLoadingView];
}

@end
