//
//  TSGoodsListDataController.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/13.
//

#import "TSBaseDataController.h"
#import "TSGoodsListSection.h"
#import "TSSearchResult.h"
#import "TSGoodListViewModel.h"

typedef NS_ENUM(NSInteger, TSGoodsListSortType) {
    SortWeight    = 0,//综合
    YongJing            ,//佣金
    SalsNum             ,//销量
    Price                 ,//价格
};

@interface TSGoodsListDataController : TSBaseDataController
@property (nonatomic, assign) NSInteger totalNum;//总商品数量
@property (nonatomic, assign) NSInteger currentNum;
@property (nonatomic, assign) NSInteger currentPage;//当前分页数
@property (nonatomic, assign) TSGoodsListSortType sortType;
@property (nonatomic, copy) NSString *keyword;//关键字
@property (nonatomic, assign) NSInteger sort;//排序   1-降序，2-升序

@property (nonatomic, assign) BOOL isGrid;
@property (nonatomic, strong) TSSearchResult *result;
@property (nonatomic, strong) NSMutableArray<TSGoodsListSection *> *lists;
- (void)queryGoods:(void(^)(NSError *))finished;
- (NSArray<TSGoodsListSection *> *)sectionsForUIWithDatas:(NSArray<TSSearchList *> *)lists;

- (void)defaultConfig;
@end


/*
 {
     code = 200;
     data =     {
         attributeMap = "<null>";
         attributeValueMap = "<null>";
         brands =         (
         );
         catePrices =         (
         );
         categoryMap = "<null>";
         cates =         (
         );
         frontCategoryUuid = c176be96a4a5413a8874a10bf0d97d4b;
         jsonList = "<null>";
         keyword = "\U6d17\U8863\U673a";
         list =         (
                         {
                 auditState = 1;
                 bCustomerUuids = "";
                 baseRetailPrice = 30000;
                 bcustomerNo = "";
                 browseVolume = 0;
                 buyState = "";
                 buyStatePhone = 1;
                 buyStateTv = "";
                 carriageTemplateName = "<null>";
                 carriageTemplateUuid = "<null>";
                 catNames = "\U9009\U8d2d\U51b0\U6d17,\U6d17\U8863\U673a,\U51b0\U6d17,\U6d17\U8863\U673a,\U4eba\U6c14\U70ed\U5356,\U6d17\U8863\U673a\U5206\U7c7b\U5e7f\U544a,\U6d17\U8863\U673a,\U6d17\U8863\U673a\U5206\U7c7b\U5e7f\U544a,XESS\U667a\U5c4f,";
                 cats = "c176be96a4a5413a8874a10bf0d97d4b,789ec1d704684ca5b86e66db93b6e727,frontBXUuid,eff857890a9c4f00849c2e2dfc12e86c,144fb29a25f8400d8de6732b72d72050,productCategoryAdUuidPCWash,51dc2554485d4c549503a63298c34fae,productCategoryAdUuidWAPWash,9c20cde9520a4db9b0f8cfd8a911a7fd,";
                 channelPrice = 0;
                 clickurl = "";
                 comments = 0;
                 commission = 0;
                 desNote = "<null>";
                 desc = "TCL XQB55-36SP 5.5\U516c\U65a4\U5168\U81ea\U52a8\U6ce2\U8f6e\U8ff7\U4f60\U5c0f\U578b\U6d17\U8863\U673a\U5bb6\U7528\U5355\U8131\U6297\U83cc\U6876\U98ce\U5e72\U6d17\U8863\U673a LED\U5c4f \U667a\U80fd\U6a21\U7cca\U6d17+";
                 existProduct = 1;
                 favoriteState = "<null>";
                 friendPrice = 0;
                 isHide = "<null>";
                 isTuike = 0;
                 labelId = "<null>";
                 labelImageUrl = "<null>";
                 labelTitleName = "<null>";
                 limitNum = "<null>";
                 maxPrice = 0;
                 minPrice = 0;
                 mount = 0;
                 name = "TCL XQB55-36SP 5.5\U516c\U65a4\U5168\U81ea\U52a8\U6ce2\U8f6e\U8ff7\U4f60\U5c0f\U578b<span style='color:red'>\U6d17\U8863\U673a</span>\U5bb6\U7528\U5355\U8131\U6297\U83cc";
                 pTagId = "<null>";
                 pTagName = "<null>";
                 parentSkuNo = "XQB55-36SP-2";
                 phonePrice = 0;
                 pic = "http://f0.testpc.tclo2o.cn/pc44161O1CN01sK0kTW27kTlfV1Lk4_0-item_pic.jpg_430x430q90.jpg";
                 pic2 = "http://f0.testpc.tclo2o.cn/FgzG-nfnLQA0gg0xjyJjWL7KSDJF";
                 platformUuid = "platform_tcl_shop";
                 pname = "";
                 price = 30000;
                 priceText = "<null>";
                 productSn = "XQB55-36SP-1";
                 productTagList =                 (
                 );
                 productType = "";
                 productUuid = "";
                 promotionDesc = "<null>";
                 promotionLimitBuy = "<null>";
                 promotionPrice = 30000;
                 props = "";
                 recommend = "\U6876\U98ce\U5e72<span style='color:red'>\U6d17\U8863\U673a</span> LED\U5c4f \U667a\U80fd\U6a21\U7cca\U6d17";
                 salsnum = 16;
                 score = 0;
                 secondParentCategory = "\U6d17\U8863\U673a";
                 sellingPrice = 50000;
                 shelveTime = 1598345813;
                 skuNo = "S-45-XQB55-36SP-2-1";
                 staffPrice = 30000;
                 state = 1;
                 stock = 0;
                 storeCategoryUuids = "";
                 storeName = "";
                 storeUuid = tclplus;
                 systemNowTime = "<null>";
                 tenantId = TCL;
                 updateTime = 1621673551000;
                 uuid = 8f38847b3e814ef39e02f34b98616c03;
                 visitorVolume = "<null>";
             },
                         {
                 auditState = 1;
                 bCustomerUuids = "";
                 baseRetailPrice = 2880;
                 bcustomerNo = "";
                 browseVolume = 0;
                 buyState = "";
                 buyStatePhone = 1;
                 buyStateTv = "";
                 carriageTemplateName = "<null>";
                 carriageTemplateUuid = "<null>";
                 catNames = "\U9009\U8d2d\U51b0\U6d17,\U6d17\U8863\U673a,\U51b0\U6d17,\U6d17\U8863\U673a,\U4eba\U6c14\U70ed\U5356,\U6d17\U8863\U673a\U5206\U7c7b\U5e7f\U544a,\U6d17\U8863\U673a,\U6d17\U8863\U673a\U5206\U7c7b\U5e7f\U544a,XESS\U667a\U5c4f,";
                 cats = "c176be96a4a5413a8874a10bf0d97d4b,789ec1d704684ca5b86e66db93b6e727,frontBXUuid,eff857890a9c4f00849c2e2dfc12e86c,144fb29a25f8400d8de6732b72d72050,productCategoryAdUuidPCWash,51dc2554485d4c549503a63298c34fae,productCategoryAdUuidWAPWash,9c20cde9520a4db9b0f8cfd8a911a7fd,";
                 channelPrice = 0;
                 clickurl = "";
                 comments = 0;
                 commission = 0;
                 desNote = "<null>";
                 desc = "TCL XQGM100-S300BJD\U6d17\U8863\U673a \U53d8\U9891\U514d\U6c61\U5f0f\U6eda\U7b52";
                 existProduct = 0;
                 favoriteState = "<null>";
                 friendPrice = 0;
                 isHide = "<null>";
                 isTuike = 0;
                 labelId = "<null>";
                 labelImageUrl = "<null>";
                 labelTitleName = "<null>";
                 limitNum = "<null>";
                 maxPrice = 0;
                 minPrice = 0;
                 mount = 0;
                 name = "TCL XQGM100-S300BJD<span style='color:red'>\U6d17\U8863\U673a</span> \U53d8\U9891\U514d\U6c61\U5f0f\U6eda\U7b52";
                 pTagId = "<null>";
                 pTagName = "<null>";
                 parentSkuNo = "XQGM100-S300BJD";
                 phonePrice = 0;
                 pic = "http://f0.testpc.tclo2o.cn/pc124569FhBKEhi2SYHhAp6SxG2tq8wLmARM.jpg";
                 pic2 = "http://f0.testpc.tclo2o.cn/pc175431Fo.jpg";
                 platformUuid = "platform_tcl_shop";
                 pname = "";
                 price = 2880;
                 priceText = "<null>";
                 productSn = "XQGM100-S300BJD";
                 productTagList =                 (
                 );
                 productType = "";
                 productUuid = "";
                 promotionDesc = "<null>";
                 promotionLimitBuy = "<null>";
                 promotionPrice = 2880;
                 props = "";
                 recommend = "";
                 salsnum = 4;
                 score = 0;
                 secondParentCategory = "\U6d17\U8863\U673a";
                 sellingPrice = 2980;
                 shelveTime = 1607053159;
                 skuNo = "S-45-XQGM100-S300BJD-1";
                 staffPrice = 2880;
                 state = 1;
                 stock = 0;
                 storeCategoryUuids = "";
                 storeName = "";
                 storeUuid = tclplus;
                 systemNowTime = "<null>";
                 tenantId = TCL;
                 updateTime = 1617344470000;
                 uuid = 817e1eaa2496424d9e5204a8140b0bbf;
                 visitorVolume = "<null>";
             },
                         {
                 auditState = 1;
                 bCustomerUuids = "";
                 baseRetailPrice = 500;
                 bcustomerNo = "";
                 browseVolume = 0;
                 buyState = "";
                 buyStatePhone = 1;
                 buyStateTv = "";
                 carriageTemplateName = "<null>";
                 carriageTemplateUuid = "<null>";
                 catNames = "\U9009\U8d2d\U51b0\U6d17,\U6d17\U8863\U673a,\U51b0\U6d17,\U6d17\U8863\U673a,\U4eba\U6c14\U70ed\U5356,\U6d17\U8863\U673a\U5206\U7c7b\U5e7f\U544a,\U6d17\U8863\U673a,\U6d17\U8863\U673a\U5206\U7c7b\U5e7f\U544a,XESS\U667a\U5c4f,";
                 cats = "c176be96a4a5413a8874a10bf0d97d4b,789ec1d704684ca5b86e66db93b6e727,frontBXUuid,eff857890a9c4f00849c2e2dfc12e86c,144fb29a25f8400d8de6732b72d72050,productCategoryAdUuidPCWash,51dc2554485d4c549503a63298c34fae,productCategoryAdUuidWAPWash,9c20cde9520a4db9b0f8cfd8a911a7fd,";
                 channelPrice = 0;
                 clickurl = "";
                 comments = 0;
                 commission = 0;
                 desNote = "<null>";
                 desc = "XQG100-P300BD 10\U516c\U65a4\U6d17\U70d8\U53d8\U9891\U6d17\U8863\U673a\U8d2d\U673a\U4eab\U6536\U76ca\Uff0c\U8be6\U60c5\U626b\U7801\U5173\U6ce8\U5feb\U901f\U6d17\U70d8\U4e00\U4f53\Uff0c\U9664\U5473\U7a7a\U6c14\U6d17\Uff0c\U62a4\U8863\U5185\U7b52+";
                 existProduct = 1;
                 favoriteState = "<null>";
                 friendPrice = 0;
                 isHide = "<null>";
                 isTuike = 0;
                 labelId = "<null>";
                 labelImageUrl = "<null>";
                 labelTitleName = "<null>";
                 limitNum = "<null>";
                 maxPrice = 0;
                 minPrice = 0;
                 mount = 0;
                 name = "XQG100-P300BD 10\U516c\U65a4\U6d17\U70d8\U53d8\U9891<span style='color:red'>\U6d17\U8863\U673a</span>";
                 pTagId = "<null>";
                 pTagName = "<null>";
                 parentSkuNo = "XQG100-P300BD";
                 phonePrice = 0;
                 pic = "http://f0.testpc.tclo2o.cn/pc58244pc58244800--800--1.jpg";
                 pic2 = "http://f0.testpc.tclo2o.cn/pc68526pc68526800--800--2.jpg";
                 platformUuid = "platform_tcl_shop";
                 pname = "";
                 price = 500;
                 priceText = "<null>";
                 productSn = "XQG100-P300BD";
                 productTagList =                 (
                 );
                 productType = "";
                 productUuid = "";
                 promotionDesc = "<null>";
                 promotionLimitBuy = "<null>";
                 promotionPrice = 500;
                 props = "";
                 recommend = "\U8d2d\U673a\U4eab\U6536\U76ca\Uff0c\U8be6\U60c5\U626b\U7801\U5173\U6ce8\U5feb\U901f\U6d17\U70d8\U4e00\U4f53\Uff0c\U9664\U5473\U7a7a\U6c14\U6d17\Uff0c\U62a4\U8863\U5185\U7b52";
                 salsnum = 35;
                 score = 0;
                 secondParentCategory = "\U6d17\U8863\U673a";
                 sellingPrice = 50000;
                 shelveTime = 1598407611;
                 skuNo = "S-45-XQG100-P300BD-1";
                 staffPrice = 500;
                 state = 1;
                 stock = 0;
                 storeCategoryUuids = "";
                 storeName = "";
                 storeUuid = tclplus;
                 systemNowTime = "<null>";
                 tenantId = TCL;
                 updateTime = 1622620466000;
                 uuid = f83d1e280e9a4f9fa41b54fb8fcf7dc8;
                 visitorVolume = "<null>";
             },
                         {
                 auditState = 1;
                 bCustomerUuids = "";
                 baseRetailPrice = 2;
                 bcustomerNo = "";
                 browseVolume = 0;
                 buyState = "";
                 buyStatePhone = 1;
                 buyStateTv = "";
                 carriageTemplateName = "<null>";
                 carriageTemplateUuid = "<null>";
                 catNames = "\U6eda\U7b52\U6d17\U8863\U673a,\U6d17\U8863\U673a,\U6eda\U7b52\U6d17\U8863\U673a,XESS\U667a\U5c4f,\U6d17\U8863\U673a\U5206\U7c7b\U5e7f\U544a,\U6eda\U7b52\U6d17\U8863\U673a,\U6d17\U8863\U673a\U5206\U7c7b\U5e7f\U544a,\U4eba\U6c14\U70ed\U5356,\U6d17\U8863\U673a,\U51b0\U6d17,\U6d17\U8863\U673a,";
                 cats = "8ecd91d0b51f47dcbc082821c0385861,789ec1d704684ca5b86e66db93b6e727,1e39c062f0694f4d875aab87c95c44c6,9c20cde9520a4db9b0f8cfd8a911a7fd,productCategoryAdUuidWAPWash,eae8b4cf4755415488c72a984670f955,productCategoryAdUuidPCWash,144fb29a25f8400d8de6732b72d72050,51dc2554485d4c549503a63298c34fae,frontBXUuid,eff857890a9c4f00849c2e2dfc12e86c,";
                 channelPrice = 0;
                 clickurl = "";
                 comments = 0;
                 commission = 0;
                 desNote = "<null>";
                 desc = "TCL6.5\U516c\U65a4\U62a4\U8863\U6eda\U7b52\U6d17\U8863\U673a\U54c7\U54c8\U54c8\U54c8\U54c8\U591c\U591c\U591c\U591c\U54c7\U54c8\U54c8\U54c8\U54c8\U591c\U591c\U591c\U591c\U54c7\U54c8\U54c8\U54c8\U54c8\U591c\U591c\U591c\U591c\U54c7\U54c8\U54c8\U54c8\U54c8\U591c\U591c\U591c\U591c\U54c7\U54c8\U54c8\U54c8\U54c8\U591c\U591c\U591c\U591c\U54c7\U54c8\U54c8\U54c8\U54c8\U591c\U591c\U591c\U591c\U54c7\U54c8\U54c8\U54c8\U54c8\U591c\U591c\U591c\U591c\U54c7\U54c8\U54c8\U54c8\U54c8\U591c\U591c\U591c\U591c\U54c7\U54c8\U54c8\U54c8\U54c8\U591c\U591c\U591c\U591c\U54c7\U54c8\U54c8\U54c8\U54c8\U591c\U591c\U591c\U591c\U54c7\U54c8\U54c8\U54c8\U54c8\U591c\U591c\U591c\U591c\U54c7\U54c8\U54c8\U54c8\U54c8\U591c\U591c\U591c\U591c+";
                 existProduct = 1;
                 favoriteState = "<null>";
                 friendPrice = 0;
                 isHide = "<null>";
                 isTuike = 0;
                 labelId = "<null>";
                 labelImageUrl = "<null>";
                 labelTitleName = "<null>";
                 limitNum = "<null>";
                 maxPrice = 0;
                 minPrice = 0;
                 mount = 0;
                 name = "TCL6.5\U516c\U65a4\U62a4\U8863\U6eda\U7b52<span style='color:red'>\U6d17\U8863\U673a</span>";
                 pTagId = "<null>";
                 pTagName = "<null>";
                 parentSkuNo = ceshi00001;
                 phonePrice = 0;
                 pic = "http://f0.testpc.tclo2o.cn/pc7113timg.jpg";
                 pic2 = "http://f0.testpc.tclo2o.cn/pc24211u21042681222776525573fm26gp0.jpg";
                 platformUuid = "platform_tcl_shop";
                 pname = "";
                 price = 2;
                 priceText = "<null>";
                 productSn = ceshi0915;
                 productTagList =                 (
                 );
                 productType = "";
                 productUuid = "";
                 promotionDesc = "<null>";
                 promotionLimitBuy = "<null>";
                 promotionPrice = 2;
                 props = "";
                 recommend = "\U54c7\U54c8\U54c8\U54c8\U54c8\U591c\U591c\U591c\U591c\U54c7\U54c8\U54c8\U54c8\U54c8\U591c\U591c\U591c\U591c\U54c7\U54c8\U54c8\U54c8\U54c8\U591c\U591c\U591c\U591c\U54c7\U54c8\U54c8\U54c8\U54c8\U591c\U591c\U591c\U591c\U54c7\U54c8\U54c8\U54c8\U54c8\U591c\U591c\U591c\U591c\U54c7\U54c8\U54c8\U54c8\U54c8\U591c\U591c\U591c\U591c\U54c7\U54c8\U54c8\U54c8\U54c8\U591c\U591c\U591c\U591c\U54c7\U54c8\U54c8\U54c8\U54c8\U591c\U591c\U591c\U591c\U54c7\U54c8\U54c8\U54c8\U54c8\U591c\U591c\U591c\U591c\U54c7\U54c8\U54c8\U54c8\U54c8\U591c\U591c\U591c\U591c\U54c7\U54c8\U54c8\U54c8\U54c8\U591c\U591c\U591c\U591c\U54c7\U54c8\U54c8\U54c8\U54c8\U591c\U591c\U591c\U591c";
                 salsnum = 101;
                 score = 0;
                 secondParentCategory = "\U6d17\U8863\U673a";
                 sellingPrice = 2580;
                 shelveTime = 1614850246;
                 skuNo = "S-45-ceshi00001-1";
                 staffPrice = 2;
                 state = 1;
                 stock = 0;
                 storeCategoryUuids = "";
                 storeName = "";
                 storeUuid = tclplus;
                 systemNowTime = "<null>";
                 tenantId = TCL;
                 updateTime = 1620875655000;
                 uuid = b5f4e1c624484ab487691c625819b0d3;
                 visitorVolume = "<null>";
             }
         );
         mapProduct = "<null>";
         searcheName = "\U6d17\U8863\U673a";
         subCate = "<null>";
         totalNum = 4;
     };
     loginUser = "<null>";
     message = "\U4e00\U5207\U6b63\U5e38";
     transId = 50787369da954c95a559e79ee0974f17;
     type = "<null>";
     userId = "<null>";
 }
 */
