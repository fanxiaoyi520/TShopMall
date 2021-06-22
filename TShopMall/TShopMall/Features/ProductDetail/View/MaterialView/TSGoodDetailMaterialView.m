//
//  TSGoodDetailMaterialView.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/21.
//

#import "TSGoodDetailMaterialView.h"

@interface TSGoodDetailMaterialView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

/// 素材
@property(nonatomic, strong) UILabel *numLabel;
/// 中间CollectionView
@property (nonatomic, strong) UICollectionView *collectionView;
/// 全选
@property (nonatomic, strong) UIButton *selectedButton;
/// 下载
@property (nonatomic, strong) UIButton *downloadButton;

@end

@implementation TSGoodDetailMaterialView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
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
        make.width.mas_equalTo(28);
        make.height.mas_equalTo(88);
    }];
    
    [self.selectedButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(18);
        make.centerY.equalTo(self.downloadButton);
        make.height.mas_equalTo(20);
        make.width.mas_equalTo(70);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.numLabel.mas_bottom).offset(13);
        make.bottom.equalTo(self.selectedButton.mas_top).offset(0);
    }];
}



@end
