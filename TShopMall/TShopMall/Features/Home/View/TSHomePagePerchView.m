//
//  TSHomePagePerchView.m
//  TShopMall
//
//  Created by sway on 2021/6/19.
//

#import "TSHomePagePerchView.h"
#import "TSGridButtonCollectionView.h"
#import "TSHomePageBaseModel.h"

@interface TSHomePagePerchView()
@end
@implementation TSHomePagePerchView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = KWhiteColor;
    }
    return self;
}

- (void)configPerch
{
    TSHomePageBaseModel *model = [TSHomePageBaseModel new];
    UIEdgeInsets padding = UIEdgeInsetsMake(16, 16, 12, 16);
    TSGridButtonCollectionView *banner = [[TSGridButtonCollectionView alloc] initWithFrame:CGRectZero items:@[model] ColumnSpacing:0 rowSpacing:0 itemsHeight:174 rows:1 columns:1 padding:padding clickedBlock:nil];
    [self addSubview:banner];
    banner.collectionView.backgroundColor = [UIColor clearColor];
    banner.collectionView.scrollEnabled = NO;
    banner.configCustomView = ^UIView *(id model, NSIndexPath *indexPath) {
        UIView *view = [UIView new];
        view.backgroundColor = KHexColor(@"EFEFEF");;
        view.layer.cornerRadius = 6;

        return view;
    };
    [banner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self);
        make.width.equalTo(@(kScreenWidth));
        make.height.equalTo(@40);
    }];
    [banner reloadData];
    
    NSMutableArray *marr = @[].mutableCopy;
    for (int i = 0; i < 10; i ++) {
        TSHomePageBaseModel *model = [TSHomePageBaseModel new];
        [marr addObject:model];
    }
    padding = UIEdgeInsetsMake(16, 16, 16, 16);
    TSGridButtonCollectionView *category = [[TSGridButtonCollectionView alloc] initWithFrame:CGRectZero items:marr ColumnSpacing:18 rowSpacing:20 itemsHeight:66 rows:2 columns:5 padding:padding clickedBlock:nil];
    [self addSubview:category];
    category.collectionView.backgroundColor = KWhiteColor;
    category.layer.cornerRadius = 12;
    category.clipsToBounds = YES;
    category.configCustomView = ^UIView *(id model, NSIndexPath *indexPath) {
        UIView *view = [UIView new];
        UIView *top = [UIView new];
        top.layer.cornerRadius = 2;
        top.backgroundColor = KHexColor(@"EFEFEF");
        [view addSubview:top];
        [top mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view);
            make.left.equalTo(view).offset(4);
            make.right.equalTo(view).offset(-4);
            make.height.equalTo(@(40));
        }];

        UIView *bottom = [UIView new];
        bottom.backgroundColor = KHexColor(@"EFEFEF");
        [view addSubview:bottom];
        bottom.layer.cornerRadius = 4;
        [bottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.equalTo(view);
            make.height.equalTo(@(18));
        }];

        return view;
    };
    [category mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(banner.mas_bottom);
        make.left.equalTo(self).offset(16);
        make.right.equalTo(self).offset(-16);
        make.width.equalTo(@(kScreenWidth - 32));

    }];
    [category reloadData];

    model = [TSHomePageBaseModel new];
    padding = UIEdgeInsetsMake(7, 15, 7, 286);
    TSGridButtonCollectionView *title = [[TSGridButtonCollectionView alloc] initWithFrame:CGRectZero items:@[model] ColumnSpacing:0 rowSpacing:0 itemsHeight:20 rows:1 columns:1 padding:padding clickedBlock:nil];
    [self addSubview:title];
    title.collectionView.backgroundColor = [UIColor clearColor];
    title.configCustomView = ^UIView *(id model, NSIndexPath *indexPath) {
        UIView *view = [UIView new];
        view.backgroundColor = KHexColor(@"EFEFEF");;
        view.layer.cornerRadius = 4;

        return view;
    };
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(category.mas_bottom).offset(12);
        make.height.equalTo(@(20));
    }];
    [title reloadData];

    model = [TSHomePageBaseModel new];
    padding = UIEdgeInsetsMake(0, 16, 0, 16);
    TSGridButtonCollectionView *release = [[TSGridButtonCollectionView alloc] initWithFrame:CGRectZero items:@[model] ColumnSpacing:0 rowSpacing:0 itemsHeight:447 rows:1 columns:1 padding:padding clickedBlock:nil];
    [self addSubview:release];
    release.collectionView.backgroundColor = [UIColor clearColor];
    release.configCustomView = ^UIView *(id model, NSIndexPath *indexPath) {
        UIView *view = [UIView new];
        view.backgroundColor = KHexColor(@"EFEFEF");;
        view.layer.cornerRadius = 8;

        return view;
    };
    [release mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(title.mas_bottom);
    }];
    [release reloadData];

    marr = @[].mutableCopy;
    for (int i = 0; i < 5; i ++) {
        TSHomePageBaseModel *model = [TSHomePageBaseModel new];
        [marr addObject:model];
    }
    padding = UIEdgeInsetsMake(12, 0, 12, 0);
    TSGridButtonCollectionView *nav = [[TSGridButtonCollectionView alloc] initWithFrame:CGRectZero items:marr ColumnSpacing:0 rowSpacing:0 itemsHeight:20 rows:1 columns:5 padding:padding clickedBlock:nil];
    [self addSubview:nav];
    nav.collectionView.backgroundColor = [UIColor clearColor];
    nav.configCustomView = ^UIView *(id model, NSIndexPath *indexPath) {
        UIView *view = [UIView new];
        UIView *top = [UIView new];
        top.layer.cornerRadius = 4;
        if (indexPath.row == 0) {
            top.backgroundColor = KHexColor(@"FCEDEB");
        }else
            top.backgroundColor = KHexColor(@"EFEFEF");
        [view addSubview:top];
        [top mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(view);
            make.left.equalTo(@(16));
            make.height.equalTo(@(20));
            make.right.equalTo(view).offset(-12);
        }];

        if (indexPath.row != 0) {
            UIView *line = [UIView new];
            line.backgroundColor = KHexColor(@"EFEFEF");
            [view addSubview:line];
            [line mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(view);
                make.height.equalTo(@(12));
                make.width.equalTo(@(1));
            }];
        }
        return view;
    };
    [nav mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(release.mas_bottom);
        make.left.equalTo(self);
        make.right.equalTo(self);
//        make.bottom.equalTo(self);

    }];
    [nav reloadData];
    
    marr = @[].mutableCopy;
    for (int i = 0; i < 4; i ++) {
        TSHomePageBaseModel *model = [TSHomePageBaseModel new];
        [marr addObject:model];
    }
    padding = UIEdgeInsetsMake(0, 16, 0, 16);
    TSGridButtonCollectionView *container = [[TSGridButtonCollectionView alloc] initWithFrame:CGRectZero items:marr ColumnSpacing:8 rowSpacing:8 itemsHeight:282 rows:2 columns:2 padding:padding clickedBlock:nil];
    [self addSubview:container];
    container.collectionView.backgroundColor = [UIColor clearColor];
    container.configCustomView = ^UIView *(id model, NSIndexPath *indexPath) {
        UIView *view = [UIView new];
        view.backgroundColor = KWhiteColor;
        view.layer.cornerRadius = 8;
        view.clipsToBounds = YES;
        UIView *top = [UIView new];
        top.backgroundColor = KHexColor(@"EFEFEF");
        [view addSubview:top];
        [top mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.equalTo(view);
            make.height.equalTo(@(168));
        }];

        UIView *title1 = [UIView new];
        title1.layer.cornerRadius = 4;
        title1.backgroundColor = KHexColor(@"EFEFEF");
        [view addSubview:title1];
        [title1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(top.mas_bottom).offset(9);
            make.left.equalTo(view).offset(8);
            make.right.equalTo(view).offset(-7);
            make.height.equalTo(@(21));
        }];
        
        UIView *title2 = [UIView new];
        title2.layer.cornerRadius = 4;
        title2.backgroundColor = KHexColor(@"EFEFEF");
        [view addSubview:title2];
        [title2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(title1.mas_bottom).offset(3);
            make.left.equalTo(view).offset(8);
            make.right.equalTo(view).offset(-42);
            make.height.equalTo(@(17));
        }];
        
        UIView *mid1 = [UIView new];
        mid1.backgroundColor = KHexColor(@"FCEDEB");
        mid1.layer.cornerRadius = 4;

        [view addSubview:mid1];
        
        UIView *mid2 = [UIView new];
        mid2.layer.cornerRadius = 4;

        mid2.backgroundColor = KHexColor(@"FCEDEB");
        [view addSubview:mid2];
       
        [@[mid1, mid2] mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:13 leadSpacing:8 tailSpacing:8];
        // 设置array的垂直方向的约束
        [@[mid1, mid2] mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(title2.mas_bottom).offset(13);
            make.height.equalTo(@(21));
        }];
        
        UIView *bottom = [UIView new];
        bottom.backgroundColor = KHexColor(@"EFEFEF");
        bottom.layer.cornerRadius = 4;
        [view addSubview:bottom];
        [bottom mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(mid1.mas_bottom).offset(9);
            make.left.equalTo(view).offset(8);
            make.right.equalTo(view).offset(-101);
            make.height.equalTo(@(11));
        }];

        return view;
    };
    [container mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nav.mas_bottom);
        make.left.equalTo(self);
        make.right.equalTo(self);
        make.bottom.equalTo(self);

    }];
    [container reloadData];
    
}
@end
