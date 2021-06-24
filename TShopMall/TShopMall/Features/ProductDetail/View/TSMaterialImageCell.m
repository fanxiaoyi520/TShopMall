//
//  TSMaterialImageCell.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/16.
//

#import "TSMaterialImageCell.h"

@interface TSMaterialImageCell()

@property(nonatomic, strong) UIImageView *imgView;
@property(nonatomic, strong) UIButton *flagButton;

@end

@implementation TSMaterialImageCell

-(void)fillCustomContentView{
    [self.contentView addSubview:self.imgView];
    [self.imgView addSubview:self.flagButton];
    
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [self.flagButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.imgView.mas_right).offset(0);
        make.top.equalTo(self.imgView).offset(0);
        make.width.height.equalTo(@(35));
    }];
}

#pragma mark - Actions
-(void)selectAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    self.model.selected = sender.selected;
}

#pragma mark - Getter
-(UIImageView *)imgView{
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.layer.cornerRadius = 9;
        _imgView.clipsToBounds = YES;
        _imgView.userInteractionEnabled = YES;
        _imgView.backgroundColor = KHexColor(@"#F5EDED");
    }
    return _imgView;
}

-(UIButton *)flagButton{
    if (!_flagButton) {
        _flagButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_flagButton setImage:KImageMake(@"mall_detail_normal") forState:UIControlStateNormal];
        [_flagButton setImage:KImageMake(@"mall_detail_selected") forState:UIControlStateSelected];
        [_flagButton addTarget:self action:@selector(selectAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _flagButton;
}

-(void)setModel:(TSMaterialImageModel *)model{
    _model = model;
    
    __weak __typeof(self)weakSelf = self;
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.url] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        strongSelf.model.materialImage = image;
    }];
    
    self.flagButton.selected = model.selected;
}


@end

@implementation TSMaterialImageModel

@end
