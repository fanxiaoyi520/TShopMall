//
//  TSInviteFriendsPhotoCell.m
//  TShopMall
//
//  Created by 林伟 on 2021/7/1.
//

 

@interface TSInviteFriendsPhotoCellLayout : UICollectionViewFlowLayout
@property(nonatomic,assign) NSInteger selectedIndex;
@property(nonatomic,assign) float scale;
@property(nonatomic,strong) NSMutableArray *attrsArray;
@end

@implementation TSInviteFriendsPhotoCellLayout
- (void)prepareLayout {
    [super prepareLayout];
    [self.attrsArray removeAllObjects];
    
    NSInteger sectionCount = [self.collectionView numberOfSections];
    for (NSInteger sectionIndex = 0; sectionIndex < sectionCount; sectionIndex++) {
        NSInteger itemCountOfSection = [self.collectionView numberOfItemsInSection:sectionIndex];
        for (NSInteger itemIndex = 0; itemIndex < itemCountOfSection; itemIndex++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:itemIndex inSection:sectionIndex];
            UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
            [self.attrsArray addObject:attributes];
        }
        
    }
    
    
}

- (NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {

    return  self.attrsArray;
}

 

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    
    if (self.selectedIndex  == indexPath.row) {
        attributes.size =  CGSizeMake(self.itemSize.width*self.scale, self.itemSize.height*self.scale);
        CGRect frame = attributes.frame;
        frame.origin.x += self.itemSize.width*(self.scale - 1)/2 ;
        attributes.frame = frame;
    }
    if (indexPath.row > self.selectedIndex) {
        CGRect frame = attributes.frame;
        frame.origin.x += self.itemSize.width*(self.scale - 1);
        attributes.frame = frame;
    }
    attributes.center = CGPointMake(attributes.center.x, self.collectionView.height/2);
   
    return attributes;
}
//
-(NSMutableArray *)attrsArray{
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}
 
@end


#import "TSInviteFriendsPhotoCell.h"
@interface TSInviteFriendsPhotoItemCell : UICollectionViewCell
@property(nonatomic,strong) UIImageView *img;
@property(nonatomic,strong) UIView *backView;
@property(nonatomic,strong) UIImageView *icon;
@property(nonatomic,strong) UIImageView *codeImg;
@property(nonatomic,strong) UILabel *title;
@property(nonatomic,strong) UILabel *desL;
@property(nonatomic,strong) UILabel *inviteCode;
@property(nonatomic,strong) UILabel *tips;
@property(nonatomic,assign) float scale;
@end
@implementation TSInviteFriendsPhotoItemCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.img];
        [self.contentView addSubview:self.backView];
        [self.backView addSubview:self.title];
        [self.backView addSubview:self.desL];
        [self.backView addSubview:self.icon];
        [self.backView addSubview:self.codeImg];
        [self.backView addSubview:self.tips];
        [self.backView addSubview:self.inviteCode];
        
        [self.img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        [self.backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.contentView);
            make.height.mas_equalTo(90);
        }];
        
        [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.backView.mas_left).offset(16);
            make.top.equalTo(self.backView.mas_top).offset(10);
            make.size.mas_equalTo(CGSizeMake(40, 40));
        }];
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.icon.mas_left).offset(10);
            make.top.equalTo(self.backView.mas_top).offset(11);
        }];
        
        [self.desL mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.icon).offset(10);
            make.top.equalTo(self.title.mas_bottom).offset(5);
        }];
        [self.inviteCode mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.backView).offset(16);
            make.top.equalTo(self.icon.mas_bottom).offset(13);
        }];
        [self.codeImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.backView).offset(10);
            make.right.equalTo(self.backView.mas_right).offset(-16);
        }];
        [self.tips mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.codeImg.mas_bottom).offset(2);
            make.centerX.equalTo(self.codeImg);
        }];
    }
   
    return self;
}



- (void)setScale:(float)scale {
    _scale = scale;
    self.title.font = KRegularFont(16*self.scale);
    self.desL.font = KRegularFont(8*self.scale);
    self.inviteCode.font = KRegularFont(16*self.scale);
    self.tips.font = KRegularFont(6*self.scale);
    [self.backView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.height.mas_equalTo(90*self.scale);
    }];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView).offset(16*self.scale);
        make.top.equalTo(self.backView).offset(10*self.scale);
        make.size.mas_equalTo(CGSizeMake(40*self.scale, 40*self.scale));
    }];
    [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon).offset(10*self.scale);
        make.top.equalTo(self.backView).offset(11*self.scale);
    }];

    [self.desL mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.icon).offset(10*self.scale);
        make.top.equalTo(self.title.mas_bottom).offset(5*self.scale);
    }];
    [self.inviteCode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView).offset(16*self.scale);
        make.top.equalTo(self.icon.mas_bottom).offset(13*self.scale);
    }];
    [self.codeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.backView).offset(10*self.scale);
        make.right.equalTo(self.backView.mas_right).offset(-16*self.scale);
    }];
    [self.tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.codeImg.mas_bottom).offset(2*self.scale);
    }];

}
 
- (UIView *)backView {
    if (!_backView) {
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = UIColor.whiteColor;
    }
    return  _backView;
}

- (UIImageView *)img {
    if (!_img) {
        _img = [[UIImageView alloc] init];
        _img.contentMode = UIViewContentModeScaleAspectFill;
    }
    return  _img;
}

- (UIImageView *)icon {
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.contentMode = UIViewContentModeScaleAspectFill;
    }
    return  _icon;
}
- (UIImageView *)codeImg {
    if (!_codeImg) {
        _codeImg = [[UIImageView alloc] init];
        _codeImg.contentMode = UIViewContentModeScaleAspectFill;
    }
    return  _codeImg;
}

-(UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.font = KRegularFont(16);
        _title.textAlignment = NSTextAlignmentLeft;
        _title.textColor = KHexColor(@"#2D3132");
        _title.text = @"TCL之家";
    }
    return _title;
}

-(UILabel *)desL{
    if (!_desL) {
        _desL = [[UILabel alloc] init];
        _desL.font = KRegularFont(8);
        _desL.textAlignment = NSTextAlignmentLeft;
        _desL.textColor = KHexColor(@"#2D3132");
        _desL.alpha = 0.4;
        _desL.text = @"有品质  有保障  放心买";
    }
    return _desL;
}


-(UILabel *)inviteCode{
    if (!_inviteCode) {
        _inviteCode = [[UILabel alloc] init];
        _inviteCode.font = KRegularFont(16);
        _inviteCode.textAlignment = NSTextAlignmentLeft;
        _inviteCode.textColor = KHexColor(@"#2D3132");
        _inviteCode.text = @"邀请码：RWRTNA";
    }
    return _inviteCode;
}

-(UILabel *)tips{
    if (!_tips) {
        _tips = [[UILabel alloc] init];
        _tips.font = KRegularFont(6);
        _tips.textAlignment = NSTextAlignmentRight;
        _tips.textColor = KHexColor(@"#2D3132");
        _tips.alpha = 0.4;
        _tips.text = @"长按图片下载APP";
        
    }
    return _title;
}
@end
@interface TSInviteFriendsPhotoCell()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,strong) UICollectionView *collectionView;
@property(nonatomic,strong) UIImageView *backImg;
@property(nonatomic,assign) NSInteger selectedIndex;
@property(nonatomic,strong) UIVisualEffectView *effectview;
@property(nonatomic,strong) TSInviteFriendsPhotoCellLayout *flowLayout;
@property(nonatomic,assign) NSInteger count;
@end

@implementation TSInviteFriendsPhotoCell

-(void)fillCustomContentView {
    _count = 13;
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
 
- (void)setDelegate:(id<UniversalCollectionViewCellDataDelegate>)delegate {
    [super setDelegate:delegate];
    
}

#pragma mark - UICollectionViewDataSource

//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
//
//    if (<#condition#>) {
//        <#statements#>
//    }
//
//}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return  _count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TSInviteFriendsPhotoItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TSInviteFriendsPhotoItemCell" forIndexPath:indexPath];
    cell.img.image = KImageMake(@"邀请画面");
    cell.img.backgroundColor = [UIColor redColor];
    self.backImg.image = KImageMake(@"邀请画面");
    if (self.selectedIndex == indexPath.row) {
        cell.scale = 0.5;
    } else {
        cell.scale = 0.25;
    }
    return  cell;
}
 
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    _selectedIndex = indexPath.row;
    self.flowLayout.selectedIndex = indexPath.row;
    [collectionView reloadData];
    UICollectionViewLayoutAttributes *attri = [collectionView layoutAttributesForItemAtIndexPath:indexPath];
    CGPoint point = CGPointMake(attri.frame.origin.x - (collectionView.width - attri.size.width)/2, attri.frame.origin.y);
    [self.collectionView setContentOffset:CGPointMake(point.x, 0) animated:YES];
   
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
        _backImg.layer.masksToBounds = YES;
    }
    return  _backImg;
}
- (UICollectionView *)collectionView {
    if (!_collectionView) {
      
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                             collectionViewLayout:self.flowLayout];
        _collectionView.backgroundColor = UIColor.clearColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [_collectionView registerClass:TSInviteFriendsPhotoItemCell.class forCellWithReuseIdentifier:@"TSInviteFriendsPhotoItemCell"];
    }
    return _collectionView;
}
- (TSInviteFriendsPhotoCellLayout *)flowLayout {
    if (!_flowLayout) {
        _flowLayout = [[TSInviteFriendsPhotoCellLayout alloc]init];
        _flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _flowLayout.minimumInteritemSpacing = 22;
        _flowLayout.scale = 1.2;
        _flowLayout.itemSize = CGSizeMake(92, 200);
        _flowLayout.selectedIndex = 0;
    }
    return  _flowLayout;
}
@end
