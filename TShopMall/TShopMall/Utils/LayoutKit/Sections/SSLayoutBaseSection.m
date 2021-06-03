//
//  SSLayoutBaseSection.m
//  SSBaseTemplate
//
//  Created by 陈结 on 2021/5/13.
//

#import "SSLayoutBaseSection.h"
#import "SSLayoutHeader.h"
#import "SSLayoutFooter.h"
#import "SSLayoutBackground.h"
#import "SSCollectionViewLayoutAttributes.h"
#import "SSKVOArrayObject.h"

@interface SSLayoutBaseSection()

@property(nonatomic, strong) SSKVOArrayObject *kvoArray;

@end

@implementation SSLayoutBaseSection

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.kvoArray = [[SSKVOArrayObject alloc] init];
        NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
        [self.kvoArray addObserver:self forKeyPath:@"targetArray" options:options context:nil];
    }
    return self;
}

+(instancetype)sectionWithSectionInset:(UIEdgeInsets)inset
                             itemSpace:(CGFloat)itemSpace
                             lineSpace:(CGFloat)lineSpace
                                column:(NSInteger)column
{
    SSLayoutBaseSection *baseSection = [[self alloc] init];
    baseSection.sectionInset = inset;
    baseSection.itemSpace = itemSpace;
    baseSection.lineSpace = lineSpace;
    baseSection.column = column;
    [baseSection resetcolumnSizes];
    return baseSection;
}

#pragma mark - Observer
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([@"targetArray" isEqualToString:keyPath]) {
        NSIndexSet *set = change[@"indexes"];
        self.handleItemStart = set.firstIndex;
        self.hasHandle = NO;
    }
}

#pragma mark - Setter and Getter
-(void)setHeader:(SSLayoutHeader *)header
{
    _header = header;
    self.hasHandle = NO;
}

-(void)setFooter:(SSLayoutHeader *)footer
{
    _footer = footer;
    self.hasHandle = NO;
}

-(void)setBackground:(SSLayoutBackground *)background
{
    _background = background;
    self.hasHandle = NO;
}

-(void)setLineSpace:(CGFloat)lineSpace
{
    _lineSpace = lineSpace;
    self.hasHandle = NO;
}

-(void)setItemSpace:(CGFloat)itemSpace
{
    _itemCount = itemSpace;
    self.hasHandle = NO;
}

-(void)setColumn:(NSInteger)column
{
    _column = column;
    self.hasHandle = NO;
}

-(void)setDirection:(SSLayoutDirection)direction
{
    if (_direction == direction) {
        return;
    }
    _direction = direction;
    self.hasHandle = NO;
}

-(void)setHandleItemStart:(NSInteger)handleItemStart
{
    if (handleItemStart < _handleItemStart) {
        _handleItemStart = handleItemStart;
        self.handleType = SSLayoutHandleTypeReLayout;
    }
    
    if ((self.handleType == SSLayoutHandleTypeReLayout) && (_handleItemStart == self.itemsAttributes.count)) {
        self.handleType = SSLayoutHandleTypeAppend;
    }
}

-(void)setConfigureHeaderData:(void (^)(SSLayoutBaseSection * _Nonnull, UICollectionReusableView * _Nonnull))configureHeaderData
{
    _configureHeaderData = configureHeaderData;

}

-(void)setConfigureFooterData:(void (^)(SSLayoutBaseSection * _Nonnull, UICollectionReusableView * _Nonnull))configureFooterData{
    _configureFooterData = configureFooterData;

}

-(void)setItemDatas:(NSMutableArray *)itemDatas
{
    if (self.kvoArray.targetArray == itemDatas) {
        return;
    }
    self.hasHandle = NO;
    self.handleType = SSLayoutHandleTypeReLayout;
    
    if (self.kvoArray.targetArray) {
        [self.kvoArray removeObserver:self forKeyPath:@"targetArray" context:nil];
    }
    
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    
    if (![itemDatas isKindOfClass:[NSMutableArray class]]) {
        self.kvoArray.targetArray = [itemDatas mutableCopy];
        [self.kvoArray addObserver:self forKeyPath:@"targetArray" options:options context:nil];
    }else{
        self.kvoArray.targetArray = itemDatas;
        [self.kvoArray addObserver:self forKeyPath:@"targetArray" options:options context:nil];
    }
}

-(NSMutableArray *)itemDatas
{
    return [self.kvoArray mutableArrayValueForKey:@"targetArray"];
}

-(NSInteger)itemCount
{
    return self.itemDatas.count;
}

-(CGFloat)firstItemStartX
{
    if (self.direction == SSLayoutDirectionVertical) {
        return 0;
    } else {
        return self.sectionInset.top;
    }
}

-(void)dealloc
{
    [self.kvoArray removeObserver:self forKeyPath:@"targetArray"];
}

@end
