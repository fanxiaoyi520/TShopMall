//
//  TSBankCardViewController.m
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/24.
//

#import "TSBankCardViewController.h"
#import "TSBankCardCell.h"

@interface TSBankCardViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,TSBankCardFooterDelegate> {
    ///开始滑动时的 Y 值
    CGFloat _startSlidingY;
    ///向上滑动
    BOOL _upSliding;
    ///第一次运行
    BOOL _firstRun;
    NSArray * _bankNameArray;
}
@end

@implementation TSBankCardViewController
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.gk_navTitle = @"银行卡";
}

- (void)initData {
    _firstRun=YES;
    _upSliding=YES;
    _bankNameArray=@[@"中国银行",@"建设银行",@"中信银行",@"中国农业银行"];
}

- (void)fillCustomView {
    [self initData];
    
    UICollectionViewFlowLayout *flatout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat width = kScreenWidth-32;
    flatout.itemSize = CGSizeMake(width, 83);
    //负值 折叠效果
    flatout.minimumLineSpacing = -11;
    
    UICollectionView * collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0,GK_STATUSBAR_NAVBAR_HEIGHT, kScreenWidth, kScreenHeight-GK_STATUSBAR_NAVBAR_HEIGHT) collectionViewLayout:flatout];
    collectionView.dataSource=self;
    collectionView.delegate=self;
    /*tableView的数据无论多少，它的界面默认都是可以滑动的。
     和tableView相比，当collectionView的数据较少不够一个屏幕时，它无法滑动。
     解决方案：设置为总能垂直滑动就OK了。 alwaysBounceVertical =YES */
    collectionView.alwaysBounceVertical = YES;
    collectionView.backgroundColor=KWhiteColor;
    [self.view addSubview:collectionView];
    [collectionView registerClass:[TSBankCardCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    [collectionView registerClass:[TSBankCardFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView"];
}

// MARK: UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _bankNameArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TSBankCardCell * cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    cell.backgroundColor= [UIColor colorWithRed: arc4random_uniform(256)/255.0f green: arc4random_uniform(256)/255.0f blue: arc4random_uniform(256)/255.0f alpha:1];
    cell.userName=@"高富帅";
    cell.bankName=_bankNameArray[indexPath.row];
    cell.account=@"****  ****  ****  8888";
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(kScreenWidth, 67);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
    footerView.backgroundColor = KWhiteColor;

    if ([footerView isKindOfClass:TSBankCardFooter.class]) {
        TSBankCardFooter *kFooterView = (TSBankCardFooter *)footerView;
        kFooterView.kDelegate = self;
    }
    return footerView;
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
    NSLog(@"添加银行卡");
}

// MARK: get

@end
