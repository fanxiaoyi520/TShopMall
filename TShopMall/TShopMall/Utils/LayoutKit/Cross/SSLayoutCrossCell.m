//
//  SSLayoutCrossCell.m
//  SSBaseTemplate
//
//  Created by 陈结 on 2021/5/17.
//

#import "SSLayoutCrossCell.h"
#import "SSCollectionView.h"
#import "SSLayoutCrossSection.h"

@interface SSLayoutCrossCell()

@property(nonatomic, strong) SSCollectionView *collectionView;

@end

@implementation SSLayoutCrossCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self fillCustomView];
    }
    return self;
}

-(void)fillCustomView
{
    [self.contentView addSubview:self.collectionView];
}

#pragma mark - Getter & Setter
-(void)setCrossSection:(SSLayoutCrossSection *)crossSection
{
    _crossSection = crossSection;

}

-(SSCollectionView *)collectionView
{
    if (!_collectionView) {
        _collectionView = [[SSCollectionView alloc] init];
        _collectionView.backgroundColor = [UIColor whiteColor];
    }
    return _collectionView;
}

@end
