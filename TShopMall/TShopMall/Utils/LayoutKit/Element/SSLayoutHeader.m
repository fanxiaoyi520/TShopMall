//
//  SSLayoutHeader.m
//  SSBaseTemplate
//
//  Created by 陈结 on 2021/5/12.
//

#import "SSLayoutHeader.h"

@implementation SSLayoutHeader

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.maxSize = CGFLOAT_MAX;
    }
    return self;
}

+(instancetype)elementWithElementSize:(CGFloat)elementSize
                            viewClass:(Class)viewClass
                      reuseIdentifier:(NSString *)reuseIdentifier
{
    SSLayoutHeader *header = [super elementWithElementSize:elementSize viewClass:viewClass reuseIdentifier:reuseIdentifier];
    return header;
}

- (NSString *)elementKind
{
    return UICollectionElementKindSectionHeader;
}

@end
