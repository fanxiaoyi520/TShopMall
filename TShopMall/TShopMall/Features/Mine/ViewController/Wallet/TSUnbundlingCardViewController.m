//
//  TSUnbundlingCardViewController.m
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/25.
//

#import "TSUnbundlingCardViewController.h"
#import "TSBankCardCell.h"
#import "TSOperationBankTipsViewController.h"
#import "TSAlertView.h"

@interface TSUnbundlingCardViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,TSBankCardUnbundlingFooterDelegate>{
    NSArray * _bankNameArray;
}

@end

@implementation TSUnbundlingCardViewController
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.gk_navTitle = @"银行卡";
}

- (void)initData {
    _bankNameArray=@[@"中国银行"];
    //_bankNameArray = @[];
}

- (void)fillCustomView {
    [self initData];
    
    UICollectionViewFlowLayout *flatout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat width = kScreenWidth-32;
    if (_bankNameArray.count < 3) {
        flatout.itemSize = CGSizeMake(width, 120);
        flatout.minimumLineSpacing = 11;
    } else {
        flatout.itemSize = CGSizeMake(width, 83);
        flatout.minimumLineSpacing = -11;
    }
    
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
    [collectionView registerClass:[TSBankCardUnbundlingFooter class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView"];
}

// MARK: UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _bankNameArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TSBankCardCell * cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    cell.backgroundColor= [UIColor colorWithRed: arc4random_uniform(256)/255.0f green: arc4random_uniform(256)/255.0f blue: arc4random_uniform(256)/255.0f alpha:1];
    [cell setModel:nil];
    cell.bankName=_bankNameArray[indexPath.row];
    cell.account=@"****  ****  ****  8888";
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
{
    return CGSizeMake(kScreenWidth, 83);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    if (kind != UICollectionElementKindSectionHeader) {
        UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FooterView" forIndexPath:indexPath];
        footerView.backgroundColor = KWhiteColor;
        if ([footerView isKindOfClass:TSBankCardUnbundlingFooter.class]) {
            TSBankCardUnbundlingFooter *kFooterView = (TSBankCardUnbundlingFooter *)footerView;
            kFooterView.kDelegate = self;
        }
        reusableview = footerView;
    }
    return reusableview;
}

// MARK: TSBankCardUnbundlingFooterDelegate
- (void)bankCardFooterBankCardUnbundlingAction:(id)sender {
    TSAlertView.new.alertInfo(nil, @"您是否确定解除银行卡").confirm(@"确定", ^{
        TSOperationBankTipsViewController *vc = [TSOperationBankTipsViewController new];
        vc.kNavTitle = @"银行卡";
        [self.navigationController pushViewController:vc animated:YES];

        [[TSUserLoginManager shareInstance] logout];

    }).cancel(@"取消", ^{}).show();
}
@end
