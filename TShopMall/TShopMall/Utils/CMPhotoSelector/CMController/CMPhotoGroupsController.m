//
//  CMGroupsViewController.m
//  CMToolDemo
//
//  Created by Joehuitan on 2018/1/18.
//  Copyright © 2018年 chinaMobile. All rights reserved.
//

#import "CMPhotoGroupsController.h"
#import "CMPhotoGroupsViewModel.h"
#import "CMPhotoGroupsCell.h"
#import "CMPhotoGroup.h"
#import "CMPhotoImagesController.h"
#import "CMPhotoImageFlowLayout.h"

@interface CMPhotoGroupsController ()
/** 数据源 */
@property (nonatomic, strong) NSArray<CMPhotoGroup *> *dataSource;

@end

@implementation CMPhotoGroupsController

#pragma mark - Load On Demand Method

#pragma mark - On Click Actions Method
- (void)cancelOnClick {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Setter Method

#pragma mark - Public Method

#pragma mark - Life Cycle Method

- (void)viewDidLoad
{
    [super viewDidLoad];
    ///初始化操作
    [self setUpInit];
}

#pragma mark - UITableViewDataSource Method

static NSString *cellIndentifier = @"CMPhotoGroupsCell_Identifier";

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CMPhotoGroup *photoGroup = [self.dataSource objectAtIndex:indexPath.row];
    CMPhotoGroupsCell *cell = (CMPhotoGroupsCell *)[tableView dequeueReusableCellWithIdentifier:cellIndentifier];
    if (cell == nil) {
        cell = [[CMPhotoGroupsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentifier];
    }
    cell.photoGroup = photoGroup;
    return cell;
}

#pragma mark - UITableViewDelegate Method

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CMPhotoGroup *photoGroup = [self.dataSource objectAtIndex:indexPath.row];
    CMPhotoImagesController *photoImagesController = [[CMPhotoImagesController alloc] initWithCollectionViewLayout:[[CMPhotoImageFlowLayout alloc] init]];
    photoImagesController.maxCount = self.maxCount;
    photoImagesController.multiSelection = self.isMultiSelection;
    photoImagesController.dataSource = photoGroup.photoALAssets;
    [self.navigationController pushViewController:photoImagesController animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

#pragma mark - Private Method
/**
 * 初始化操作
 */
- (void)setUpInit {
    self.title = @"照片";
    self.tableView.tableFooterView = [[UIView alloc] init];
    ///注册cell
    [self.tableView registerClass:[CMPhotoGroupsCell class] forCellReuseIdentifier:cellIndentifier];
    self.tableView.separatorInset = UIEdgeInsetsMake(0, 80, 0, 0);
    ///设置导航栏右侧的按钮，即取消按钮
    [self setUpCancelBtn];
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [[CMPhotoGroupsViewModel sharedCMPhotoGroupsViewModel] getAllPhotoGroupsWithCompletedBlock:^(NSArray<CMPhotoGroup *> *dataSource) {
            self.dataSource = dataSource;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
        } unAuthorizedStatus:^{
            
        }];
    });
}
/**
 * 设置导航栏右侧的按钮，即取消按钮
 */
- (void)setUpCancelBtn {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancelOnClick)];
}

@end
