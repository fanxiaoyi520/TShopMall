//
//  TSBridgeHandler.m
//  TSale
//
//  Created by 陈洁 on 2020/12/31.
//  Copyright © 2020 TCL. All rights reserved.
//

#import "TSBridgeHandler.h"
#import "TSWKMessageHandlerHelper.h"
#import "TSWKAppManager.h"
#import "TSUserInfoManager.h"
//#import "TSAddressManager.h"
#import "TSHybridViewController.h"
#import "TSLoginViewController.h"
//#import "TSGoodDetailActivityController.h"
//#import "TSGoodsDetailViewController.h"
//#import "TSSeckillDetailController.h"
//#import "TSPackageDetailController.h"
//#import "TSGoodDetailGiftActivityController.h"
//#import "TSPurchersViewController.h"
//#import "TSPurcherGoodInfo.h"
#import "AppDelegate.h"
#import "TSShareView.h"
//#import "TSOrderController.h"
//#import "TSOrderDetailController.h"
//#import "TSAddressManager.h"//客户地址信息
//#import "TSB2bPurchaseOrderParamsModel.h"
//#import "TSPlaceAnOrderController.h"
//#import "TSHomeCategoryRequest.h"


@implementation TSBridgeHandler
//跳转到订单详情
-(void)goOrderDetail:(NSDictionary *)params{
    TSHybridViewController *controller = [TSWKAppManager currentController:params[@"webview"]];
    NSDictionary *data = params[@"data"];
    NSDictionary *paramsDic = data[@"params"];
    NSDictionary *dataDic = paramsDic[@"data"];
//    NSMutableArray * tempArr = [TSOrderInfoModel dateModelProcessingWithModels:[TSOrderInfoModel mj_objectArrayWithKeyValuesArray:@[dataDic]]];
//    TSOrderInfoModel * model = tempArr.firstObject;
//    TSOrderSubsModel * subModel = model.orderSubs.firstObject;
//    TSOrderDetailController * detaiVC = [TSOrderDetailController new];
//    detaiVC.businessId  = subModel.orderId;
//    detaiVC.msgtype = @"1";
//    [controller.navigationController pushViewController:detaiVC animated:YES];
}

-(void)refreshOrderList:(NSDictionary *)params{
    
    TSHybridViewController *controller = [TSWKAppManager currentController:params[@"webview"]];
    
    NSDictionary *data = params[@"data"];
    NSDictionary *paramsDic = data[@"params"];
    NSDictionary *dataDic = paramsDic[@"data"];
    NSString *entranceType = dataDic[@"entranceType"];
    
    NSArray *childs = controller.navigationController.childViewControllers;
    UIViewController *aim;
    if ([entranceType isEqualToString:@"orderList"]) {//订单列表
        
        for (UIViewController *controller in childs) {
            if ([controller isKindOfClass:[NSClassFromString(@"TSOrderController") class]]) {
                aim = controller;
                break;
            }
        }
    } else {//订单详情
        for (UIViewController *controller in childs) {
            if ([controller isKindOfClass:[NSClassFromString(@"TSOrderDetailController") class]]) {
                aim = controller;
                break;
            }
        }
    }
    [controller.navigationController popToViewController:aim animated:YES];
}

-(void)webInitMounted:(NSDictionary *)params{
    TSHybridViewController *controller = [TSWKAppManager currentController:params[@"webview"]];
    [controller evaluateWebViewInitData];
}

-(void)setNavigationMenu:(NSDictionary *)params{
    NSDictionary *data = params[@"data"];
    NSDictionary *paramsDic = data[@"params"];
    NSString *imageName = paramsDic[@"imageName"];
    
    TSHybridViewController *controller = [TSWKAppManager currentController:params[@"webview"]];
    controller.menuParams = data;
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightButton.frame = CGRectMake(0, 0, 30, 30);
    rightButton.imageView.contentMode = UIViewContentModeCenter;
    if ([@"moreNavigation" isEqualToString:imageName]) {
        [rightButton setImage:KImageMake(@"navigation_more") forState:UIControlStateNormal];
    }
    
    [rightButton addTarget:controller action:NSSelectorFromString(@"rightButtonOnClick:event:") forControlEvents:UIControlEventTouchUpInside];
    controller.gk_navItemRightSpace = 12;
    controller.gk_navRightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

-(void)updateNavigation:(NSDictionary *)params{
    NSDictionary *data = params[@"data"];
    NSDictionary *paramsDic = data[@"params"];
    
    NSString *title = paramsDic[@"title"];
    NSString *rightText = paramsDic[@"rightText"];
    NSString *rightClick = paramsDic[@"rightClick"];
    NSString *leftClick = paramsDic[@"leftClick"];
   
    TSHybridViewController *controller = [TSWKAppManager currentController:params[@"webview"]];
    
    if ([title isKindOfClass:[NSString class]] && title.length > 0) {
        controller.gk_navTitle = title;
    }
    controller.rightButtonTitle = rightText;
    controller.rightClick = rightClick;
    controller.leftClick = leftClick;
    controller.gk_navItemRightSpace = 12;
    
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [rightButton setString:rightText textColor:KTextColor font:KRegularFont(15.0) forState:UIControlStateNormal];
    [rightButton addTarget:controller action:NSSelectorFromString(@"rightAction:") forControlEvents:UIControlEventTouchUpInside];
    controller.gk_navRightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

-(void)updateNavColor:(NSDictionary *)params{
    NSDictionary *data = params[@"data"];
    NSDictionary *paramsDic = data[@"params"];
    
    NSString *backColor = paramsDic[@"backColor"];
    NSString *textColor = paramsDic[@"textColor"];
    
    TSHybridViewController *controller = [TSWKAppManager currentController:params[@"webview"]];
    controller.gk_navTitleColor = KHexColor(textColor);
    controller.gk_navBackgroundColor = KHexColor(backColor);
    controller.gk_navLineHidden = YES;
    
    if ([textColor isEqualToString:@"#FFFFFF"]) {
        controller.gk_backStyle = GKNavigationBarBackStyleWhite;
    } else {
        controller.gk_backStyle = GKNavigationBarBackStyleBlack;
    }
    
    [controller.gk_navigationBar layoutIfNeeded];
}

#pragma mark - 取消右侧按钮选中
-(void)cancelRightActive:(NSDictionary *)params{
    TSHybridViewController *controller = [TSWKAppManager currentController:params[@"webview"]];
//    [controller cancelRightActive];
}

-(void)close:(NSDictionary *)params{
    NSDictionary *data = params[@"data"];
    NSDictionary *paramsDic = data[@"params"];
    NSString *backUrl = @"";
    NSString *leftUrl = @"";
    TSHybridViewController *controller = [TSWKAppManager currentController:params[@"webview"]];
    if ([paramsDic isKindOfClass:[NSDictionary class]] && paramsDic.count > 0) {
        if ([paramsDic[@"leftClick"] isKindOfClass:[NSString class]] && ((NSString *)paramsDic[@"leftClick"]).length > 0) {
            leftUrl = paramsDic[@"leftClick"];
        }
        if ([paramsDic[@"backUrl"] isKindOfClass:[NSString class]] && ((NSString *)paramsDic[@"backUrl"]).length > 0) {
            backUrl = paramsDic[@"backUrl"];
        }
    }
    
    if (backUrl.length > 0) {
       NSArray *childs = controller.navigationController.childViewControllers;
        for (UIViewController *con in childs) {
            if ([con isKindOfClass:[TSHybridViewController class]]) {
                TSHybridViewController *hybrid = (TSHybridViewController *)con;
                if ([hybrid.request.URL.absoluteString isEqualToString:backUrl]) {
                    if (leftUrl.length > 0) {
                        NSDictionary *callBackDic = paramsDic[@"data"];
                        NSString *json = @"";
                        if ([callBackDic isKindOfClass:[NSDictionary class]] && callBackDic.count > 0) {
                            json = [callBackDic jsonStringEncoded];
                        }
                        [TSWKMessageHandlerHelper callbackWithMethodName:leftUrl callBackParams:json webView:hybrid.webView];
                    }
                    [controller.navigationController popToViewController:hybrid animated:YES];
                    break;
                }
            }
        }
    }else{
        NSArray *childs = controller.navigationController.childViewControllers;
        NSInteger count = childs.count;
        TSHybridViewController *hybrid = childs[count - 2];
        if (leftUrl.length > 0) {
            NSDictionary *callBackDic = paramsDic[@"data"];
            NSString *json = @"";
            if ([callBackDic isKindOfClass:[NSDictionary class]] && callBackDic.count > 0) {
                json = [callBackDic jsonStringEncoded];
            }
            [TSWKMessageHandlerHelper callbackWithMethodName:leftUrl callBackParams:json webView:hybrid.webView];
        }
        [controller.navigationController popViewControllerAnimated:YES];
    }
}

-(void)goForward:(NSDictionary *)params{
    NSDictionary *data = params[@"data"];
    NSDictionary *paramDic = data[@"params"];

    TSHybridViewController *controller = [[TSHybridViewController alloc] initWithURLString:paramDic[@"url"]];
    controller.rightParams = paramDic;
    controller.jsDataParams = data;
    controller.gk_navTitle = paramDic[@"title"];
    controller.rightButtonTitle = paramDic[@"rightText"];
    controller.rightClick = paramDic[@"rightClick"];
    controller.leftClick = paramDic[@"leftClick"];
    [[TSWKAppManager currentNavigationController] pushViewController:controller animated:YES];
}

#pragma mark - 调转到原生页面
-(void)navigation:(NSDictionary *)params{
    NSDictionary *data = params[@"data"];
    NSDictionary *paramsDic = data[@"params"];
    NSString *controllerName = paramsDic[@"name"];
    Class className = NSClassFromString(controllerName);
    UIViewController *con = [[className alloc] init];
    TSHybridViewController *controller = [TSWKAppManager currentController:params[@"webview"]];
    [controller.navigationController pushViewController:con animated:YES];
}

#pragma mark - 获取默认地址
//-(void)getDefaultAddress:(NSDictionary *)params{
//    NSDictionary *data = params[@"data"];
//    NSDictionary *callBack = data[@"callback"];
//    TSAddressManager *addressManager = [TSAddressManager shareManager];
//    TSDeliveryAddressModel *model = addressManager.defaultModel;
//    NSString *addressJson = [model mj_JSONString];
//    if (addressJson.length <= 0) {
//        addressJson = @"";
//    }
//
//    [TSWKMessageHandlerHelper callbackWithMethodName:callBack[@"success"] callBackParams:addressJson webView:params[@"webview"]];
//}

//-(void)deliveryDatas:(NSDictionary *)datas{
//    NSDictionary *data = datas[@"data"];
//    NSDictionary *params = data[@"params"];
//    NSDictionary *paramData = params[@"data"];
//    if ([@"OrderEnsure" isEqualToString:paramData[@"fromUrl"]]) {
//        [[TSAddressManager shareManager] setupAuthAddress:paramData];
//        TSHybridViewController *controller = [TSWKAppManager currentController:datas[@"webview"]];
//        [controller.navigationController popViewControllerAnimated:YES];
//    }
//
//}

//-(void)deleteDefaultAddress:(NSDictionary *)params{
//    [[TSAddressManager shareManager] getDefaultAddressComplete:^(NSDictionary * _Nonnull response, BOOL isSucess) {
//
//    }];
//}

//-(void)setDefaultAddress:(NSDictionary *)params{
//    [[TSAddressManager shareManager] getDefaultAddressComplete:^(NSDictionary * _Nonnull response, BOOL isSucess) {
//
//    }];
//}
#pragma mark - 我的T币跳转到 订单详情页
//-(void)goOrderDetailById:(NSDictionary *)params
//{
//    TSOrderDetailController *detaiVC  = [TSOrderDetailController new];
//    NSDictionary *dataDic =   params[@"data"];
//    NSString *orderId = dataDic[@"params"][@"orderId"];
//    detaiVC.businessId  = orderId;
//    detaiVC.msgtype = @"1";
//    TSHybridViewController *controller = [TSWKAppManager currentController:params[@"webview"]];
//    [controller.navigationController pushViewController:detaiVC animated:YES];
//
//}
#pragma mark - 跳转采购栏
//-(void)gotoShopCart:(NSDictionary *)params{
//    TSPurchersViewController *purcher = [[TSPurchersViewController alloc] init];
//    TSHybridViewController *controller = [TSWKAppManager currentController:params[@"webview"]];
//    [controller.navigationController pushViewController:purcher animated:YES];
//}


#pragma mark - 跳转价格表列表页面
//-(void)goPriceList:(NSDictionary *)params{
//    TSHomeCategoryRequest *categoryRequest = [TSHomeCategoryRequest new];
//    [categoryRequest getCategories];
//    TSHybridViewController *controller = [TSWKAppManager currentController:params[@"webview"]];
//    NSDictionary *data = params[@"data"];
//    NSDictionary *paramsDic = data[@"params"];
//    [categoryRequest goToGoodsListPage:paramsDic[@"productLineName"] hotArr:nil controller:controller];
//}

#pragma mark - 跳转赠品
//-(void)goToGift:(NSDictionary *)params{
//    NSDictionary *data = params[@"data"];
//    NSDictionary *paramsDic = data[@"params"];
//    TSGoodDetailGiftActivityController *gift = [[TSGoodDetailGiftActivityController alloc] initWithFarenCode:paramsDic[@"farenCode"]
//                                                                                                  giftHeadId:paramsDic[@"giftHeadId"]
//                                                                                              giftInstanceId:paramsDic[@"giftInstanceId"]
//                                                                                           productFamilyCode:paramsDic[@"productFamilyCode"]
//                                                                                                     skuCode:paramsDic[@"skuCode"]];
//    TSHybridViewController *controller = [TSWKAppManager currentController:params[@"webview"]];
//    [controller.navigationController pushViewController:gift animated:YES];
//}

#pragma mark - 跳转秒杀列表
//-(void)goToSeckill:(NSDictionary *)params{
//    NSDictionary *data = params[@"data"];
//    NSDictionary *param = data[@"params"];
//    TSSeckillDetailController *seckill = [[TSSeckillDetailController alloc] init];
//    seckill.activityId = param[@"activityId"];
//    seckill.partyLayerCode = param[@"partyLayerCode"];
//    TSHybridViewController *controller = [TSWKAppManager currentController:params[@"webview"]];
//    [controller.navigationController pushViewController:seckill animated:YES];
//}
#pragma mark - 跳转套餐列表
//-(void)goToSetMeal:(NSDictionary *)params{
//    NSDictionary *data = params[@"data"];
//    NSDictionary *param = data[@"params"];
//    TSPackageDetailController *package = [[TSPackageDetailController alloc] init];
//    package.activityId = param[@"activityId"];
//    package.partyLayerCode = param[@"partyLayerCode"];
//    TSHybridViewController *controller = [TSWKAppManager currentController:params[@"webview"]];
//    [controller.navigationController pushViewController:package animated:YES];
//}
#pragma mark - 跳转活动详情
//-(void)goToActivityDetail:(NSDictionary *)params{
//    NSDictionary *data = params[@"data"];
//    NSDictionary *param = data[@"params"];
//
//    TSActivityType type = TSWZ;
//    if ([@"MS" isEqualToString:param[@"activityType"]]) {
//        type = TSMS;
//    }else if([@"TC" isEqualToString:param[@"activityType"]]){
//        type = TSTC;
//    }else if([@"TH" isEqualToString:param[@"activityType"]]){
//        type = TSTH;
//    }else if([@"CY" isEqualToString:param[@"activityType"]]){
//        type = TSCY;
//    }
//
//    TSGoodDetailActivityController *seckill = [[TSGoodDetailActivityController alloc] initWithPartyLayerCode:param[@"partyLayerCode"] activityId:param[@"activityId"] goodsCode:param[@"goodsCode"] sku:param[@"sku"] activityType:type];
//    TSHybridViewController *controller = [TSWKAppManager currentController:params[@"webview"]];
//    [controller.navigationController pushViewController:seckill animated:YES];
//}
#pragma mark - 跳转普通详情
//-(void)goToGenaralDetail:(NSDictionary *)params{
//    NSDictionary *data = params[@"data"];
//    NSDictionary *param = data[@"params"];
//    TSGoodsDetailViewController *detail = [[TSGoodsDetailViewController alloc] initWithProductDetailCode:param[@"productDetailCode"] partyLayerCode:param[@"partyLayerCode"] showType:@"活动页"];
//    TSHybridViewController *controller = [TSWKAppManager currentController:params[@"webview"]];
//    [controller.navigationController pushViewController:detail animated:YES];
//}

#pragma mark - 微信分享
//-(void)share:(NSDictionary *)params{
//    TSShareView *share = [[TSShareView alloc] initWithParams:params];
//    [share show];
//}

#pragma mark - 去下单
//-(void)goToOrderPage:(NSDictionary *)params{
//    NSDictionary *data = params[@"data"];
//    NSDictionary *param = data[@"params"];
//    TSLog(@"%@",param);
//   /////////////////////数据组装///////////////////////
//
//    //满减优惠金额分组 key是[mcuuid(活动uuid)], value是[满减优惠金额]
//    //用于保存从采购篮中门店采购传值过来的满减优惠金额分组数据
//    //用于保存客户选中多个满减活动，满减优惠金额分组数据
//    NSMutableDictionary *mapdic = [NSMutableDictionary dictionary];
//    NSMutableArray *tempArray = [NSMutableArray array];
//
//     NSMutableDictionary *mealDic = [NSMutableDictionary dictionary];
//    //OA单号分组: key是[mcuuid(活动uuid)], value是[OA单号]
//    NSMutableDictionary *oAgroupDic = [NSMutableDictionary dictionary];
//
//    //总折扣金额
//    __block CGFloat discountMoney = 0;
//
//    CGFloat fullReductionAmount =  0;
//
//    //满减总折扣金额
//    __block CGFloat MJdiscountMoney = 0;
//
//    //因为有的计算数据需要多次请求结果返回 ，所以这里用到了gcd控制流程
//    dispatch_group_t loadGroup = dispatch_group_create();
//
//    for (NSDictionary *ojc in param[@"orderList"]) {
//
//        fullReductionAmount += [ojc[@"fullReductionMoney"] doubleValue];
//        //保存单个活动数据
//        NSMutableArray *subArray = [NSMutableArray array];
//
//        for (NSDictionary *dic in ojc[@"list"]) {
//            TSPurcherGoodInfo *good = [TSPurcherGoodInfo new];
//            good.volume = [NSString stringWithFormat:@"%@",dic[@"volume"]];
//            good.nowPrice = dic[@"nowPrice"];
//            good.retailLimitPrice = dic[@"referPrice"];
//
//            good.basePrice = dic[@"basePrice"];
//            good.mcuuid = dic[@"mcuuid"];
//            good.productDetailCode = dic[@"productDetailCode"];
//            good.typeUUid = dic[@"typeUuid"];
//            good.outMinUrl = dic[@"img"][@"outMinUrl"];
//            good.discount = [NSString stringWithFormat:@"%@",dic[@"discount"]];
//            good.affix = dic[@"affix"];
//            good.activityId = dic[@"activityId"];
//            good.buyNum = [NSString stringWithFormat:@"%@",dic[@"buyNum"]];
//            good.oaNo =  dic[@"oaNo"];
//            good.detailType = dic[@"detailType"];
//            good.packagesBuyNum = [NSString stringWithFormat:@"%@",dic[@"mealQuantity"]]?:@"1";
//            good.productDetailName = dic[@"productDetailName"];
//            good.productType = dic[@"productType"];
//            good.id = dic[@"id"];
//            good.productSku = dic[@"productSku"];
//            good.skuCode = dic[@"productSku"];
//            good.campaignType = dic[@"campaignType"];
//            good.productModel = dic[@"productModel"];
//            good.priceId = dic[@"priceId"];
//            good.productFamilyCode = dic[@"productFamilyCode"];
//            good.customerFzCode = param[@"agentfzCustomerNo"];
//            good.partyLayerCode = dic[@"partyLayerCode"];
//            good.productSource = ojc[@"type"];
//            good.productSpecName = dic[@"productSpecName"];
//            good.companyCode = param[@"agentCompanyNo"];
//            good.customerNo = param[@"agentCustomerNo"];
////            good.agentType = @"1";
//            good.couponList = params[@"couponList"];
//            good.agentType = @"0";//0是代理商
//            good.hasfullCutMoney = [NSString stringWithFormat:@"%@",ojc[@"fullReductionMoney"]];
//            good.isSelected = YES;
//
//            [tempArray addObject:good];
//            [subArray addObject:good];
//
//            //满减活动数据
//            if([ojc[@"type"] isEqualToString:@"MANJIAN"]||[ojc[@"type"] isEqualToString:@"MANJIANJIAN"]){
//                [mapdic setObject:[NSString stringWithFormat:@"%@",ojc[@"fullReductionMoney"]]  forKey:ojc[@"mcuuid"]];
//
//
//            }else{
//                //非满减条件折扣
//                CGFloat price = good.nowPrice.doubleValue;
//                CGFloat discountPrice = KNumberSave(price *good.discount.doubleValue/100, 2).doubleValue;
//                discountMoney += (price-discountPrice)*good.buyNum.intValue * good.packagesBuyNum.intValue ;
//            };
//
//            //套餐 活动id套数分组 key是[mcuuid(活动uuid)], value是[套数]
//            if([ojc[@"type"] isEqualToString:@"TAOCAN"]){
//                [mealDic setObject:dic[@"mealQuantity"] forKey:ojc[@"mcuuid"]];
//            };
//
//            //OA单号分组: key是[mcuuid(活动uuid)], value是[OA单号]
//            [oAgroupDic setObject:dic[@"oaNo"] forKey:ojc[@"mcuuid"]];
//
//        }
//
//
//        //构建请求满减活动优惠扣率接口参数
//        if ([ojc[@"fullReductionMoney"] doubleValue] > 0) {
//            dispatch_group_enter(loadGroup);
//            ProductToCartList * car = [ProductToCartList new];
//            car.hasfullCutMoney = [NSString stringWithFormat:@"%@",ojc[@"fullReductionMoney"]];
//            car.productToCartList = subArray;
//
//            [TSPurcherGoodInfo calculateManjianDiscountMoneyWith:car discountMoneySucceeed:^(NSString * _Nonnull discountMoney) {
//                for (TSPurcherGoodInfo *g in subArray) {
//                    g.hasDiscountMoney = discountMoney;
//                }
//
//                MJdiscountMoney += discountMoney.doubleValue;
//                dispatch_group_leave(loadGroup);
//
//            } failure:^(NSString * _Nonnull error) {
//                dispatch_group_leave(loadGroup);
//
//            }];
//
//        }
//
//
//
//    }
//
//
//    dispatch_group_notify(loadGroup, dispatch_get_main_queue(), ^{
//        //计算普通折扣金额和满减折扣金额之和
//        discountMoney =  discountMoney + MJdiscountMoney;
//        //算分销订单优惠总金额
//        double totalCouponMoney = 0;
//        for (NSDictionary *ojc in param[@"couponList"]) {
//            //把单张券金额*数目 求和
//            totalCouponMoney += [ojc[@"couponValueFmt"] doubleValue] * [ojc[@"tryUseCount"] intValue];
//        }
//
//
//       /////////////////////
//        TSPlaceAnOrderController *vc = [TSPlaceAnOrderController new];
//    //    TSAgentOrderViewController *vc = [TSAgentOrderViewController new];//新的下单控制器
//        TSHybridViewController *controller = [TSWKAppManager currentController:params[@"webview"]];
//
////        vc.fullReductionAmount = fullReductionAmount;
//    //    vc.fullDiscountStr= [mapdic objectForKey:weakSelf.mcuuidStr];
//    //    //用于保存客户选中多个满减活动，满减优惠金额分组数据
//        vc.fullMap= mapdic; //用于接收保存从采购篮中门店采购传值过来的满减优惠金额分组数据
//    //    //用于保存客户选中套餐活动，活动id套数分组
//        vc.setMealDic=mealDic;//用于接收保存从采购篮中门店采购传值过来的套餐活动分组数据
//        vc.oaNoMapDic=oAgroupDic;//用于接收保存从采购篮中传值过来的OA单号分组数据
////        vc.toltalDiscount = [NSString stringWithFormat:@"%.2f",discountMoney];
//        vc.goods = tempArray;
//        vc.pre_source  = @"活动页";
//
//        orderParams *fxParams = [orderParams new];
//        fxParams.agentCompanyNo = param[@"agentCompanyNo"];
//        fxParams.agentOrderNo = param[@"agentOrderNo"];
//        fxParams.agentCustomerNo = param[@"agentCustomerNo"];
//        fxParams.agentfzCustomerNo = param[@"agentfzCustomerNo"];
//        fxParams.agentPartyLayerCode = param[@"agentPartyLayerCode"];
//        fxParams.totalCouponMoney = [NSString stringWithFormat:@"%.2f",totalCouponMoney];
//        fxParams.dealerOrderIds =param[@"dealerOrderIds"];
//        fxParams.straightType = param[@"straightType"];
//        vc.isFXOrder = YES;
//        vc.fxParams = fxParams;
//
//        //如果直接发给客户，传客户地址
//        if([param[@"type"] intValue] == 2){
//            TSDeliveryAddressModel *model = [TSDeliveryAddressModel new];
//            NSDictionary *addressDic = param[@"addressXb"];
//            model.contactsPhone = addressDic[@"mobile"];
//            model.detailAddress = addressDic[@"address"];
//            model.contacts = addressDic[@"name"];
//            model.addressCode = addressDic[@"addressCode"];
//            model.cityName = addressDic[@"city"];
//            model.cityCode = addressDic[@"cityCode"];
//            model.provinceName = addressDic[@"province"];
//            model.provinceCode = addressDic[@"provinceCode"];
//            model.canNotChange = YES;//发到被代理商地址 不能在下单页修改
//            ///下面两个H5没有就传空
//            model.districtName = addressDic[@"region"]?:@"";
//            model.districtCode = addressDic[@"regionCode"]?:@"";
//            model.canNotChange = YES;
//            vc.FXAddress = model;
//
//        }else{
//            vc.FXAddress = nil;
//        };
//        vc.isUserDirectorDelivery = NO;// 店面采购-NO
//    //    vc.fullReductionAmount=weakSelf.fullTotalAmount;
//        //检查是否有默认地址
//        if ([[TSAddressManager shareManager] checkHaveDefaultAddressWithVC:controller]) {
//            return;
//        }
//
//        [controller.navigationController pushViewController:vc animated:YES];
//        });
//}


#pragma mark - H5领券成功事件  提交神策埋点事件
//- (void)h5GetCoupon:(NSDictionary *)params{
//
//    NSDictionary *paramsDic = params[@"data"][@"params"][@"data"];
//
//    NSDictionary *dic =  @{@"coupon_name":paramsDic[@"coupon_name"],
//                           @"coupon_type":paramsDic[@"coupon_type"],
//                           @"receive_time":paramsDic[@"receive_time"],
//                           @"button_name":@"加购"};
//    [[TSSensorsAnalyticsManager shareSensorsManager]appCouponUseClickEvtn:dic
//                                                                 showType:@"CouponAddCarClick"];
//}

#pragma mark - H5领券成功事件    提交神策埋点事件
//- (void)h5UseCoupon:(NSDictionary *)params{
//    NSDictionary *paramsDic = params[@"data"][@"params"][@"data"];
//
//    NSDictionary *dic =  @{@"coupon_name":paramsDic[@"coupon_name"],
//                           @"coupon_type":paramsDic[@"coupon_type"],
//                           @"receive_time":paramsDic[@"receive_time"],
//                           @"button_name":@"去使用"};
//    [[TSSensorsAnalyticsManager shareSensorsManager]appCouponUseClickEvtn:dic
//                                                                 showType:@"CouponUseClick"];
//
//}

#pragma mark - 更新购物车列表

//- (void)updateCartList:(NSDictionary *)params{
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"KChangeCartStateNotification" object:nil];
//}


#pragma mark - 登出
//-(void)logOut:(NSDictionary *)params{
//
//    [[TSCookiesManager defaultManager] analysisCookiesStr:@""];
//
//    [TSLoginViewController showLoginSuccess:^(BOOL loginStatus) {
//        [(AppDelegate *)[UIApplication sharedApplication].delegate showWithAccountStatus];
//    }];
//}

#pragma mark - 更新用户信息
//-(void)updateUserInfo:(NSDictionary *)params{
//    [[TSUserInfoManager shareManager] updateUserInfo:^(BOOL isValideAccount) {
//    }];
//}

//-(void)showLoading:(NSDictionary *)params{
//    [TSToast showLoading:@"正在加载中..."];
//}
//
//-(void)dismissLoading:(NSDictionary *)params{
//    [TSToast dismiss];
//}


@end

