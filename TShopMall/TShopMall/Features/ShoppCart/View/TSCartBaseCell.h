//
//  TSCartBaseCell.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/9.
//

#import <UIKit/UIKit.h>
#import "TSCartProtocol.h"

@interface TSCartBaseCell : UITableViewCell
@property (nonatomic, strong) id obj;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, weak) id<TSCartProtocol> delegate;
- (void)layoutView;
- (void)testUI;
@end

