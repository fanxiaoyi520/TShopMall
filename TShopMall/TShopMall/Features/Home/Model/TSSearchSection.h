//
//  TSSearchSection.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/12.
//

#import <UIKit/UIKit.h>

@class TSSearchRow;

@interface TSSearchSection : NSObject
@property (nonatomic, copy) NSString *headerIdentifier;
@property (nonatomic, copy) NSString *footerIdentifier;
@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, assign) CGFloat footerHeight;
@property (nonatomic, copy) NSString *headerTitle;
@property (nonatomic, strong) NSArray<TSSearchRow *> *rows;
@end


@interface TSSearchRow : NSObject
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, strong) id obj;
@end
