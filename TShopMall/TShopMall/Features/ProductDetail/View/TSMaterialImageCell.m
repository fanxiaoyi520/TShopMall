//
//  TSMaterialImageCell.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/16.
//

#import "TSMaterialImageCell.h"

@interface TSMaterialImageCell()

@property(nonatomic, strong) UIImageView *imgView;

@end

@implementation TSMaterialImageCell

-(void)fillCustomContentView{
    [self.contentView addSubview:self.imgView];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

#pragma mark - Getter
-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.layer.cornerRadius = 9;
        _imgView.clipsToBounds = YES;
        _imgView.backgroundColor = [UIColor orangeColor];
    }
    return _imgView;
}

@end
