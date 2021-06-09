//
//  TSCartViewModel.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/9.
//

#import <Foundation/Foundation.h>
#import "TSCartGoodsSection.h"
#import "TSCartHeaderFooterView.h"
#import "TSCartModel.h"

@interface TSCartViewModel : NSObject
@property (nonatomic, strong) NSArray<TSCartGoodsSection *> *sections;

+ (instancetype)congfigViewModelWithCartInfo:(TSCartModel *)cartModel;
//+ (NSArray<TSCartGoodsSection *> *)viewModel:(TSCartModel *)model;

+ (NSArray<TSCartModel *> *)canOperationGoodsInSections:(NSArray<TSCartGoodsSection *> *)sections;

//是否全选
+ (BOOL)isAllGoodsSelected:(NSArray<TSCartModel *> *)goods;


+ (NSArray<TSCartModel *> *)selectedInfo:(NSArray<TSCartModel *> *)cartModels;
+ (NSString *)totalPrice:(NSArray<TSCartModel *> *)cartModels;
@end
