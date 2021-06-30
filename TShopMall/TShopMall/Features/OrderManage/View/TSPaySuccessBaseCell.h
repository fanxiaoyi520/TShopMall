//
//  TSPaySuccessBaseCell.h
//  TShopMall
//
//  Created by 橙子 on 2021/6/28.
//

#import "TSUniversalCollectionViewCell.h"

@protocol TSPaySucceddCellDelegate <NSObject>

- (void)backToHome;
- (void)goToOrderDetail;
- (void)recomendGoodsTapped:(NSString *)uuid;
@end

@interface TSPaySuccessBaseCell : TSUniversalCollectionViewCell
@property (nonatomic, strong) id obj;
@property (nonatomic, weak) id<TSPaySucceddCellDelegate> theDelegate;
@end


