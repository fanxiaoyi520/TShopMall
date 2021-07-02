//
//  TSInviteFriendsPhotoCell.m
//  TShopMall
//
//  Created by 林伟 on 2021/7/1.
//

#import "TSInviteFriendsPhotoCell.h"
@interface TSInviteFriendsPhotoItemCell : UICollectionViewCell
@property(nonatomic,strong) UIImageView *img;
@end
@implementation TSInviteFriendsPhotoItemCell
- (UIImageView *)img {
    if (!_img) {
        _img = [[UIImageView alloc] init];
        _img.contentMode = UIViewContentModeScaleAspectFill;
    }
    return  _img;
}
@end
@interface TSInviteFriendsPhotoCell()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) UIImageView *backImg;
@property(nonatomic,assign) NSInteger selectedIndex;
@property(nonatomic,strong) UIVisualEffectView *effectview;
@end

@implementation TSInviteFriendsPhotoCell

-(void)fillCustomContentView {
    [self.contentView  addSubview:self.backImg];
    [self.contentView  addSubview:self.collectionView];
    [self.backImg addSubview:self.effectview];
    self.selectedIndex = 0;
    [self.backImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView );
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView );
    }];
    
    [self.effectview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.backImg);
    }];
}
 


#pragma mark - UICollectionViewDataSource


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  3;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TSInviteFriendsPhotoItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TSInviteFriendsPhotoItemCell" forIndexPath:indexPath];
//    cell.img.image = KImageMake(<#img#>)
    cell.img.backgroundColor = [UIColor redColor];
    return  cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.selectedIndex != indexPath.row) {
        return  CGSizeMake(92, 200);
    } else {
        return  CGSizeMake(110, 240);
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    _selectedIndex = indexPath.row;
    [collectionView reloadData];
    [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:true];
}

 
-(UIVisualEffectView *)effectview {
    if (!_effectview) {
        UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
        _effectview = [[UIVisualEffectView alloc] initWithEffect:blur];
    }
    return  _effectview;
}
- (UIImageView *)backImg {
    if (!_backImg) {
        _backImg = [[UIImageView alloc] init];
        _backImg.contentMode = UIViewContentModeScaleAspectFill;
    }
    return  _backImg;
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                             collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = UIColor.clearColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:TSInviteFriendsPhotoItemCell.class forCellWithReuseIdentifier:@"TSInviteFriendsPhotoItemCell"];
    }
    return _collectionView;
}
@end
