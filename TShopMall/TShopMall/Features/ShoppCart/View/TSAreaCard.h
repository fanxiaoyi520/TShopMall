//
//  TSAreaCard.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/18.
//

#import <UIKit/UIKit.h>
#import "TSAreaModel.h"

@protocol TSAreaDelegate <NSObject>
//加载对应的数据
- (void)reloadDataWiteType:(NSInteger)type uuid:(NSString *)uuid;
- (void)reloadData;
- (void)exit;
@end

@class TSAreaCell;
@class TSAreaView;
@class TSAreaButton;
@class TSAreaIndexView;
@class TSAreaIndexIndeView;

@interface TSAreaCard : UIView
@property (nonatomic, weak) id controller;
@property (nonatomic, strong) NSDictionary<NSString *, NSArray<TSAreaModel *> *> *datas;
@property (nonatomic, weak) id<TSAreaDelegate> delegate;

@property (nonatomic, strong) TSAreaModel *provice;
@property (nonatomic, strong) TSAreaModel *city;
@property (nonatomic, strong) TSAreaModel *area;
@property (nonatomic, strong) TSAreaModel *street;
@property (nonatomic, copy) NSString *location;
@end


@interface TSAreaCell : UITableViewCell
@property (nonatomic, strong) UILabel *mark;
@property (nonatomic, strong) UILabel *des;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, strong) TSAreaModel *areaModel;
@end


@interface TSAreaView : UIScrollView
@property (nonatomic, strong) TSAreaButton *proviceBtn;
@property (nonatomic, strong) TSAreaButton *cityBtn;
@property (nonatomic, strong) TSAreaButton *areaBtn;
@property (nonatomic, strong) TSAreaButton *streetBtn;

@property (nonatomic, strong) NSMutableArray<TSAreaButton *> *areaBtns;

- (void)updateString:(NSString *)string type:(NSInteger)type;
- (void)changeUIOfAreaButtonTapped:(NSInteger)type;
@end

@interface TSAreaButton : UIButton
@property (nonatomic, copy) NSString *normalTitle;
@property (nonatomic, copy) NSString *selectedTitle;
@end

@interface TSAreaIndexView : UIView
@property (nonatomic, strong) NSArray<NSString *> *indexs;
@property (nonatomic, assign) NSInteger lastTag;
@property (nonatomic, copy) void(^indexChanged)(NSInteger index, NSString *tag);
@property (nonatomic, copy) void(^shouldShowIndeImg)(BOOL show);
@end

@interface TSAreaIndexIndeView : UIImageView
@property (nonatomic, strong) UILabel *indeDes;
- (void)shouldShow:(BOOL)show;
@end


@interface TSAreaHotCityHeader : UITableViewHeaderFooterView
@property (nonatomic, strong) NSArray<TSAreaModel *> *hotCities;
@property (nonatomic, strong) UILabel *title;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, copy) void(^hotcitySeleted)(TSAreaModel *);
@end
