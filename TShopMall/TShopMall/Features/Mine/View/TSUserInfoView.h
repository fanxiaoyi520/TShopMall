//
//  TSUserInfoView.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/11.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,TSRoleType){
    TSRoleTypeUnLogin,  //未登录
    TSRoleTypePlatinum, //铂金合伙人
    TSRoleTypeJewel     //钻石合伙人
};

NS_ASSUME_NONNULL_BEGIN

@interface TSUserInfoView : UIView

-(instancetype)initWithRoleType:(TSRoleType)type;

@end

NS_ASSUME_NONNULL_END
