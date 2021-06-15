//
//  TSTableViewSectionModel.h
//  TShopMall
//
//  Created by sway on 2021/6/12.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSTableViewSectionModel : NSObject
/// 作为 row 的数据源  （类型  id  ） model
@property (nonatomic,strong) NSArray *rowDatas;

/// 作为 headerView 的数据源  （类型  id  ） model
@property (nonatomic,strong) id headerModel;
/// 作为 footerView 的数据源  （类型  id  ） model
@property (nonatomic,strong) id footerModel;

/// 作为扩展字段  （类型  id  ） remark
@property (nonatomic,strong) id remark;

-(instancetype)initWithRowData:(NSArray *)datas;
@end

NS_ASSUME_NONNULL_END
