//
//  TSGoodDetailImageCell.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/15.
//

#import "TSGoodDetailImageCell.h"
#import "TSTextImageButton.h"
#import "TSMaterialImageCell.h"

@interface TSGoodDetailImageCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/// 背景视图
@property(nonatomic, strong) UIView *bgView;
/// 标题
@property(nonatomic, strong) UILabel *titleLabel;
/// 下载素材按钮
@property(nonatomic, strong) TSTextImageButton *downloadBtn;
/// 下载图片
@property(nonatomic, strong) UIButton *downloadImageBtn;

@property(nonatomic, strong) UICollectionView *collectionView;

@end

@implementation TSGoodDetailImageCell

-(void)fillCustomContentView{
    self.contentView.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:self.bgView];
    [self.bgView addSubview:self.titleLabel];
    [self.bgView addSubview:self.downloadBtn];
    [self.bgView addSubview:self.downloadImageBtn];
    [self.bgView addSubview:self.collectionView];

    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(15);
        make.top.equalTo(self.bgView).offset(14);
        make.height.mas_equalTo(20);
    }];
    
    [self.downloadBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView.mas_right).offset(-19);
        make.centerY.equalTo(self.titleLabel);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(100);
    }];
    
    [self.downloadImageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView.mas_right).offset(-15);
        make.bottom.equalTo(self.bgView.mas_bottom).offset(-16);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(70);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView).offset(16);
        make.right.equalTo(self.bgView);
        make.top.equalTo(self.bgView).offset(48);
        make.bottom.equalTo(self.bgView).offset(-51);
    }];
}

#pragma mark - Actions
-(void)downloadAction:(TSTextImageButton *)sender{
    
}

-(void)downloadImageAction:(UIButton *)sender{
    
}

#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TSMaterialImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TSMaterialImageCell" forIndexPath:indexPath];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(90, 90);
}

#pragma mark - Getter
-(UIView *)bgView{
    if (!_bgView) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = UIColor.whiteColor;
        [_bgView setCorners:UIRectCornerAllCorners radius:9];
    }
    return _bgView;
}

-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = KFont(PingFangSCMedium, 14);
        _titleLabel.textColor = KHexColor(@"#1E1C27");
        _titleLabel.text = @"商品图片";
    }
    return _titleLabel;
}

-(TSTextImageButton *)downloadBtn{
    if (!_downloadBtn) {
        _downloadBtn = [TSTextImageButton buttonWithType:UIButtonTypeCustom];
        _downloadBtn.titleLabel.font = KRegularFont(14);
        [_downloadBtn setTitleColor:KHexColor(@"#747474") forState:UIControlStateNormal];
        [_downloadBtn setTitleColor:KHexColor(@"#747474") forState:UIControlStateHighlighted];
        [_downloadBtn setTitle:@"下载更多素材" forState:UIControlStateNormal];
        [_downloadBtn addTarget:self action:@selector(downloadAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _downloadBtn;
}

-(UIButton *)downloadImageBtn{
    if (!_downloadImageBtn) {
        _downloadImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _downloadImageBtn.titleLabel.font = KRegularFont(14);
        [_downloadImageBtn setTitleColor:KWhiteColor forState:UIControlStateNormal];
        [_downloadImageBtn setTitleColor:KWhiteColor forState:UIControlStateHighlighted];
        [_downloadImageBtn setTitle:@"下载图片" forState:UIControlStateNormal];
        [_downloadImageBtn setBackgroundColor:[UIColor orangeColor]];
        [_downloadImageBtn addTarget:self action:@selector(downloadImageAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _downloadImageBtn;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[TSMaterialImageCell class] forCellWithReuseIdentifier:@"TSMaterialImageCell"];
        _collectionView.showsHorizontalScrollIndicator = NO;
    }
    return _collectionView;
}

@end

