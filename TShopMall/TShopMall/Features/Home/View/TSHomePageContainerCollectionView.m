//
//  TSHomePageContainerCollectionView.m
//  TShopMall
//
//  Created by sway on 2021/6/15.
//

#import "TSHomePageContainerCollectionView.h"

@implementation TSHomePageContainerCollectionView
#pragma mark - <YBNestContentProtocol>

@synthesize yb_scrollViewDidScroll = _yb_scrollViewDidScroll;

- (UIView *)yb_contentView {
    return self;
}

- (UIScrollView *)yb_contentScrollView {
    return self.collectionView;
}

- (void)yb_contentWillAppear {
}

- (void)yb_contentDidDisappear {
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.yb_scrollViewDidScroll(scrollView);
}
@end
