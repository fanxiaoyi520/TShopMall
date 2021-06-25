//
//  TSAgreementView.m
//  TShopMall
//
//  Created by edy on 2021/6/25.
//

#import "TSAgreementView.h"
#import "TSUniversalFlowLayout.h"

@implementation TSAgreementSectionModel

@end

@implementation TSAgreementSectionItemModel

@end

@interface TSAgreementDataController ()
/** sections  */
@property(nonatomic, strong) NSMutableArray<TSAgreementSectionModel *> *sections;

@end

@implementation TSAgreementDataController

- (void)fetchAgreementContentsComplete:(void(^)(BOOL isSucess))complete {
    NSMutableArray *sections = [NSMutableArray array];
    {
        NSMutableArray *items = [NSMutableArray array];
        TSAgreementSectionItemModel *item = [[TSAgreementSectionItemModel alloc] init];
        item.content = @"协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容\n协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容\n协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容\n协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容\n协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容\n协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容\n协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容\n协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容协议内容end";
        item.cellHeight = [item.content heightForFont:KRegularFont(12) width:(kScreenWidth - KRateW(36) * 2 - 48)];
        item.identify = @"TSAgreementCell";
        [items addObject:item];
        TSAgreementSectionModel *section = [[TSAgreementSectionModel alloc] init];
        section.column = 1;
        section.items = items;
        section.sectionInset = UIEdgeInsetsMake(0, 0, 0, 8);
        [sections addObject:section];
    }
    self.sections = sections;
    if (complete) {
        complete(YES);
    }
}

@end

@interface TSAgreementCell ()
/** 内容  */
@property(nonatomic, weak) UILabel *contentLabel;

@end

@implementation TSAgreementCell

- (void)fillCustomContentView {
    [super fillCustomContentView];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(0);
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        make.top.equalTo(self.contentView.mas_top).with.offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(0);
    }];
}

- (UILabel *)contentLabel {
    if (_contentLabel == nil) {
        UILabel *contentLabel = [[UILabel alloc] init];
        _contentLabel = contentLabel;
        _contentLabel.font = KRegularFont(12);
        _contentLabel.textColor = KTextColor;
        _contentLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _contentLabel.numberOfLines = 0;
        [self.contentView addSubview: _contentLabel];
    }
    return _contentLabel;
}

- (void)setDelegate:(id<UniversalCollectionViewCellDataDelegate>)delegate {
    TSAgreementSectionItemModel *item = [delegate universalCollectionViewCellModel:self.indexPath];
    self.contentLabel.text = item.content;
}

@end


@interface TSAgreementView ()<UICollectionViewDelegate, UICollectionViewDataSource, UniversalFlowLayoutDelegate, UniversalCollectionViewCellDataDelegate>
/** 背景视图 */
@property(nonatomic, weak) UIView *contentView;
/// CollectionView
@property(nonatomic, weak) UICollectionView *collectionView;
/** 标题  */
@property(nonatomic, weak) UILabel *titleLabel;
/** 关闭按钮  */
@property(nonatomic, weak) UIButton *closeButton;
/** data */
@property (nonatomic, strong) TSAgreementDataController *dataController;
/** title  */
@property(nonatomic, copy) NSString *title;

@end

@implementation TSAgreementView

- (instancetype)initWithTitle:(NSString *)title {
    if (self = [super init]) {
        _title = title;
        [self setUpInit];
        __weak __typeof(self)weakSelf = self;
        [self.dataController fetchAgreementContentsComplete:^(BOOL isSucess) {
            __strong __typeof(weakSelf)strongSelf = weakSelf;
            if (isSucess) {
                [strongSelf.collectionView reloadData];
            }
        }];
    }
    return self;
}

+ (instancetype)agreementViewWithTitle:(NSString *)title {
    return [[self alloc] initWithTitle:title];
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:.5 animations:^{
        CGRect rect = self.contentView.frame;
        rect.origin.y = GK_STATUSBAR_NAVBAR_HEIGHT;
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

- (void)setUpInit {
    self.contentView.backgroundColor = KWhiteColor;
    self.frame = [[UIScreen mainScreen] bounds];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    self.contentView.frame = CGRectMake(KRateW(36), kScreenHeight, kScreenWidth - KRateW(36) * 2, kScreenHeight - GK_STATUSBAR_NAVBAR_HEIGHT * 2);
    [self.contentView setCorners:UIRectCornerAllCorners radius:12];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(42);
        make.right.equalTo(self.contentView.mas_right).with.offset(-42);
        make.top.equalTo(self.contentView.mas_top).with.offset(24);
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(24);
        make.right.equalTo(self.contentView.mas_right).with.offset(-12);
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(16);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(-24);
    }];
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView.mas_right).with.offset(0);
        make.centerY.equalTo(self.contentView.mas_top).with.offset(0);
        make.width.height.mas_equalTo(24);
    }];
}


- (UIView *)contentView {
    if (_contentView == nil) {
        UIView *contentView = [[UIView alloc] init];
        _contentView = contentView;
        [self addSubview:_contentView];
    }
    return _contentView;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        TSUniversalFlowLayout *flowLayout = [[TSUniversalFlowLayout alloc]init];
        flowLayout.delegate = self;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                             collectionViewLayout:flowLayout];
        _collectionView = collectionView;
        _collectionView.backgroundColor = KWhiteColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        [self.contentView addSubview:_collectionView];
    }
    return _collectionView;
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        UILabel *titleLabel = [[UILabel alloc] init];
        _titleLabel = titleLabel;
        _titleLabel.text = self.title;
        _titleLabel.font = KFont(PingFangSCMedium, 16);
        _titleLabel.textColor = KTextColor;
        _titleLabel.numberOfLines = 0;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview: _titleLabel];
    }
    return _titleLabel;
}

- (UIButton *)closeButton {
    if (_closeButton == nil) {
        UIButton *closeButton = [[UIButton alloc] init];
        _closeButton = closeButton;
        //_closeButton.hidden = YES;
        [_closeButton setBackgroundImage:KImageMake(@"close_icon") forState:(UIControlStateNormal)];
        [_closeButton addTarget:self action:@selector(closeAction) forControlEvents:(UIControlEventTouchUpInside)];
        [self insertSubview:_closeButton aboveSubview:self.contentView];
    }
    return _closeButton;
}

- (TSAgreementDataController *)dataController {
    if (_dataController == nil) {
        _dataController = [[TSAgreementDataController alloc] init];
    }
    return _dataController;
}

#pragma mark - Actions
- (void)closeAction {
    [self dismiss];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataController.sections.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    TSAgreementSectionModel *model = self.dataController.sections[section];
    return model.items.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TSAgreementSectionModel *model = self.dataController.sections[indexPath.section];
    TSAgreementSectionItemModel *item = model.items[indexPath.row];
    Class className = NSClassFromString(item.identify);
    [collectionView registerClass:[className class] forCellWithReuseIdentifier:item.identify];
    TSUniversalCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:item.identify forIndexPath:indexPath];
    cell.indexPath = indexPath;
    cell.delegate = self;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark - UniversalCollectionViewCellDataDelegate
- (id)universalCollectionViewCellModel:(NSIndexPath *)indexPath{
    TSAgreementSectionModel *sectionModel = self.dataController.sections[indexPath.section];
    return sectionModel.items[indexPath.row];
}

#pragma mark - UniversalFlowLayoutDelegate
- (CGFloat)collectionView:(UICollectionView *_Nullable)collectionView
                   layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
  heightForRowAtIndexPath:(NSIndexPath *_Nullable)indexPath
                itemWidth:(CGFloat)itemWidth{
    TSAgreementSectionModel *model = self.dataController.sections[indexPath.section];
    TSAgreementSectionItemModel *item = model.items[indexPath.row];
    return item.cellHeight;
}

- (NSInteger)collectionView:(UICollectionView *_Nullable)collectionView
                     layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
      columnNumberAtSection:(NSInteger )section{
    TSAgreementSectionModel *model = self.dataController.sections[section];
    return model.column;
}

- (UIEdgeInsets)collectionView:(UICollectionView *_Nullable)collectionView
                        layout:(TSUniversalFlowLayout *_Nullable)collectionViewLayout
        insetForSectionAtIndex:(NSInteger)section{
    TSAgreementSectionModel *model = self.dataController.sections[section];
    return model.sectionInset;
}


@end
