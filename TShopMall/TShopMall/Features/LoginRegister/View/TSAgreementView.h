//
//  TSAgreementView.h
//  TShopMall
//
//  Created by edy on 2021/6/25.
//

#import <UIKit/UIKit.h>
#import "TSUniversalSectionModel.h"
#import "TSUniversaItemModel.h"
#import "TSBaseDataController.h"
#import "TSUniversalCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@class TSAgreementSectionItemModel, TSAgreementSectionModel;

@interface TSAgreementSectionModel : TSUniversalSectionModel
/** items  */
@property(nonatomic, strong) NSMutableArray<TSAgreementSectionItemModel *> *items;

@end

@interface TSAgreementSectionItemModel : TSUniversaItemModel
/** 内容  */
@property(nonatomic, copy) NSString *content;

@end

@interface TSAgreementView : UIView

- (instancetype)initWithTitle:(NSString *)title;

+ (instancetype)agreementViewWithTitle:(NSString *)title;

- (void)show;

@end

@interface TSAgreementCell : TSUniversalCollectionViewCell


@end

@interface TSAgreementDataController : TSBaseDataController
/** sections  */
@property(nonatomic, strong, readonly) NSMutableArray<TSAgreementSectionModel *> *sections;

- (void)fetchAgreementContentsComplete:(void(^)(BOOL isSucess))complete;

@end

NS_ASSUME_NONNULL_END
