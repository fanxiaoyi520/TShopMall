//
//  SSCollectionViewLayout.m
//  SSBaseTemplate
//
//  Created by 陈结 on 2021/5/12.
//

#import "SSCollectionViewLayout.h"

@interface SSCollectionViewLayout()

@property(nonatomic, strong) NSMutableArray *headerInvalidateSections;

@end

@implementation SSCollectionViewLayout
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.headerInvalidateSections = [NSMutableArray array];
    }
    return self;
}

- (void)prepareLayout
{
    
}

#pragma mark - Setter and Getter
-(void)setSections:(NSMutableArray<SSLayoutBaseSection *> *)sections
{
    if (_sections == sections) {
        return;
    }
}

@end
