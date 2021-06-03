//
//  SSLayoutElement.m
//  SSBaseTemplate
//
//  Created by 陈结 on 2021/5/12.
//

#import "SSLayoutElement.h"

@interface SSLayoutElement()

@end

@implementation SSLayoutElement

-(id)copyWithZone:(NSZone *)zone
{
    SSLayoutElement *element = [[[self class] allocWithZone:zone] init];
    element.reuseIdentifier = self.reuseIdentifier;
    element.viewClass = self.viewClass;
    return element;
}

+(instancetype)elementWithClass:(Class)viewClass
{
    return [self elementWithClass:viewClass reuseIdentifier:NSStringFromClass(viewClass)];
}

+(instancetype)elementWithClass:(Class)viewClass reuseIdentifier:(NSString *)reuseIdentifier
{
    SSLayoutElement *element = [[SSLayoutElement alloc] init];
    element.viewClass = viewClass;
    element.reuseIdentifier = reuseIdentifier;
    return element;
}

-(void)registerElementWithCollectionView:(UICollectionView *)collectionView
{
    [collectionView registerClass:self.viewClass forCellWithReuseIdentifier:self.reuseIdentifier];
}

@end
