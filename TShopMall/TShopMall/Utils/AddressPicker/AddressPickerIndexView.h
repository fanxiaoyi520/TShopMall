//
//  AddressPickerIndexView.h
//  TCLPlus
//
//  Created by kobe on 2020/10/30.
//  Copyright © 2020 TCL Electronics Holdings Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class AddressPickerIndexView;

typedef void (^AddressPickerIndexBlock)(NSInteger index);
@protocol AddressPickerIndexViewDelegate <NSObject>

- (void)addressPickerIndexView:(AddressPickerIndexView *)indexView
              didSelectedIndex:(NSInteger)index
                    completion:(void (^)(NSInteger lastSelectedIndex))completion;
@end


@interface AddressPickerIndexView : UIView

@property (nonatomic, strong, nullable) NSArray *dataSource;
@property (nonatomic, copy, nullable) AddressPickerIndexBlock indexBlock;
@property (nonatomic, weak, nullable) id<AddressPickerIndexViewDelegate> delegate;

- (void)updateSelectedIndex:(NSInteger)index;
- (void)dismissIndicator;

@end

NS_ASSUME_NONNULL_END
