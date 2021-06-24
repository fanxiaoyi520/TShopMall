//
//  AddressPickerCell.h
//  TCLPlus
//
//  Created by kobe on 2020/8/24.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface AddressPickerCell : UITableViewCell

@property (nonatomic, copy, nullable) NSString *nameText;
@property (nonatomic, copy, nullable) NSString *indexText;
@property (nonatomic, assign) BOOL hiddenIndexLab;
@property (nonatomic, assign) BOOL hiddenBottomLine;
@property (nonatomic, assign) BOOL selectedLetter;

@end

NS_ASSUME_NONNULL_END
