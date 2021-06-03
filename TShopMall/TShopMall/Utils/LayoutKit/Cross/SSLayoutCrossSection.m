//
//  SSLayoutCrossSection.m
//  SSBaseTemplate
//
//  Created by 陈结 on 2021/5/17.
//

#import "SSLayoutCrossSection.h"
#import "SSLayoutCrossCell.h"
#import "SSLayoutElement.h"
#import "SSCollectionViewLayoutAttributes.h"

@interface SSLayoutCrossSection()<UICollectionViewDelegate>

/// 固定分组
@property(nonatomic, strong) SSLayoutElement *cellElement;

@end

@implementation SSLayoutCrossSection

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cellElement = [SSLayoutElement elementWithClass:[SSLayoutCrossCell class]];
        self.canReuseCell = NO;
        self.sections = [NSMutableArray array];
        
        [self setConfigureCellData:^(SSLayoutBaseSection * _Nonnull section, UICollectionViewCell * _Nonnull cell, NSInteger item) {
            SSLayoutCrossCell *crossCell = (SSLayoutCrossCell *)cell;
            crossCell.crossSection = (SSLayoutCrossSection *)section;
        }];
    }
    return self;
}

+(instancetype)sectionAutoWithSection:(SSLayoutBaseSection *)section
{
    SSLayoutCrossSection *crossSection = [[self alloc] init];
    crossSection.autoMaxSiza = YES;
    crossSection.sections = [@[section] mutableCopy];
    return crossSection;
}

-(CGFloat)maxContentWidth
{
    if ((self.sections == nil) || (self.sections.count == 0)) {
        return 0;
    }
    
    SSLayoutBaseSection *lastSection = [self.sections lastObject];
    return lastSection.sectionOffset + lastSection.sectionSize;
}

#pragma mark - Setter & Getter
-(void)setCanReuseCell:(BOOL)canReuseCell
{
    if (canReuseCell) {
        self.cellElement.reuseIdentifier = NSStringFromClass(self.cellElement.viewClass);
    } else {
        self.cellElement.reuseIdentifier = [NSString stringWithFormat:@"%@%@", self, NSStringFromClass(self.cellElement.viewClass)];
    }
}

-(SSLayoutDirection)crossDirection
{
    if (self.direction == SSLayoutDirectionVertical) {
        return SSLayoutDirectionHorizontal;
    }else{
        return SSLayoutDirectionVertical;
    }
}

@end
