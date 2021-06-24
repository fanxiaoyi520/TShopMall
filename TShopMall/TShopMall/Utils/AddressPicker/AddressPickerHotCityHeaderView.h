//
//  AddressPickerHotCityHeaderView.h
//  TCLPlus
//
//  Created by kobe on 2020/11/9.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class AddressPickerHotCityItemModel;
typedef void (^AddressPickerHotCityBlock)(AddressPickerHotCityItemModel *model);


@interface AddressPickerHotCityHeaderView : UITableViewHeaderFooterView

@property (nonatomic, copy, nullable) AddressPickerHotCityBlock hotCityBlock;

@end

NS_ASSUME_NONNULL_END
