//
//  TSUserInfoView.h
//  TShopMall
//
//  Created by 陈结 on 2021/6/11.
//

#import <UIKit/UIKit.h>
#import "TSMineMerchantUserInformationModel.h"

typedef NS_ENUM(NSUInteger,TSRoleType){
    TSRoleTypeUnLogin,  //未登录
    TSRoleTypePlatinum, //铂金合伙人
    TSRoleTypeJewel     //钻石合伙人
};

NS_ASSUME_NONNULL_BEGIN

@protocol TSUserInfoViewDelegate <NSObject>

@optional
-(void)userInfoLoginAction:(id _Nullable)sender;
-(void)userInfoSeeCodeAction:(id _Nullable)sender;
- (void)userInfoKCopyCodeAction:(id _Nullable)sender;
@end

@interface TSUserInfoView : UIView

@property (nonatomic ,assign)id <TSUserInfoViewDelegate> kDelegate;
//-(instancetype)initWithRoleType:(TSRoleType)type;
@property(nonatomic,strong) TSMineMerchantUserInformationModel *model; 
@end

NS_ASSUME_NONNULL_END
