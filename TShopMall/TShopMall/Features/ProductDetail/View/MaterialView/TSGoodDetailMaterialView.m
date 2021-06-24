//
//  TSGoodDetailMaterialView.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/21.
//

#import "TSGoodDetailMaterialView.h"

@interface TSDetailSelectButton : UIButton

@end

@implementation TSDetailSelectButton

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setupBasic];
    }
    return self;
}

-(void)setupBasic{
    self.backgroundColor = [UIColor whiteColor];
    self.titleLabel.font = KRegularFont(14);
    [self setTitleColor:KHexColor(@"#1E1C27") forState:UIControlStateNormal];
    [self setTitleColor:KHexColor(@"#1E1C27") forState:UIControlStateHighlighted];
    [self setTitle:@"全选" forState:UIControlStateNormal];
    [self setImage:KImageMake(@"mall_detail_normal") forState:UIControlStateNormal];
    [self setImage:KImageMake(@"mall_detail_selected") forState:UIControlStateSelected];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    CGFloat titleH = 20;
    CGFloat titleX = 33;
    CGFloat titleY = (contentRect.size.height - titleH) * 0.5;
    CGFloat titleW = contentRect.size.width - titleX;
    
    return CGRectMake(titleX, titleY, titleW, titleH);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGFloat imageW = 30;
    CGFloat imageH = 30;
    CGFloat imageX = 0;
    CGFloat imageY = 0;

    return CGRectMake(imageX, imageY, imageW, imageH);
}

-(void)setHighlighted:(BOOL)highlighted{}

@end

@interface TSGoodDetailMaterialView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/// 素材
@property(nonatomic, strong) UILabel *numLabel;
/// 中间CollectionView
@property (nonatomic, strong) UICollectionView *collectionView;
/// 全选
@property (nonatomic, strong) TSDetailSelectButton *selectedButton;
/// 下载
@property (nonatomic, strong) UIButton *downloadButton;

@end

@implementation TSGoodDetailMaterialView

-(instancetype)initWithMaterialModels:(NSArray <TSMaterialImageModel *> *)model{
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        self.models = model;
        [self setupViews];
    }
    return self;
}

-(void)setupViews{
    
    [self addSubview:self.numLabel];
    [self addSubview:self.collectionView];
    [self addSubview:self.selectedButton];
    [self addSubview:self.downloadButton];
    
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(15);
        make.top.equalTo(self).offset(13);
        make.height.mas_equalTo(20);
    }];
    
    [self.downloadButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-15);
        make.bottom.equalTo(self).offset(-31);
        make.height.mas_equalTo(28);
        make.width.mas_equalTo(88);
    }];
    
    [self.selectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(18);
        make.centerY.equalTo(self.downloadButton);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(70);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.numLabel.mas_bottom).offset(13);
        make.bottom.equalTo(self.selectedButton.mas_top).offset(-20);
    }];
}

-(void)reloadMaterialView{
    [self.collectionView reloadData];
}

#pragma mark - Actions
-(void)downloadAction:(UIButton *)sender{
    
}

-(void)selectedAction:(TSDetailSelectButton *)sender{
    sender.selected = !sender.selected;
    
    if (sender.selected) {
        for (TSMaterialImageModel *model in self.models) {
            model.selected = YES;
        }
    }else{
        for (TSMaterialImageModel *model in self.models) {
            model.selected = NO;
        }
    }
    
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDelegate & UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.models.count;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(90, 90);
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    TSMaterialImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TSMaterialImageCell" forIndexPath:indexPath];
    cell.model = self.models[indexPath.row];
    return cell;
}

#pragma mark - Getter
-(UILabel *)numLabel{
    if (!_numLabel) {
        _numLabel = [[UILabel alloc] init];
        _numLabel.textColor = KHexAlphaColor(@"#1E1C27", 1.0);
        _numLabel.font = KRegularFont(14);
        _numLabel.text = [NSString stringWithFormat:@"共%lu张素材",(unsigned long)self.models.count];
        _numLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _numLabel;
}

-(UIButton *)downloadButton{
    if (!_downloadButton) {
        _downloadButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_downloadButton setTitle:@"下载图片" forState:UIControlStateNormal];
        _downloadButton.titleLabel.font = KRegularFont(14);
        [_downloadButton setTitleColor:KWhiteColor forState:UIControlStateNormal];
        [_downloadButton setTitleColor:KWhiteColor forState:UIControlStateHighlighted];
        [_downloadButton setBackgroundColor:[UIColor redColor]];
        [_downloadButton addTarget:self action:@selector(downloadAction:) forControlEvents:UIControlEventTouchUpInside];
        [_downloadButton setCorners:UIRectCornerAllCorners radius:14];
    }
    return _downloadButton;
}

-(TSDetailSelectButton *)selectedButton{
    if (!_selectedButton) {
        _selectedButton = [TSDetailSelectButton buttonWithType:UIButtonTypeCustom];
        [_selectedButton addTarget:self action:@selector(selectedAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectedButton;
}

-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
        flow.scrollDirection = UICollectionViewScrollDirectionVertical;
        flow.sectionInset = UIEdgeInsetsMake(0, 16, 0, 16);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flow];
        _collectionView.backgroundColor = UIColor.whiteColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[TSMaterialImageCell class] forCellWithReuseIdentifier:@"TSMaterialImageCell"];
    }
    return _collectionView;
}

@end
