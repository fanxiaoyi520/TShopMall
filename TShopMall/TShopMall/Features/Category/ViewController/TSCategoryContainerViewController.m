//
//  TSCategoryContainerViewController.m
//  TShopMall
//
//  Created by  on 2021/6/29.
//

#import "TSCategoryContainerViewController.h"

@interface TSCategoryContainerViewController ()
@property (nonatomic, strong) NSMutableArray <UIView*> *containers;
@end

@implementation TSCategoryContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self hiddenNavigationBar];
    
}

- (void)setDataSource:(id<TSCategoryContainerDataSource>)dataSource{
    _dataSource = dataSource;
    if (_dataSource && [_dataSource respondsToSelector:@selector(numberOfContentsInContainerView:)]) {
        NSInteger count = [_dataSource numberOfContentsInContainerView:self];
        for (int i = 0; i < count; i ++) {
            if (_dataSource && [_dataSource respondsToSelector:@selector(viewForContainerViewController:currentPage:)]) {
                UIView *view = [_dataSource viewForContainerViewController:self currentPage:i];
//                [self.view addSubview:view];
                [self.containers addObject:view];
                
            }
        }
    }
}

- (void)showContentAtPage:(NSInteger)page{
    if (self.containers.count) {
        [self.view removeAllSubviews];
        
        UIView *view = self.containers[page];
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
    }
   
}

- (NSMutableArray *)containers{
    if (!_containers) {
        _containers = [NSMutableArray array];
    }
    return _containers;
}

@end
