//
//  TSHomeViewController.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/3.
//

#import "TSHomeViewController.h"
#import "TSGeneralSearchButton.h"
#import "TSHomePageBackgroundReusableView.h"
#import "TSHomePageCategoryCell.h"

@interface TSHomeViewController ()<FMCollectionLayoutViewConfigurationDelegate,UICollectionViewDelegate>

@property(nonatomic, strong) FMLayoutView *layoutView;

@end

@implementation TSHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self hiddenNavigationBar];
    
    self.navigationController.navigationBar.hidden = YES;
    
    NSMutableArray *shareSections = [NSMutableArray array];
    
    {
        FMLayoutFixedSection *section = [FMLayoutFixedSection sectionWithSectionInset:UIEdgeInsetsMake(0, 0, 0, 0) itemSpace:10 lineSpace:10 column:1];
        section.header = [FMLayoutHeader elementSize:205 viewClass:[TSHomePageBackgroundReusableView class]];
        section.header.lastMargin = 10;
        section.header.type = FMLayoutHeaderTypeSuspensionBigger;
        section.header.minSize = 50;
        section.header.isStickTop = YES;
        section.header.inset = UIEdgeInsetsMake(0, 0, 0, 0);
        
        section.itemSize = CGSizeMake(100, 100);
        section.itemDatas = [@[@"1", @"2", @"3",@"1", @"2", @"3"] mutableCopy];
        section.cellElement = [FMLayoutElement elementWithViewClass:[TSHomePageCategoryCell class] isNib:NO];
        
        [shareSections addObject:section];
        
//        [self.layoutView.sections addObject:section];
//        [self.layoutView reloadData];
        
        self.automaticallyAdjustsScrollViewInsets = NO;
        
        FMLayoutView *view = [[FMLayoutView alloc] init];
        view.delegate = self;
        view.reloadOlnyChanged = NO;
        [view.layout setSections:shareSections];
        view.backgroundColor = [UIColor orangeColor];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.mas_equalTo(0);
        }];
        [view layoutIfNeeded];
    }
    
    
}

- (void)fillCustomView
{
//    [self.view addSubview:self.layoutView];
}

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
//    CGFloat top = self.view.ts_safeAreaInsets.top;
//    [self.layoutView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.mas_equalTo(0);
//        make.top.mas_equalTo(top);
//    }];
}


-(void)setupNavigationBar
{
//    TSGeneralSearchButton *searchButton = [TSGeneralSearchButton buttonWithType:UIButtonTypeCustom];
//    searchButton.frame = CGRectMake(0, 0, kScreenWidth - 65, 32);
//    UIBarButtonItem *searchItem = [[UIBarButtonItem alloc] initWithCustomView:searchButton];
//    searchItem.actionBlock = ^(id sender) {
//
//    };
//    self.navigationItem.titleView = searchButton;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"collectionView:didSelectItemAtIndexPath");
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidScroll");
}

#pragma mark - FMCollectionLayoutViewConfigurationDelegate
- (void)layoutView:(FMLayoutView *)layoutView configurationCell:(UICollectionViewCell *)cell indexPath:(NSIndexPath *)indexPath
{
    
}
- (void)layoutView:(FMLayoutView *)layoutView configurationHeader:(UICollectionReusableView *)header indexPath:(NSIndexPath *)indexPath
{
    
}
- (void)layoutView:(FMLayoutView *)layoutView configurationFooter:(UICollectionReusableView *)footer indexPath:(NSIndexPath *)indexPath
{
    
}
- (void)layoutView:(FMLayoutView *)layoutView configurationSectionBg:(UICollectionReusableView *)bg indexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - Getter
-(FMLayoutView *)layoutView
{
    if (!_layoutView) {
        _layoutView = [[FMLayoutView alloc] init];
        _layoutView.configuration = self;
        _layoutView.delegate = self;
        _layoutView.reloadOlnyChanged = NO;
        _layoutView.backgroundColor = [UIColor orangeColor];
    }
    return _layoutView;
}

@end
