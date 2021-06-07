//
//  SSLayoutBackground.m
//  SSBaseTemplate
//
//  Created by 陈结 on 2021/5/12.
//

#import "SSLayoutBackground.h"

NSString * _Nullable const UICollectionElementKindSectionBackground = @"UICollectionElementKindSectionBackground";

@implementation SSLayoutBackground

+(instancetype)backgroundWithViewClass:(Class)viewClass
{
    SSLayoutBackground *background = [super elementWithClass:viewClass];
    background.zIndex = SSLayoutZIndexBackground;
    return background;
}

- (NSString *)elementKind
{
    return UICollectionElementKindSectionBackground;
}

@end
