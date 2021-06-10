//
//  TSCategoryHeaderReusableView.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/10.
//

#import "TSCategoryHeaderReusableView.h"
#import "TSCategorySectionModel.h"

@interface TSCategoryHeaderReusableView ()

/// 标题
@property(nonatomic, strong) UILabel *titleLabel;

@end

@implementation TSCategoryHeaderReusableView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self fillCustomView];
    }
    return self;
}

-(void)fillCustomView{
    [self addSubview:self.titleLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(16);
        make.centerY.equalTo(self);
    }];
}

-(void)bindCategorySectionModel:(TSCategorySectionModel *)model{
    self.titleLabel.text = model.headerName;
}

#pragma mark - Getter
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = KFont(PingFangSCMedium, 14);
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = KTextColor;
    }
    return _titleLabel;
}

@end
