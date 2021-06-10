//
//  TSUniversalSectionModel.h
//  TSale
//
//  Created by 陈洁 on 2020/12/8.
//  Copyright © 2020 TCL. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSUniversalSectionModel : NSObject

/// headerView 标识
@property (nonatomic, copy) NSString *headerIdentify;
/// footerView 标识
@property (nonatomic, copy) NSString *footerIdentify;
/// docorate 标识
@property (nonatomic, copy) NSString *docorateIdentify;
/// 是否有headerView
@property (nonatomic, assign) BOOL hasHeader;
/// 是否有footerView
@property (nonatomic, assign) BOOL hasFooter;
/// 是否有装饰视图
@property (nonatomic, assign) BOOL hasDecorate;
///每个区的边距
@property (nonatomic, assign) UIEdgeInsets sectionInset;
///每个区装饰视图的边距
@property (nonatomic, assign) UIEdgeInsets decorateInset;
///headerSize
@property (nonatomic, assign) CGSize headerSize;
///footerSize
@property (nonatomic, assign) CGSize footerSize;
///每个区多少列
@property (nonatomic, assign) NSInteger column;
///每个区行距
@property (nonatomic, assign) CGFloat lineSpacing;
///每个item之间的左右间距
@property (nonatomic, assign) CGFloat interitemSpacing;
///本区区头和上个区区尾的间距
@property (nonatomic, assign) CGFloat spacingWithLastSection;

@end

NS_ASSUME_NONNULL_END
