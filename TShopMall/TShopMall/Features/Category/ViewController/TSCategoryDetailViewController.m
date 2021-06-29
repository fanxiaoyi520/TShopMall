//
//  TSCategoryDetailViewController.m
//  TShopMall
//
//  Created by  on 2021/6/29.
//

#import "TSCategoryDetailViewController.h"
#import "TSGridGoodsCollectionView.h"
#import "TSCategoryGroupViewModel.h"
#import "TSEmptyAlertView.h"
#import "RefreshGifFooter.h"
#import "TSSearchResultFittleView.h"

@interface TSCategoryDetailViewController ()<TSSearchResultFittleDelegate>
@property (nonatomic, strong) TSGridGoodsCollectionView *collectionView;
@property (nonatomic, strong) TSCategoryGroupViewModel *viewModel;
@property (nonatomic, strong) TSCategoryGroup *group;
@property (nonatomic, strong) TSCollectionViewMeanWidthLayout *currentLayout;
@property (nonatomic, strong) TSSearchResultFittleView *fittleView;
@property (nonatomic, copy) NSString *sortType;
@property (nonatomic, copy) NSString *sortBy;
@property (nonatomic, assign) NSInteger PageIndex;
@end

@implementation TSCategoryDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    TSCategoryGroup *group = [TSCategoryGroup new];
    
    group.groupId = self.uuid;
    self.group = group;
    self.PageIndex = 1;
    [self reloadContainerCollectionView];
    
    self.gk_navRightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"mall_category_btn_rail"] style:UIBarButtonItemStylePlain target:self action:@selector(changeLayout)];

}

- (void)fillCustomView{
    
    [self.view addSubview:self.fittleView];
    [self.fittleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(@(GK_NAVBAR_HEIGHT + GK_STATUSBAR_HEIGHT));
        make.height.equalTo(@(56.0));
    }];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.fittleView.mas_bottom);
    }];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}


#pragma mark - TSSearchResultFittleDelegate
- (void)operationType:(NSInteger)type sortType:(NSInteger)sortType{
    self.sortType = [NSString stringWithFormat:@"%ld",sortType];
    self.sortBy = [self.viewModel getSortByWithIndex:type];
    self.PageIndex = 1;
    [self reloadContainerCollectionView];
}

-(void)changeLayout{
    
    if (self.currentLayout.secionLayouts.firstObject.columns == 1) {
        self.currentLayout.updateSectionLayout = ^(TSCollectionViewMeanWidthSectionLayout * _Nonnull sectionLayout, NSIndexPath * _Nonnull indexPath) {
            sectionLayout.columnSpacing = 8;
            sectionLayout.rowSpacing = 8;
            sectionLayout.columns = 2;
            sectionLayout.rows = 0;
            sectionLayout.itemsHeight = 282;
        };
    }else{
        self.currentLayout.updateSectionLayout = ^(TSCollectionViewMeanWidthSectionLayout * _Nonnull sectionLayout, NSIndexPath * _Nonnull indexPath) {
            sectionLayout.columnSpacing = 0;
            sectionLayout.rowSpacing = 0;
            sectionLayout.columns = 1;
            sectionLayout.rows = 0;
            sectionLayout.itemsHeight = 120;
        };
    }
    [self.collectionView reloadData];
}

- (void)showEmptyView:(TSGridGoodsCollectionView *)view{
    view.collectionView.mj_footer.hidden = !view.items.count;

    if (view.items.count != 0) {
        [TSEmptyAlertView hideInView:view];
        return ;
    }
    TSEmptyAlertView.new.alertInfo(@"抱歉，没有找到商品哦～", @"重试").show(view, @"center", ^{
        [self reloadContainerCollectionView];
    });
}

- (void)showErrorView{
    @weakify(self);
    TSEmptyAlertView *alertView = [TSEmptyAlertView new];
    alertView.alertInfo(@"服务器开小差了", @"刷新");
    [self.collectionView addSubview:alertView];
    alertView.frame = self.collectionView.bounds;
    alertView.alertImage(@"homePage_container_error");
    alertView.show(self.collectionView, @"center", ^{
        @strongify(self);
        [self reloadContainerCollectionView];
    });
}

- (void)reloadContainerCollectionView{
    
    [Popover popProgressOnWindowWithProgressModel:[Popover defaultConfig] appearBlock:^(id frontView) {

    }];
    @weakify(self);
    [self.viewModel getCategoryGroupDataWithStartPageIndex:self.PageIndex count:10 group:self.group sortType:self.sortType sortBy:self.sortBy success:^(NSArray * _Nonnull list) {
        @strongify(self);
        [Popover removePopoverOnWindow];
        self.gk_navTitle = self.group.name;
        self.collectionView.items = list;
        [self.collectionView reloadData];
        if (list.count < self.group.totalNum) {
            [self.collectionView.collectionView.mj_footer resetNoMoreData];
        } else {
            [self.collectionView.collectionView.mj_footer endRefreshingWithNoMoreData];
        }
        [self showEmptyView:self.collectionView];
    } failure:^(NSError * _Nonnull error) {
        [Popover removePopoverOnWindow];
        [self showErrorView];
    }];
}

- (TSGridGoodsCollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[TSGridGoodsCollectionView alloc] initWithFrame:CGRectZero items:nil ColumnSpacing:0 rowSpacing:0 itemsHeight:120 rows:0 columns:1 padding:UIEdgeInsetsMake(10, 16, 10, 16) clickedBlock:^(id  _Nonnull selectItem, NSInteger index) {
            
        }];
        @weakify(self);
        _collectionView.collectionView.backgroundColor = KWhiteColor;
        _collectionView.collectionView.mj_footer = [RefreshGifFooter footerWithRefreshingBlock:^{
            @strongify(self)
            self.PageIndex = self.group.list.count?(self.group.totalNum/self.group.list.count + 1):1;
            [self reloadContainerCollectionView];

        }];
        _collectionView.collectionView.mj_footer.hidden = YES;
        _currentLayout = _collectionView.layout;
    }
    return _collectionView;
}

- (TSCategoryGroupViewModel *)viewModel{
    if (!_viewModel) {
        _viewModel = [TSCategoryGroupViewModel new];
    }
    return _viewModel;
}

- (TSSearchResultFittleView *)fittleView{
    if (!_fittleView) {
        _fittleView = [[TSSearchResultFittleView alloc] init];
        _fittleView.delegate = self;
    }
    return _fittleView;
}
@end
