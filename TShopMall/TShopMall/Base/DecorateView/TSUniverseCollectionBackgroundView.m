//
//  TSUniverseCollectionBackgroundView.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/8.
//

#import "TSUniverseCollectionBackgroundView.h"

@implementation TSUniverseCollectionBackgroundView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.layer.cornerRadius = 8;
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

@end
