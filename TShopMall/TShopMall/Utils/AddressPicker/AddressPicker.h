//
//  AddressPicker.h
//  TCLPlus
//
//  Created by kobe on 2020/8/24.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef enum : NSUInteger {
    AddressPickerTypeNormal,
    AddressPickerTypeIot,
} AddressPickerType;

typedef void (^AddressPickerBlock)(NSDictionary *Info);


@interface AddressPicker : UIView

- (instancetype)initWithPickerType:(AddressPickerType)type;

- (void)show;
- (void)dismiss;
@property (nonatomic, copy, nullable) AddressPickerBlock addressPickerBlock;
@property (nonatomic, assign) AddressPickerType pickType;

@end

NS_ASSUME_NONNULL_END
