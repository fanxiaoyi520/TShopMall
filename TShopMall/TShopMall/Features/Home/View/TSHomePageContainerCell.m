//
//  TSHomePageContainerCell.m
//  TShopMall
//
//  Created by 陈结 on 2021/6/8.
//

#import "TSHomePageContainerCell.h"
#import "TSHomePageContainerViewModel.h"
@interface TSHomePageContainerCell()<UIScrollViewDelegate>
@property(nonatomic, strong) TSHomePageContainerViewModel *containerViewModel;

@end
@implementation TSHomePageContainerCell
- (void)dealloc
{
    
}
- (void)setupUI{
    [self.contentView addSubview:self.containerScrollView];
    [self.containerScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
}

- (void)setViewModel:(TSHomePageCellViewModel *)viewModel{
    [super setViewModel:viewModel];
    self.containerViewModel = (TSHomePageContainerViewModel *)viewModel;
    if (self.containerScrollView.collectionViewGroup.count == 0) {
        [self.containerScrollView loadPageContainer:self.containerViewModel.segmentHeaderDatas.count];
    }
    
    if (self.containerViewModel.currentGroup) {
        NSInteger currentIndex = [self.containerViewModel.segmentHeaderDatas indexOfObject:self.containerViewModel.currentGroup];
        
        NSArray *items = self.containerViewModel.currentGroup.list;
        if (items.count) {
            [self.containerScrollView updatePageContainerWithItems:items pageIndex:currentIndex];
            [self.containerScrollView layoutIfNeeded];
            [self.containerScrollView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.equalTo(@(self.containerScrollView.contentSize.height));
            }];
//            [self tableviewReloadCell];
            
            [self.containerScrollView setContentOffset:CGPointMake(kScreenWidth * currentIndex, 0)];
            self.containerScrollView.currentPage = currentIndex;
        }
    }
    
}

- (TSHomePageContainerScrollView *)containerScrollView{
    if (!_containerScrollView) {
        _containerScrollView = [[TSHomePageContainerScrollView alloc] init];
        _containerScrollView.delegate = self;
    }
    return _containerScrollView;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    BOOL scrollToScrollStop = !scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
    if (scrollToScrollStop) {
        // 停止后要执行的代码
        
        int currentPage = floor((scrollView.contentOffset.x - kScreenWidth / 2) / kScreenWidth) + 1;
        NSLog(@"currentPage %ld",currentPage);
        if (scrollView == self.containerScrollView) {
            if (currentPage != self.containerScrollView.currentPage) {
                self.containerScrollView.pageIndex = currentPage;
            }else{
                NSLog(@"no currentPage");
            }
            
            //        self.containerViewModel.currentGroup = self.containerViewModel.segmentHeaderDatas[currentPage];
        }else{
            NSLog(@"no ");
        }
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!decelerate) {
        BOOL dragToDragStop = scrollView.tracking && !scrollView.dragging && !scrollView.decelerating;
        if (dragToDragStop) {
            // 停止后要执行的代码
            
            int currentPage = floor((scrollView.contentOffset.x - kScreenWidth / 2) / kScreenWidth) + 1;
            NSLog(@"currentPage %ld",currentPage);
            if (scrollView == self.containerScrollView) {
                if (currentPage != self.containerScrollView.currentPage) {
                    self.containerScrollView.currentPage = currentPage;
                }else{
                    NSLog(@"no currentPage");
                }
                
                //        self.containerViewModel.currentGroup = self.containerViewModel.segmentHeaderDatas[currentPage];
            }else{
                NSLog(@"no ");
            }
        }
    }
}

@end

