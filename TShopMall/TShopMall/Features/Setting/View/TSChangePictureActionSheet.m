//
//  TSChangePictionActionSheet.m
//  TShopMall
//
//  Created by 谭朝辉 on 2021/6/17.
//

#import "TSChangePictureActionSheet.h"
#import "TSUniversalFlowLayout.h"
#import "TSUniversalCollectionViewCell.h"

@implementation TSChangePictureActionSheetSectionModel

@end

@implementation TSChangePictureActionSheetItemModel

@end

@interface TSActionSheetDataController ()
/** item */
@property (nonatomic, strong) NSMutableArray<TSChangePictureActionSheetSectionModel *> *sections;

@end

@implementation TSActionSheetDataController

- (void)fetchContentsWithTitle:(NSArray *)titles Complete:(void (^)(BOOL))complete {
    NSMutableArray *sections = [NSMutableArray array];
    {
        NSMutableArray *items = [NSMutableArray array];
        //NSArray *titles = @[@"拍照", @"从相册中选择", @"系统默认头像"];
        for (int i = 0; i < titles.count; i++) {
            NSString *title = titles[i];
            TSChangePictureActionSheetItemModel *item = [[TSChangePictureActionSheetItemModel alloc] init];
            item.title = title;
            item.cellHeight = 56;
            item.identify = @"TSChangePictureActionSheetCell";
            [items addObject:item];
        }
        TSChangePictureActionSheetSectionModel *section = [[TSChangePictureActionSheetSectionModel alloc] init];
        section.column = 1;
        section.items = items;
        [sections addObject:section];
    }
    {
        NSMutableArray *items = [NSMutableArray array];
        TSChangePictureActionSheetItemModel *item = [[TSChangePictureActionSheetItemModel alloc] init];
        item.title = @"取消";
        item.cellHeight = 56;
        item.identify = @"TSChangePictureActionSheetCell";
        [items addObject:item];
        TSChangePictureActionSheetSectionModel *section = [[TSChangePictureActionSheetSectionModel alloc] init];
        section.column = 1;
        section.spacingWithLastSection = 10;
        section.items = items;
        [sections addObject:section];
    }
    self.sections = sections;
    if (complete) {
        complete(YES);
    }
}

@end

@interface TSChangePictureActionSheetCell ()
/** 标题 */
@property(nonatomic, weak) UILabel *titleLabel;

@end

@implementation TSChangePictureActionSheetCell

- (void)fillCustomContentView {
    [super fillCustomContentView];
    self.contentView.backgroundColor = KWhiteColor;
    ///添加约束
    [self addConstraints];
}

- (void)addConstraints {
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView.mas_centerY).with.offset(0);
        make.centerX.equalTo(self.contentView.mas_centerX).with.offset(0);
        make.width.mas_lessThanOrEqualTo(150);
    }];
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        _titleLabel = titleLabel;
        _titleLabel.textColor = KHexColor(@"#333333");
        _titleLabel.font = KRegularFont(16);
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (void)setDelegate:(id<UniversalCollectionViewCellDataDelegate>)delegate {
    TSChangePictureActionSheetItemModel *item = [delegate universalCollectionViewCellModel:self.indexPath];
    self.titleLabel.text = item.title;
}

@end

@interface TSChangePictureActionSheet ()<UICollectionViewDelegate, UICollectionViewDataSource, UniversalFlowLayoutDelegate, UniversalCollectionViewCellDataDelegate>

@property (nonatomic, copy) void(^actionHandler)(NSInteger index, NSString *title);
/** data */
@property (nonatomic, strong) TSActionSheetDataController *dataController;
/// CollectionView
@property(nonatomic, weak) UICollectionView *collectionView;
/** titles */
@property(nonatomic, copy) NSArray *titles;
/** 内容父视图 */
@property(nonatomic, weak) UIView *contentView;

@end

@implementation TSChangePictureActionSheet

- (instancetype)initWithTitles:(NSArray *)titles actionHandler:(void(^)(NSInteger index, NSString *title))actionHandler {
    if (self = [super init]) {
        _titles = titles;
        _actionHandler = actionHandler;
        self.frame = [[UIScreen mainScreen] bounds];
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        self.contentView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, (self.titles.count + 1) * 56 + 10);
//        CAShapeLayer *maskLayer = [CAShapeLayer layer];
//        maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.contentView.frame byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:(CGSize){5.0f}].CGPath;
//        maskLayer.frame = self.contentView.frame;
//        self.contentView.layer.masksToBounds = YES;
//        self.contentView.layer.mask = maskLayer;
        [self addConstraints];
        __weak __typeof(self)weakSelf = self;
        [self.dataController fetchContentsWithTitle:titles Complete:^(BOOL isSucess) {
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            if (isSucess) {
                [strongSelf.collectionView reloadData];
            }
        }];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:self.contentView];
    if (CGRectContainsPoint(self.contentView.frame, point)) {
        return;
    }
    [self dismiss];
}

- (void)addConstraints {
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.right.equalTo(self.contentView.mas_right).offset(0);
        make.top.equalTo(self.contentView.mas_top).offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
    }];
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:.5 animations:^{
        CGRect rect = self.contentView.frame;
        rect.origin.y = kScreenHeight - self.contentView.frame.size.height;
        self.contentView.frame = rect;
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:.5 animations:^{
        CGRect rect = self.contentView.frame;
        rect.origin.y += self.contentView.bounds.size.height;
        self.contentView.frame = rect;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        TSUniversalFlowLayout *flowLayout = [[TSUniversalFlowLayout alloc]init];
        flowLayout.delegate = self;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                             collectionViewLayout:flowLayout];
        _collectionView = collectionView;
        _collectionView.backgroundColor = KHexColor(@"#F4F4F5");
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.scrollEnabled = NO;
        [self.contentView addSubview:_collectionView];
    }
    return _collectionView;
}

- (UIView *)contentView {
    if (_contentView == nil) {
        UIView *contentView = [[UIView alloc] init];
        _contentView = contentView;
        [self addSubview:_contentView];
    }
    return _contentView;
}

+ (instancetype)actionSheetWithTitles:(NSArray *)titles actionHandler:(void(^)(NSInteger index, NSString *title))actionHandler {
    
    return [[self alloc] initWithTitles:titles actionHandler:actionHandler];
}

- (TSActionSheetDataController *)dataController {
    if (_dataController == nil) {
        _dataController = [[TSActionSheetDataController alloc] init];
    }
    return _dataController;
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataController.sections.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    TSChangePictureActionSheetSectionModel *model = self.dataController.sections[section];
    return model.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TSChangePictureActionSheetSectionModel *model = self.dataController.sections[indexPath.section];
    TSChangePictureActionSheetItemModel *item = model.items[indexPath.row];
    Class className = NSClassFromString(item.identify);
    [collectionView registerClass:[className class] forCellWithReuseIdentifier:item.identify];
    TSUniversalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:item.identify forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.delegate = self;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section >= 1) {
        [self dismiss];
        return;
    }
    TSChangePictureActionSheetSectionModel *model = self.dataController.sections[indexPath.section];
    TSChangePictureActionSheetItemModel *item = model.items[indexPath.row];
    if (self.actionHandler) {
        self.actionHandler(indexPath.item, item.title);
        [self dismiss];
    }
}

#pragma mark - UniversalCollectionViewCellDataDelegate
- (id)universalCollectionViewCellModel:(NSIndexPath *)indexPath{
    TSChangePictureActionSheetSectionModel *sectionModel = self.dataController.sections[indexPath.section];
    return sectionModel.items[indexPath.row];
}

#pragma mark - UniversalFlowLayoutDelegate
- (CGFloat)collectionView:(UICollectionView *_Nullable)collectionView
                   layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
  heightForRowAtIndexPath:(NSIndexPath *_Nullable)indexPath
                itemWidth:(CGFloat)itemWidth{
    TSChangePictureActionSheetSectionModel *model = self.dataController.sections[indexPath.section];
    TSChangePictureActionSheetItemModel *item = model.items[indexPath.row];
    return item.cellHeight;
}

- (NSInteger)collectionView:(UICollectionView *_Nullable)collectionView
                     layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
      columnNumberAtSection:(NSInteger )section{
    TSChangePictureActionSheetSectionModel *model = self.dataController.sections[section];
    return model.column;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(TSUniversalFlowLayout *)collectionViewLayout spacingWithLastSectionForSectionAtIndex:(NSInteger)section {
    TSChangePictureActionSheetSectionModel *model = self.dataController.sections[section];
    return model.spacingWithLastSection;
}

@end
