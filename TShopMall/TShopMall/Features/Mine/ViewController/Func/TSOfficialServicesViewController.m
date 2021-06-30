//
//  TSOfficialServicesViewController.m
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/26.
//

#define GH_SCREENWIDTH kScreenWidth-32-20
#define GH_SCREENHIGH  198.5
// 多少列
#define GH_BRANDSECTION 4
// 列表间隔距离
#define GH_BRANDDEV 2
#define GH_LIST1CELLWIDTH (GH_SCREENWIDTH - (GH_BRANDSECTION + 1)*GH_BRANDDEV) / GH_BRANDSECTION

#import "TSOfficialServicesViewController.h"
#import "TSOfficialServicesCell.h"
#import "TSHybridViewController.h"
@interface TSOfficialServicesViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSArray *_iconArray;
    NSArray *_titleArray;
    NSArray *_Urls;

}
@property (nonatomic ,strong) UIView *bgView;
@property (nonatomic ,strong) UIImageView *bottomImageView;
@property (nonatomic ,strong) UILabel *iphoneLab;
@end

@implementation TSOfficialServicesViewController
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.gk_navTitle = @"官方服务";
    _iconArray = @[@"mine_rengong",@"mine_baoxiu",@"mine_fuwujindu",@"mine_bao_baoxiu",@"mine_guzhangzicha",@"mine_fuwuzhengce",@"mine_shuomingshu",@"mine_qingxifuwu"];
    _titleArray = @[@"人工客服",@"报装报修",@"服务进度",@"延保查询",@"故障自查",@"服务政策\n收费标准",@"说明书",@"清洗服务"];
    _Urls = @[kMallH5StaffServiceUrl,kMallH5RepairsUrl,kMallH5ServiceScheduleUrl,kMallH5ExtendWarrantyUrl,kMallH5FaultInspectionUrl,kMallH5ServicePolicyUrl,kMallH5InstructionUrl,kMallH5ServiceEngineerUrl];
}

- (void)fillCustomView {
    
    [self.view addSubview:self.bgView];
    self.bgView.frame = CGRectMake(16, 20+GK_STATUSBAR_NAVBAR_HEIGHT, kScreenWidth-32, 198.5);
    [self.bgView jaf_customFilletRectCorner:UIRectCornerAllCorners cornerRadii:CGSizeMake(6, 6)];
    
    [self.view addSubview:self.bottomImageView];
    self.bottomImageView.frame = CGRectMake(0, self.view.bottom-126.54, kScreenWidth, 126.54);
    
    [self.bottomImageView addSubview:self.iphoneLab];
    self.iphoneLab.frame = CGRectMake(0, 44, kScreenWidth, 16.5);
    
    UICollectionViewFlowLayout *flatout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(10,0, self.bgView.width-20, self.bgView.height) collectionViewLayout:flatout];
    collectionView.dataSource=self;
    collectionView.delegate=self;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.backgroundColor = KWhiteColor;
    collectionView.bounces = NO;
    collectionView.scrollEnabled = NO;
    [self.bgView addSubview:collectionView];
    [collectionView registerClass:[TSOfficialServicesCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
}

// MARK: UICollectionViewDataSource &&
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell * cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    if ([cell isKindOfClass:TSOfficialServicesCell.class]) {
        TSOfficialServicesCell *officialServicesCell = (TSOfficialServicesCell *)cell;
        officialServicesCell.funcStr = _titleArray[indexPath.row];
        officialServicesCell.iconStr = _iconArray[indexPath.row];
    }
    return cell;
}

// 定义每个Cell的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(GH_LIST1CELLWIDTH, GH_LIST1CELLWIDTH);
}
 
// 定义每个Section的四边间距
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    // UIEdgeInsets insets = {top, left, bottom, right};
    return UIEdgeInsetsMake(GH_BRANDDEV, GH_BRANDDEV, GH_BRANDDEV, GH_BRANDDEV);
}
 
// 两行cell之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return GH_BRANDDEV;
}
 
// 两列cell之间的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return GH_BRANDDEV;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TSHybridViewController *vc = [[TSHybridViewController alloc]initWithURLString:_Urls[indexPath.row]]; 
    [self.navigationController pushViewController:vc animated:true];
}

// MARK: get
- (UIView *)bgView {
    if (!_bgView) {
        _bgView = [UIView new];
        _bgView.backgroundColor = KWhiteColor;
    }
    return _bgView;
}

- (UIImageView *)bottomImageView {
    if (!_bottomImageView) {
        _bottomImageView = [UIImageView new];
        _bottomImageView.image = KImageMake(@"mine_bg_weitu");
    }
    return _bottomImageView;
}

- (UILabel *)iphoneLab {
    if (!_iphoneLab) {
        _iphoneLab = [UILabel new];
        _iphoneLab.textColor = KHexColor(@"#000000");
        _iphoneLab.font = KRegularFont(12);
        _iphoneLab.text = @"官方热线： 4008 123456";
        _iphoneLab.textAlignment = NSTextAlignmentCenter;
    }
    return _iphoneLab;
}
@end
