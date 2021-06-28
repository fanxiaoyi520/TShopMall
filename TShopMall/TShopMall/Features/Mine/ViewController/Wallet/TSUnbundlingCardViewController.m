//
//  TSUnbundlingCardViewController.m
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/6/25.
//

#import "TSUnbundlingCardViewController.h"
#import "TSBankCardCell.h"
#import "TSOperationBankTipsViewController.h"

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
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    NSMutableAttributedString *titleStr = [[NSMutableAttributedString alloc] initWithString:@"您是否确定解除银行卡"];
     [titleStr addAttribute:NSForegroundColorAttributeName value:KHexColor(@"#2D3132") range:NSMakeRange(0, titleStr.length)];
     [titleStr addAttribute:NSFontAttributeName value:KRegularFont(16) range:NSMakeRange(0, titleStr.length)];
     [alertController setValue:titleStr forKey:@"attributedTitle"];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        TSOperationBankTipsViewController *vc = [TSOperationBankTipsViewController new];
        vc.kNavTitle = @"银行卡";
        [self.navigationController pushViewController:vc animated:YES];
    }];
    [cancelAction setValue:KHexColor(@"#2D3132") forKey:@"_titleTextColor"];
    [okAction setValue:KHexColor(@"#E64C3D") forKey:@"_titleTextColor"];
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}
@end
