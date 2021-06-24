//
//  AddressHeaderView.h
//  TCLPlus
//
//  Created by xl007 on 2020/11/2.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface AddressHeaderView : UIView

@property (strong, nonatomic) UILabel *tipLab;
@property (strong, nonatomic) UIButton *cancelBtn;
@property (strong, nonatomic) UIImageView *locIcon;
@property (strong, nonatomic) UILabel *locName;
@property (strong, nonatomic) UIView *locView;


@property (strong, nonatomic, nullable) NSError *locationError;
@property (strong, nonatomic) NSDictionary *locDic;

@end

NS_ASSUME_NONNULL_END
