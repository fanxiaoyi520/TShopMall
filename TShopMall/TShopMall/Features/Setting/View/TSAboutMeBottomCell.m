//
//  TSAboutMeBottomCell.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/13.
//

#import "TSAboutMeBottomCell.h"

@interface TSAboutMeBottomCell ()
/** 设备号 */
@property(nonatomic, weak) UILabel *equipmentNumberLabel;
/** 版权 */
@property(nonatomic, weak) UILabel *copyrightLabel;


@end

@implementation TSAboutMeBottomCell

- (void)fillCustomContentView {
    [super fillCustomContentView];
    ///添加约束
    [self addConstraints];
}

- (void)addConstraints {
    [self.copyrightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-16);
        make.centerX.equalTo(self.contentView.mas_centerX).with.offset(0);
    }];
    [self.equipmentNumberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.copyrightLabel.mas_top).with.offset(0);
        make.centerX.equalTo(self.contentView.mas_centerX).with.offset(0);
    }];
}

- (UILabel *)equipmentNumberLabel {
    if (_equipmentNumberLabel == nil) {
        UILabel *equipmentNumberLabel = [[UILabel alloc] init];
        _equipmentNumberLabel = equipmentNumberLabel;
        _equipmentNumberLabel.text = @"粤ICP备05040863号";
        _equipmentNumberLabel.textColor = KHexAlphaColor(@"#2D3132", 0.4);
        _equipmentNumberLabel.font = KRegularFont(12);
        [self.contentView addSubview:_equipmentNumberLabel];
    }
    return _equipmentNumberLabel;
}

- (UILabel *)copyrightLabel {
    if (_copyrightLabel == nil) {
        UILabel *copyrightLabel = [[UILabel alloc] init];
        _copyrightLabel = copyrightLabel;
        _copyrightLabel.text = @"TCL集团 版权所有";
        _copyrightLabel.textColor = KHexAlphaColor(@"#2D3132", 0.4);
        _copyrightLabel.font = KRegularFont(12);
        [self.contentView addSubview:_copyrightLabel];
    }
    return _copyrightLabel;
}

@end
