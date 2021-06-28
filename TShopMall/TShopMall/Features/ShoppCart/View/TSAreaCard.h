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
@class TSAreaLable;
@class TSAreaIndexView;

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
@property (nonatomic, strong) TSAreaLable *proviceBtn;
@property (nonatomic, strong) TSAreaLable *cityBtn;
@property (nonatomic, strong) TSAreaLable *areaBtn;
@property (nonatomic, strong) TSAreaLable *streetBtn;

- (void)updateString:(NSString *)string type:(NSInteger)type;
@end


@interface TSAreaLable : UILabel
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, copy) NSString *str;
- (void)addTarget:(id)target selector:(SEL)selector;
@end


@interface TSAreaIndexView : UIView
@property (nonatomic, strong) NSArray<NSString *> *indexs;
@property (nonatomic, strong) UIImageView *indeImg;
@property (nonatomic, strong) UILabel *indeDes;
@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, assign) CGFloat btnHeight;
@property (nonatomic, assign) NSInteger lastTag;
@property (nonatomic, copy) void(^indexChanged)(NSInteger index);
@end
