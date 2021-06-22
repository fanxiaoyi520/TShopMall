//
//  TSSearchResultNaviView.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/21.
//

#import <UIKit/UIKit.h>
#import "TSSearchTextView.h"

@interface TSSearchResultNaviView : UIView
@property (nonatomic, strong) UIButton *backBtn;
@property (nonatomic, strong) TSSearchTextView *searchView;
@property (nonatomic, strong) UIButton *typeBtn;
@end

