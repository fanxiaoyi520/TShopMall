//
//  TSInterfacedConst.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/3.
//

#import "TSInterfacedConst.h"

#pragma mark - 接口前缀-开发服务器
NSString *const kApiPrefix = @"https://testpc.tclo2o.cn/rest";

#pragma mark - 注册&登录

#pragma mark - 首页
NSString * const kSearchKey = @"/rest/v2/front/product/queryKeyWord";
NSString * const kSearchAssociateWord = @"/rest/v2/front/product/associateWord";
NSString * const kSearchHotKey = @"/rest/v2/front/product/queryKeyWord";
NSString * const kSearchResult = @"/rest/v2/itemsearch/toProductList";

#pragma mark - 分类
NSString *const kShopContentUrl = @"/rest/v2/front/shopContent/getPageManageByPageType";
NSString * const kProducts = @"rest/v2/product/category/groups/searchProducts";

#pragma mark - 排行

#pragma mark - 采购蓝

#pragma mark - 我的
