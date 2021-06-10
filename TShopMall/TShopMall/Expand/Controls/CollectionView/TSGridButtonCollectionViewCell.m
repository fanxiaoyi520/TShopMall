//
//  TSGridButtonCollectionViewCell.m
//  TSPaaS
//
//  Created by sway on 2020/9/16.
//

#import "TSGridButtonCollectionViewCell.h"
#import <Masonry/Masonry.h>

@implementation TSGridButtonCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
       self.layer.cornerRadius = 5;
       self.layer.masksToBounds = YES;
        
        [self addSubview: self.title];
        [_title mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self).with.offset(1).priorityHigh();
//            make.bottom.equalTo(self).with.offset(-1).priorityHigh();
            make.center.equalTo(self);
//            make.left.equalTo(self).with.offset(5).priorityHigh();
//            make.right.equalTo(self).with.offset(-5).priorityHigh();

        }];
    }
    return self;
}


- (UILabel *)title{
    if (!_title) {
        _title = [[UILabel alloc] init];
        _title.textAlignment = NSTextAlignmentCenter;
        _title.textColor = [UIColor grayColor];
        _title.font = [UIFont systemFontOfSize:16];
        _title.numberOfLines = 0;
        _title.lineBreakMode = NSLineBreakByWordWrapping;
    }
 
    return _title;
}
@end

@implementation TSGridButtonItem


@end
