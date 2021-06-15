//
//  TSCartGoodsSection.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/9.
//

#import <Foundation/Foundation.h>

@class TSCartGoodsRow;

@interface TSCartGoodsSection : NSObject
@property (nonatomic, assign) CGFloat heightForHeader;
@property (nonatomic, assign) CGFloat heightForFooter;
@property (nonatomic, copy) NSString *headerIdentifier;
@property (nonatomic, copy) NSString *footerIdentifier;
//@property (nonatomic, strong) UITableViewHeaderFooterView *viewForHeader;
//@property (nonatomic, strong) UITableViewHeaderFooterView *viewForFooter;
@property (nonatomic, strong) NSArray<TSCartGoodsRow *> *rows;
@end


@interface TSCartGoodsRow : NSObject
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, strong) id obj;
@property (nonatomic, assign) BOOL isAutoHeight;
@property (nonatomic, assign) CGFloat rowHeight;
@property (nonatomic, assign) BOOL canScrollEdit;
@end

