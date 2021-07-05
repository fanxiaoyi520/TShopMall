//
//  TSUnbundlingCardViewCell.m
//  TShopMall
//
//  Created by xiaoyi.fan on 2021/7/5.
//

#import "TSUnbundlingCardViewCell.h"

@implementation TSUnbundlingCardViewCell {
    UIImageView * _bankImageCion;
    UILabel * _bankNameLabel;
    UILabel * _accountLabel;
    UIImageView * _masterLabelBackImageView;
    UILabel * _masterLabel;
    UIImageView * _bgImageView;
    UIImageView * _yinyingImageView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self=[super initWithFrame:frame];
    if (self) {
        [self uiConfigue];
    }
    return self;
}

- (void)uiConfigue {
    _yinyingImageView = [UIImageView new];
    _yinyingImageView.image = KImageMake(@"mine_yinying");
    _yinyingImageView.frame = CGRectMake(0, -(_yinyingImageView.image.size.height/2), self.width, _yinyingImageView.image.size.height);
    [self.contentView addSubview:_yinyingImageView];
    _yinyingImageView.hidden = YES;

    _bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    _bgImageView.image=[UIImage imageNamed:@"mine_red_bg"];
     [self.contentView addSubview:_bgImageView];
    
    _bankImageCion = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 40, 40)];
    _bankImageCion.backgroundColor=[UIColor colorWithRed: arc4random_uniform(256)/255.0f green: arc4random_uniform(256)/255.0f blue: arc4random_uniform(256)/255.0f alpha:1];
    _bankImageCion.image=[UIImage imageNamed:@""];
    _bankImageCion.layer.cornerRadius=_bankImageCion.width/2;
    _bankImageCion.layer.masksToBounds=YES;
    [_bgImageView addSubview:_bankImageCion];
    
    _bankNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_bankImageCion.right+15, 18, 200, 40)];
    _bankNameLabel.font=KRegularFont(16);
    _bankNameLabel.textColor=[UIColor whiteColor];
    [_bgImageView addSubview:_bankNameLabel];
    
    
    _accountLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.width - 200 - 10, 18, 200, 30)];
    _accountLabel.font=KRegularFont(16);
    _accountLabel.textColor=KWhiteColor;
    _accountLabel.textAlignment = NSTextAlignmentRight;
    [_bgImageView addSubview:_accountLabel];
}

// MARK: model
- (void)setModel:(id _Nullable)model indexPath:(NSIndexPath *)indexPath {
    if (!model) return;
    
    if (self.sourceInt != 5 && indexPath.row != 0)
        _yinyingImageView.hidden = NO;

    TSBankCardModel *kModel = model;
    _bankNameLabel.text = kModel.accountBank;

    NSString *endStr = nil;
    if (kModel.bankCardNo.length >= 16) {
        endStr = [kModel.bankCardNo substringFromIndex:kModel.bankCardNo.length-4];
        _accountLabel.text = [NSString stringWithFormat:@"····%@",endStr];
    } else {
        _accountLabel.text = kModel.bankCardNo;
    }
    
    if (self.height == 120) {
        _accountLabel.top = 87;
        
        if ([kModel.bankStatus isEqualToString:@"0"]) {//待审核
            _bgImageView.image=[UIImage imageNamed:@"mine_shenhezhong_da"];
            _accountLabel.text = kModel.bankStatusName;
        } else if ([kModel.bankStatus isEqualToString:@"1"]) {//审核通过
            if (indexPath.item % 2 == 0) {
                _bgImageView.image=[UIImage imageNamed:@"mine_bankstatus_hong"];
            } else {
                _bgImageView.image=[UIImage imageNamed:@"mine_yellow_bg1"];
            }
        }
    } else {
        if ([kModel.bankStatus isEqualToString:@"0"]) {//待审核
            _bgImageView.image=[UIImage imageNamed:@"mine_grey_bg"];
            _accountLabel.text = kModel.bankStatusName;
        } else if ([kModel.bankStatus isEqualToString:@"1"]) {//审核通过
            if (indexPath.item % 2 == 0) {
                _bgImageView.image=[UIImage imageNamed:@"mine_red_bg"];
            } else {
                _bgImageView.image=[UIImage imageNamed:@"mine_yellow_bg2"];
            }
        }
    }
}
@end
