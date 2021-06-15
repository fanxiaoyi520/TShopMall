//
//  TSRefreshConfiger.m
//  TShopMall
//
//  Created by 橙子 on 2021/6/12.
//

#import "TSRefreshConfiger.h"


@interface TSRefreshConfiger()
@property (nonatomic, weak) id<TSRefreshDelegate> delegate;
@property (nonatomic, weak) UIScrollView *scrollView;
@property (nonatomic, strong) TSRefreshHeader *header;
@property (nonatomic, strong) MJRefreshAutoStateFooter *footer;
@property (nonatomic, assign) BOOL isLight;
@end

@implementation TSRefreshConfiger

+ (instancetype)configScrollView:(UIScrollView *)scrollView isLight:(BOOL)isLight response:(id<TSRefreshDelegate>)target type:(RefreshType)type{
    TSRefreshConfiger *configer = [TSRefreshConfiger new];
    configer.delegate = target;
    configer.scrollView = scrollView;
    configer.isLight = isLight;
    if (type == Header || type == Both) {
        [configer configLotHeader];
    }
    if (type == Footer || type == Both) {
        [configer configFooter];
    }
   
    [configer configLotHeader];
    
    return configer;
}

- (void)changeRefreshType:(BOOL)isLight{
    NSString *name = self.isLight==YES? @"refresh_header_light":@"refresh_header_dark";
    [self.header.lotView setAnimationNamed:name];
}

- (void)configLotHeader{
    TSRefreshHeader *header = [TSRefreshHeader new];
    header.jsonName = self.isLight==YES? @"refresh_header_light":@"refresh_header_dark";
    [header setRefreshingTarget:self refreshingAction:@selector(didReceiveHeaderRefreshEvent)];
    self.scrollView.mj_header = header;
}

- (void)configFooter{
    self.footer = [MJRefreshAutoStateFooter footerWithRefreshingTarget:self refreshingAction:@selector(didReceiveFooterRefreshEvent)];
    self.footer.stateLabel.font = KFont(PingFangSCRegular, 12);
    self.footer.stateLabel.textColor = KHexColor(@"#4b5675");
    [self.footer setTitle:@"" forState:MJRefreshStateIdle];
    [self.footer setTitle:@"——————  已加载全部  ——————" forState:MJRefreshStateNoMoreData];
    [self.footer setTitle:@"——————  加载中  ——————" forState:MJRefreshStateRefreshing];
    self.scrollView.mj_footer = self.footer;
}


- (void)didReceiveHeaderRefreshEvent{
    if ([self.delegate respondsToSelector:@selector(headerRefresh)]) {
        [self.delegate headerRefresh];
    }
}


- (void)didReceiveFooterRefreshEvent{
    if ([self.delegate respondsToSelector:@selector(footerRefresh)]) {
        [self.footer setTitle:@"——————  已加载全部  ——————" forState:MJRefreshStateNoMoreData];
        [self.footer setTitle:@"——————  加载中  ——————" forState:MJRefreshStateRefreshing];
        [self.delegate footerRefresh];
    }
}

- (void)startHeaderRefresh{
    [self.scrollView.mj_header beginRefreshing];
}

- (void)endRefresh:(BOOL)requestSuccess{
    NSString *message = @"";
    if (requestSuccess == NO) {
        message = @"——————  加载不成功，点击重试  ——————";
    } else {
        message = @"";
    }
    if (self.scrollView.mj_header.isRefreshing == YES) {
        [self.scrollView.mj_header endRefreshing];
    }
    if (self.scrollView.mj_footer.isRefreshing == YES) {
        [self.footer setTitle:message forState:MJRefreshStateIdle];
        [self.scrollView.mj_footer endRefreshing];
    }
    
    if (self.delegate.hasMoreData == YES) {
        [self.scrollView.mj_footer resetNoMoreData];
    } else {
        [self.scrollView.mj_footer endRefreshingWithNoMoreData];
    }
    
    if (self.scrollView.mj_footer != nil) {
        [self.scrollView sendSubviewToBack:self.scrollView.mj_footer];
    }
}
@end


@implementation TSRefreshHeader


- (void)prepare{
    [super prepare];
}

- (void)placeSubviews{
    [super placeSubviews];
    [self addSubview:self.lotView];
    self.lotView.frame = CGRectMake(kScreenWidth / 2.0 - KRateW(22.0), KRateW(20.0), KRateW(36.0), KRateW(24.0));
    [self.lotView play];
}

- (void)setJsonName:(NSString *)jsonName{
    if (self.lotView != nil) {
        return;
    }
    self.lotView = [LOTAnimationView animationNamed:jsonName];
    self.lotView.loopAnimation = YES;
    self.lotView.contentMode = UIViewContentModeScaleAspectFill;
    self.lotView.animationSpeed = 1.0;
    self.lotView.loopAnimation = YES;
}

- (void)setState:(MJRefreshState)state {
    MJRefreshCheckState;
    switch (state) {
        case MJRefreshStateIdle:{//普通闲置状态
            [self.lotView stop];
        }break;
        case MJRefreshStatePulling:{//松开就可以进行刷新的状态
        } break;
        case MJRefreshStateRefreshing:{//正在刷新中的状态
            self.lotView.animationProgress = 0;
            [self.lotView play];
        }break;
        default:
            break;
    }
}

@end
