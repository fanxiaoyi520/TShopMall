//
//  TSProductCollectionViewCell.m
//  TSale
//
//  Created by Daisy  on 2020/12/11.
//  Copyright © 2020 TCL. All rights reserved.
//

#import "TSProductCollectionViewCell.h"

@interface TSProductCollectionViewCell()

@property (nonatomic, strong) UILabel *nameLable;

@end

@implementation TSProductCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initFrameUI];
    }
    return self;
}

-(void)initFrameUI{
    [self.contentView addSubview:self.nameLable];

    [_nameLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

#pragma mark - Setter and Getter
-(UILabel *)nameLable{
    if (!_nameLable) {
        _nameLable = [UILabel new];
        _nameLable.textAlignment  = NSTextAlignmentCenter;
        _nameLable.layer.cornerRadius = 2.0;
        _nameLable.layer.borderWidth  = 1;
        _nameLable.layer.masksToBounds   = YES;
        _nameLable.layer.borderColor = KClearColor.CGColor;
        _nameLable.backgroundColor = KHexAlphaColor(@"#ECECEC", 1.0);
        _nameLable.font = KRegularFont(12);
        _nameLable.textColor = KTextColor;
    }
    return _nameLable;
}

//-(void)setSonModel:(TSSpecificationItemModel *)sonModel{
//    _sonModel = sonModel;
//    self.nameLable.text = sonModel.productAttrValueText;
//    
//    if ([sonModel.checked boolValue]) {//被选中
//        self.nameLable.backgroundColor = [UIColor whiteColor];
//        self.nameLable.textColor = KMainColor;
//        self.nameLable.layer.borderColor = KMainColor.CGColor;
//        
//    } else {
//        
//        if (sonModel.canSelected) {
//            self.nameLable.backgroundColor = KHexAlphaColor(@"#ECECEC", 0.4);
//            self.nameLable.textColor = KTextColor;
//            self.nameLable.layer.borderColor = KClearColor.CGColor;
//        } else {
//            self.nameLable.backgroundColor = KHexAlphaColor(@"#ECECEC", 0.4);;
//            self.nameLable.textColor = KHexAlphaColor(@"#2D3132", 0.2);
//            self.nameLable.layer.borderColor = KClearColor.CGColor;
//        }
//    }
//}

@end
