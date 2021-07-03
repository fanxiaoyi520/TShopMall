//
//  TSBankCardViewController.m
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/24.
//

#import "TSBankCardViewController.h"
#import "TSBankCardCell.h"
#import "TSUnbundlingCardViewController.h"
#import "TSAddCardViewController.h"

@interface TSBankCardViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,TSBankCardFooterDelegate> {
    ///开始滑动时的 Y 值
    CGFloat _startSlidingY;
    ///向上滑动
    BOOL _upSliding;
    ///第一次运行
    BOOL _firstRun;
    NSArray * _bankNameArray;
}
@property (nonatomic ,strong) TSMineDataController *dataController;
@property (nonatomic ,strong) UICollectionView *collectionView;
@property (nonatomic ,strong) UICollectionViewFlowLayout *flatout;
@end

@implementation TSBankCardViewController
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.gk_navTitle = @"银行卡";
    [[TSGlobalNotifyServer sharedServer] jaf_addDelegate:self];
    
    @weakify(self);
    [self.dataController fetchQueryBankCardListDataComplete:^(BOOL isSucess) {
        @strongify(self);
        if (isSucess) {
            CGFloat width = kScreenWidth-32;
            if (self.dataController.bankCardArray.count < 3) {
                self.flatout.itemSize = CGSizeMake(width, 120);
                self.flatout.minimumLineSpacing = 11;
            } else {
                self.flatout.itemSize = CGSizeMake(width, 83);
                self.flatout.minimumLineSpacing = -11;
            }
            [self.collectionView reloadData];
        }
    }];
}

- (void)initData {
    _firstRun=YES;
    _upSliding=YES;
}

- (void)fillCustomView {
    [self initData];
    CGFloat width = kScreenWidth-32;
    if ([self.dataController.walletModel.count integerValue] < 3) {
        self.flatout.itemSize = CGSizeMake(width, 120);
        self.flatout.minimumLineSpacing = 11;
    } else {
        self.flatout.itemSize = CGSizeMake(width, 83);
        self.flatout.minimumLineSpacing = -11;
    }
    
    UICollectionViewFlowLayout *flatout = [[UICollectionViewFlowLayout alloc] init];
    self.flatout = flatout;
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,GK_STATUSBAR_NAVBAR_HEIGHT, kScreenWidth, kScreenHeight-GK_STATUSBAR_NAVBAR_HEIGHT) collectionViewLayout:flatout];
    collectionView.dataSource=self;
    collectionView.delegate=self;
    /*tableView的数据无论多少，它的界面默认都是可以滑动的。
     和tableView相比，当collectionView的数据较少不够一个屏幕时，它无法滑动。
     解决方案：设置为总能垂直滑动就OK了。 alwaysBounceVertical =YES */
    collectionView.alwaysBounceVertical = YES;
    collectionView.backgroundColor=KWhiteColor;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    [collectionView registerClass:[TSBankCardCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [collectionView registerClass:[TSBankCardFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView"];
    [collectionView registerClass:[TSBankCardHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    
    RefreshGifHeader *mj_header = [RefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(mjHeadreRefresh)];
    if (GK_STATUSBAR_HEIGHT > 20) {
        mj_header.loadingOffsetTop = 30;
    }
    collectionView.mj_header = mj_header;
    collectionView.mj_header.hidden = YES;
}

// MARK: actions
- (void)mjHeadreRefresh {
    @weakify(self);
    [self.dataController fetchQueryBankCardListDataComplete:^(BOOL isSucess) {
        @strongify(self);
        if (isSucess) {
            CGFloat width = kScreenWidth-32;
            if (self.dataController.bankCardArray.count < 3) {
                self.flatout.itemSize = CGSizeMake(width, 120);
                self.flatout.minimumLineSpacing = 11;
            } else {
                self.flatout.itemSize = CGSizeMake(width, 83);
                self.flatout.minimumLineSpacing = -11;
            }
            [self.collectionView.mj_header endRefreshing];
            self.collectionView.mj_header.hidden = YES;
            [self.collectionView reloadData];
        }
    }];
}

// MARK: UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (!self.dataController.bankCardArray || self.dataController.bankCardArray.count == 0)
        return 0;
    return self.dataController.bankCardArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TSBankCardCell * cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    [cell setModel:self.dataController.bankCardArray[indexPath.row] indexPath:indexPath];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(kScreenWidth, 67);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (!self.dataController.bankCardArray || self.dataController.bankCardArray.count == 0)
        return CGSizeMake(kScreenWidth, 314);
    return CGSizeMake(0, 0);
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        reusableview = headerView;
    } else {
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        footerView.backgroundColor = KWhiteColor;
        if ([footerView isKindOfClass:TSBankCardFooter.class]) {
            TSBankCardFooter *kFooterView = (TSBankCardFooter *)footerView;
            kFooterView.kDelegate = self;
        }
        reusableview = footerView;
    }
    return reusableview;
}

// MARK: UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    if (_firstRun) {
        /*第一次运行显示界面时 所有显示的cell都放到最高层 后出现的就会压住前面的*/
        //上
        [collectionView bringSubviewToFront:cell];
    } else {
        
        if (_upSliding) {
              /* 向上滑时 后出现的就会压住前面的*/
            //上滑
            [collectionView bringSubviewToFront:cell];
        } else {
             /* 向下滑时 把每个将要出现的放到最底部 后出现的就会在前一个cell的下面*/
            //下滑
            [collectionView sendSubviewToBack:cell];
        }
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    TSUnbundlingCardViewController *vc = [TSUnbundlingCardViewController new];
    vc.model = self.dataController.bankCardArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

// MARK: UIScrollViewDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    _startSlidingY = scrollView.contentOffset.y;
    _firstRun=NO;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y<_startSlidingY) {
        //下
        _upSliding=NO;
    } else  {
        //上
        _upSliding=YES;
    }
     _startSlidingY = scrollView.contentOffset.y;
}

// MARK: TSBankCardFooterDelegate
- (void)bankCardFooterAddBankCardAction:(id)sender {
    if (self.dataController.bankCardArray.count < 6) {
        TSAddCardViewController *vc = [TSAddCardViewController new];
        vc.isNotice = YES;
        [self.navigationController pushViewController:vc animated:YES];
    } else {
        [Popover popToastOnWindowWithText:@"最多添加6张银行卡"];
    }
}

// MARK: TSGlobalNotifyServer
-(void)addBankCard:(id _Nullable)info {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.collectionView.mj_header.hidden = NO;
        [self.collectionView.mj_header beginRefreshing];
    });
}

// MARK: get
- (TSMineDataController *)dataController {
    if (!_dataController) {
        _dataController = [[TSMineDataController alloc] init];
    }
    return _dataController;
}
@end
