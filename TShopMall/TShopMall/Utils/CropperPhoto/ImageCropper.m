//
//  ImageCropper.m
//  TCLPlus
//
//  Created by OwenChen on 2020/10/15.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import "ImageCropper.h"

#import "UIColor+Plugin.h"

static const CGFloat BottomViewHeight = 100.0;


@interface ImageCropper () <UIScrollViewDelegate> {
    CGFloat _contentViewHeight;
    CGFloat _selfWidth;
    CGRect _cropFrame;
}

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImageView *cropImageView;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, strong) UIButton *cancleButton;
@property (nonatomic, strong) UIButton *sureButton;
@property (nonatomic, strong) UIView *overLayView;

@end


@implementation ImageCropper

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];
    self.navigationItem.title = @"裁剪";
    self.edgesForExtendedLayout = UIRectEdgeNone;

    [self.view setBackgroundColor:[UIColor blackColor]];
    _selfWidth = self.view.frame.size.width;
    _contentViewHeight = self.view.frame.size.height - 100;

    if (self.navigationController) {
        CGRect rectOfStatusbar = [[UIApplication sharedApplication] statusBarFrame];
        CGRect rectOfNavigationbar = self.navigationController.navigationBar.frame;
        _contentViewHeight -= (rectOfNavigationbar.size.height + rectOfStatusbar.size.height);

        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:@"NavigationBarBackButtonWhite"] forState:UIControlStateNormal];
        button.frame = CGRectMake(0, 0, 44, 44);
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [button addTarget:self action:@selector(cancleButtonClick) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    }

    if (self.cropSize.width == 0 || self.cropSize.height == 0) {
        self.cropSize = CGSizeMake(_selfWidth - 60, _selfWidth - 60);
    }

    [self createUI];
    [self setupData];

    //绘制裁剪框
    if (self.isRound) {
        [self transparentCutRoundArea];
    } else {
        [self transparentCutSquareArea];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    CGFloat scale, autoScale;
    CGFloat cropWHRatio = _cropSize.width / _cropSize.height;
    CGFloat viewWHRatio = _selfWidth / _contentViewHeight;

    //计算最小缩放比例
    CGFloat imageWHRatio = _image.size.width / _image.size.height;
    if (cropWHRatio > imageWHRatio) {
        scale = _cropSize.width / _imageView.frame.size.width;
    } else {
        scale = _cropSize.height / _imageView.frame.size.height;
    }

    //计算自动填充屏幕缩放比例
    if (viewWHRatio > imageWHRatio) {
        autoScale = _contentViewHeight / _imageView.frame.size.width;
    } else {
        autoScale = _selfWidth / _imageView.frame.size.height;
    }

    //自动缩放填满裁剪区域
    [self.scrollView setZoomScale:autoScale animated:YES];
    //设置刚好填充满裁剪区域的缩放比例，为最小缩放比例
    [self.scrollView setMinimumZoomScale:scale];
    self.scrollView.userInteractionEnabled = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithHexString:@"#E64C3D"];
}

- (void)createUI {
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.imageView];
    [self.view addSubview:self.overLayView];
    [self.view addSubview:self.bottomView];

    [self.overLayView setFrame:self.view.frame];
    [self.scrollView setFrame:CGRectMake(0, 0, _selfWidth, _contentViewHeight)];
    [self.scrollView setContentSize:CGSizeMake(_selfWidth, _contentViewHeight)];
    [self.bottomView setFrame:CGRectMake(0, _contentViewHeight, _selfWidth, BottomViewHeight)];
}

- (void)setupData {
    //如果是圆形的话，对给的cropSize进行容错处理
    if (self.isRound) {
        if (self.cropSize.width >= self.cropSize.height) {
            self.cropSize = CGSizeMake(self.cropSize.height, self.cropSize.height);
        } else {
            self.cropSize = CGSizeMake(self.cropSize.width, self.cropSize.width);
        }
    }

    //设置裁剪框区域
    _cropFrame = CGRectMake((_selfWidth - self.cropSize.width) / 2, (_contentViewHeight - self.cropSize.height) / 2, self.cropSize.width, self.cropSize.height);

    //设置图片
    [_imageView setImage:self.image];

    //此处是根据裁剪区域和图片大小，让图片的imageView正好卡在裁剪区域内。等viewDidAppear的时候再进行缩放填充满裁剪区域
    CGFloat cropWHRatio = _cropSize.width / _cropSize.height;
    CGFloat imageWHRatio = _image.size.width / _image.size.height;
    CGFloat imageViewW, imageViewH, imageViewX, imageViewY;
    if (cropWHRatio > imageWHRatio) {
        imageViewW = imageWHRatio * _cropSize.height;
        imageViewH = _cropSize.height;
        imageViewX = (_cropSize.width - imageViewW) / 2 + (_selfWidth - _cropSize.width) / 2;
        imageViewY = (_contentViewHeight - _cropSize.height) / 2;
    } else {
        imageViewX = (_selfWidth - _cropSize.width) / 2;
        imageViewW = _cropSize.width;
        imageViewH = _cropSize.height / imageWHRatio;
        imageViewY = (_cropSize.height - imageViewH) / 2 + (_contentViewHeight - _cropSize.height) / 2;
    }
    [_imageView setFrame:CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH)];
}

#pragma mark -
//矩形裁剪区域
- (void)transparentCutSquareArea {
    //圆形透明区域
    UIBezierPath *alphaPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, _selfWidth, _contentViewHeight)];
    UIBezierPath *squarePath = [UIBezierPath bezierPathWithRect:_cropFrame];
    [alphaPath appendPath:squarePath];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = alphaPath.CGPath;
    shapeLayer.fillRule = kCAFillRuleEvenOdd;
    self.overLayView.layer.mask = shapeLayer;

    //裁剪框
    UIBezierPath *cropPath =
        [UIBezierPath bezierPathWithRect:CGRectMake(_cropFrame.origin.x - 1, _cropFrame.origin.y - 1, _cropFrame.size.width + 2, _cropFrame.size.height + 2)];
    CAShapeLayer *cropLayer = [CAShapeLayer layer];
    cropLayer.path = cropPath.CGPath;
    cropLayer.fillColor = [UIColor whiteColor].CGColor;
    cropLayer.strokeColor = [UIColor whiteColor].CGColor;
    [self.overLayView.layer addSublayer:cropLayer];
}

//圆形裁剪区域
- (void)transparentCutRoundArea {
    CGFloat arcX = _cropFrame.origin.x + _cropFrame.size.width / 2;
    CGFloat arcY = _cropFrame.origin.y + _cropFrame.size.height / 2;
    CGFloat arcRadius;
    if (_cropSize.height > _cropSize.width) {
        arcRadius = _cropSize.width / 2;
    } else {
        arcRadius = _cropSize.height / 2;
    }

    //圆形透明区域
    UIBezierPath *alphaPath = [UIBezierPath bezierPathWithRect:CGRectMake(0, 0, _selfWidth, _contentViewHeight)];
    UIBezierPath *arcPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(arcX, arcY) radius:arcRadius startAngle:0 endAngle:2 * M_PI clockwise:NO];
    [alphaPath appendPath:arcPath];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = alphaPath.CGPath;
    layer.fillRule = kCAFillRuleEvenOdd;
    self.overLayView.layer.mask = layer;

    //裁剪框
    UIBezierPath *cropPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(arcX, arcY) radius:arcRadius + 1 startAngle:0 endAngle:2 * M_PI clockwise:NO];
    CAShapeLayer *cropLayer = [CAShapeLayer layer];
    cropLayer.path = cropPath.CGPath;
    cropLayer.strokeColor = [UIColor whiteColor].CGColor;
    cropLayer.fillColor = [UIColor whiteColor].CGColor;
    [self.overLayView.layer addSublayer:cropLayer];
}

- (UIImage *)getSubImage {
    //图片大小和当前imageView的缩放比例
    CGFloat scaleRatio = self.image.size.width / _imageView.frame.size.width;
    // scrollView的缩放比例，即是ImageView的缩放比例
    CGFloat scrollScale = self.scrollView.zoomScale;
    //裁剪框的 左上、右上和左下三个点在初始ImageView上的坐标位置（注意：转换后的坐标为原始ImageView的坐标计算的，而非缩放后的）
    CGPoint leftTopPoint = [self.view convertPoint:_cropFrame.origin toView:_imageView];
    CGPoint rightTopPoint = [self.view convertPoint:CGPointMake(_cropFrame.origin.x + _cropSize.width, _cropFrame.origin.y) toView:_imageView];
    CGPoint leftBottomPoint = [self.view convertPoint:CGPointMake(_cropFrame.origin.x, _cropFrame.origin.y + _cropSize.height) toView:_imageView];

    //计算三个点在缩放后imageView上的坐标
    leftTopPoint = CGPointMake(leftTopPoint.x * scrollScale, leftTopPoint.y * scrollScale);
    rightTopPoint = CGPointMake(rightTopPoint.x * scrollScale, rightTopPoint.y * scrollScale);
    leftBottomPoint = CGPointMake(leftBottomPoint.x * scrollScale, leftBottomPoint.y * scrollScale);

    //计算裁剪区域在原始图片上的位置
    CGFloat width = (rightTopPoint.x - leftTopPoint.x) * scaleRatio;
    CGFloat height = (leftBottomPoint.y - leftTopPoint.y) * scaleRatio;
    CGRect myImageRect = CGRectMake(leftTopPoint.x * scaleRatio, leftTopPoint.y * scaleRatio, width, height);

    //裁剪图片
    CGImageRef imageRef = self.image.CGImage;
    CGImageRef subImageRef = CGImageCreateWithImageInRect(imageRef, myImageRect);
    UIGraphicsBeginImageContextWithOptions(myImageRect.size, YES, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextDrawImage(context, CGRectMake(0, 0, myImageRect.size.width, myImageRect.size.height), subImageRef);
    UIImage *subImage = [UIImage imageWithCGImage:subImageRef];
    CGImageRelease(subImageRef);
    UIGraphicsEndImageContext();

    //是否需要圆形图片
    if (self.isRound) {
        //将图片裁剪成圆形
        subImage = [self clipCircularImage:subImage];
    }
    return subImage;
}

//将图片裁剪成圆形
- (UIImage *)clipCircularImage:(UIImage *)image {
    CGFloat arcCenterX = image.size.width / 2;
    CGFloat arcCenterY = image.size.height / 2;

    UIGraphicsBeginImageContext(image.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextBeginPath(context);
    CGContextAddArc(context, arcCenterX, arcCenterY, image.size.width / 2, 0.0, 2 * M_PI, NO);
    CGContextClip(context);
    [image drawInRect:CGRectMake(0, 0, image.size.width, image.size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

#pragma mark - UIScrollViewDelegate(Zoom)
// 返回要在ScrollView中缩放的控件
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    //等比例放大图片以后，让放大后的ImageView保持在ScrollView的中央
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width) ? (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY =
        (scrollView.bounds.size.height > scrollView.contentSize.height) ? (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    _imageView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX, scrollView.contentSize.height * 0.5 + offsetY);

    //设置scrollView的contentSize，最小为self.view.frame
    CGFloat scrollW = scrollView.contentSize.width >= _selfWidth ? scrollView.contentSize.width : _selfWidth;
    CGFloat scrollH = scrollView.contentSize.height >= _contentViewHeight ? scrollView.contentSize.height : _contentViewHeight;
    [scrollView setContentSize:CGSizeMake(scrollW, scrollH)];

    //设置scrollView的contentInset
    CGFloat imageWidth = _imageView.frame.size.width;
    CGFloat imageHeight = _imageView.frame.size.height;
    CGFloat cropWidth = _cropSize.width;
    CGFloat cropHeight = _cropSize.height;

    CGFloat leftRightInset = 0.f, topBottomInset = 0.f;

    // imageview的大小和裁剪框大小的三种情况，保证imageview最多能滑动到裁剪框的边缘
    if (imageWidth <= cropWidth) {
        leftRightInset = 0;
    } else if (imageWidth >= cropWidth && imageWidth <= _selfWidth) {
        leftRightInset = (imageWidth - cropWidth) * 0.5;
    } else {
        leftRightInset = (_selfWidth - _cropSize.width) * 0.5;
    }

    if (imageHeight <= cropHeight) {
        topBottomInset = 0;
    } else if (imageHeight >= cropHeight && imageHeight <= _contentViewHeight) {
        topBottomInset = (imageHeight - cropHeight) * 0.5;
    } else {
        topBottomInset = (_contentViewHeight - _cropSize.height) * 0.5;
    }
    [self.scrollView setContentInset:UIEdgeInsetsMake(topBottomInset, leftRightInset, topBottomInset, leftRightInset)];
}

#pragma mark - Click Event
- (void)cancleButtonClick {
    if (self.cancelBlock) {
        self.cancelBlock(self);
    }

    if (self.navigationController && [self.navigationController.childViewControllers firstObject] != self) {
        [self.navigationController popViewControllerAnimated:YES];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)sureButtonClick {
    if (self.sureBlock) {
        self.sureBlock(self, [self getSubImage]);
    }

    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - lazyLoad
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.scrollsToTop = NO;
        //设置缩放的最大比例和最小比例
        _scrollView.maximumZoomScale = 10;
        _scrollView.minimumZoomScale = 1;
        //初始缩放比例为1
        [_scrollView setZoomScale:1 animated:YES];
        [_scrollView setFrame:CGRectMake(0, 0, _selfWidth, _contentViewHeight)];
        if (@available(iOS 11.0, *)) {
            _scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        } else {
            // Fallback on earlier versions
        }
    }
    return _scrollView;
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        [_imageView setUserInteractionEnabled:YES];
        [_imageView setContentMode:UIViewContentModeScaleAspectFill];
    }
    return _imageView;
}

- (UIView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIView alloc] init];
        _bottomView.backgroundColor = [UIColor blackColor];

        CGFloat buttonW = CGRectGetWidth(self.view.frame) - 24 * 2;
        CGFloat buttonX = 24.0;
        CGFloat buttonY = 14.0;
        CGFloat buttonH = 40.0;
        if (!self.navigationController) {
            buttonW = (CGRectGetWidth(self.view.frame) - buttonX * 3) / 2;
            _cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
            _cancleButton.backgroundColor = [UIColor lightGrayColor];
            [_cancleButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
            [_cancleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [_cancleButton setTitle:@"取消" forState:UIControlStateNormal];
            [_cancleButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
            [_cancleButton addTarget:self action:@selector(cancleButtonClick) forControlEvents:UIControlEventTouchUpInside];
            _cancleButton.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            _cancleButton.layer.cornerRadius = buttonH / 2;
            _cancleButton.layer.borderWidth = 1.0;
            _cancleButton.layer.borderColor = [UIColor whiteColor].CGColor;
            _cancleButton.clipsToBounds = YES;
            [_bottomView addSubview:_cancleButton];

            buttonX = buttonW + 2 * buttonX;
        }

        _sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureButton.backgroundColor = [UIColor colorWithHexString:@"#E64C3D"];
        [_sureButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
        [_sureButton.titleLabel setTextAlignment:NSTextAlignmentCenter];
        [_sureButton addTarget:self action:@selector(sureButtonClick) forControlEvents:UIControlEventTouchUpInside];
        _sureButton.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        _sureButton.layer.cornerRadius = buttonH / 2;
        _sureButton.clipsToBounds = YES;
        [_bottomView addSubview:_sureButton];
    }
    return _bottomView;
}

//用于展示裁剪框的视图
- (UIView *)overLayView {
    if (!_overLayView) {
        _overLayView = [[UIView alloc] init];
        _overLayView.userInteractionEnabled = NO;
        _overLayView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    }
    return _overLayView;
}

@end
