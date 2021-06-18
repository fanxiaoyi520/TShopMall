//
//  TSAddressMarkView.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSAddressMarkView : UIView
@property (nonatomic, strong) NSArray *marks;

//新添加的标签
@property (nonatomic, copy) NSString *newMark;
@end

NS_ASSUME_NONNULL_END
