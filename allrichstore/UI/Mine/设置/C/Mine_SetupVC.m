//
//  Mine_SetupVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/10.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "Mine_SetupVC.h"
#import "MBProgressHUD+MP.h"
#import "Mine_SetupCell.h"
#import "Mine_SetupAboutVC.h"
#import "Mine_SetupUpdateVC.h"

@interface Mine_SetupVC ()
/**  退出登录 */
@property(nonatomic,strong) UIButton * exitButton;
@end

@implementation Mine_SetupVC

#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    [super configParams];
    self.listArray = @[String(@"清理缓存"),String(@"检查更新"),String(@"关于我们")].mutableCopy;
}

//配置容器类（继承重写）
- (void)configContainer
{
    [super configContainer];
    
}

//添加views（继承重写）
- (void)addOwnViews
{
    [super addOwnViews];
    [self.view addSubview:self.tableView];
    self.tableView.backgroundColor = QFColor_CoodsClassMenuViewBg;
    [self.tableView registerClass:[Mine_SetupCell class] forCellReuseIdentifier:[Mine_SetupCell className]];
    //如果登录状态显示退出登录按钮
    if ([Single isLogin]) {
        [self.view addSubview:self.exitButton];
        self.exitButton.height -= kBottomH;
        [self.exitButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.left.right.offset(0);
            make.height.offset(kBottomH);
        }];
    }

}

//配置,布局views（继承重写）
- (void)configOwnViews
{
    [super configOwnViews];
    
}

#pragma mark - request data
//请求列表数据 (替换重写)
- (void)requestListDataAnimation:(BOOL)animated
{
    NSDictionary *parameters = @{@"":@"", @"":@""};
    WS(weakSelf)
    [self POST:self.listUrl parameters:parameters success:^(NSDictionary *dic) {
        
    } fail:^(NSError *error) {
        
        
    } sendView:nil animSuperView:self.view animated:YES];
}

#pragma mark - custom method
/**  计算缓存 */
- (CGFloat)getDiskSize
{
    NSInteger size = 0;
    NSString *libPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
    NSFileManager *mgr = [NSFileManager defaultManager];
    NSArray *libSubpaths = [mgr subpathsAtPath:libPath];
    for ( NSString *str in libSubpaths) {
        if (![str containsString:@"Preferences"]) {
            NSString *path  =[libPath stringByAppendingPathComponent:str];
            NSDictionary *strAttr = [mgr attributesOfItemAtPath:path error:nil];
            size  = size +[strAttr[@"NSFileSize"] integerValue];
        }
    }
    return size / 1024.0 / 1024.0 ;
}
/**  清除缓存 */
- (void)clearDisk
{
    NSString *libPath = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)[0];
    NSFileManager *mgr = [NSFileManager defaultManager];
    NSArray *libSubpaths = [mgr subpathsAtPath:libPath];
    for ( NSString *str in libSubpaths) {
        if (![str containsString:@"Preferences"]) {
            NSString *path  =[libPath stringByAppendingPathComponent:str];
            [mgr removeItemAtPath:path error:nil];
        }
    }
}

#pragma mark - handle action
- (void)exitAction
{
    //退出并跳转
}
#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Mine_SetupCell *cell = [tableView dequeueReusableCellWithIdentifier:[Mine_SetupCell className]];
    cell.titleName = self.listArray[indexPath.row];
    if (!indexPath.row)
    {
        cell.cacheSize = @"00.0M";
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            CGFloat diskSize = [self getDiskSize];
            dispatch_async(dispatch_get_main_queue(), ^{
                cell.cacheSize = [NSString stringWithFormat:@"%.1lfM",diskSize] ;
            });
        });
    }
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    switch (indexPath.row) {
        case 0:
        {
            [MBProgressHUD showMessage:String(@"清除缓存中...") ToView:self.view];
            [self clearDisk];
            [MBProgressHUD hideHUDForView:self.view];
            [self.tableView reloadData];
        }
            break;
        case 1:
        {
            Mine_SetupUpdateVC *updateVC = [[Mine_SetupUpdateVC alloc] init];
            [self.navigationController pushVC:updateVC animated:YES];
        }
            break;
        case 2:
        {
            Mine_SetupAboutVC *aboutVC = [[Mine_SetupAboutVC alloc] init];
            [self.navigationController pushVC:aboutVC animated:YES];
        }
            break;
            
    }
}
#pragma mark - Setter Model
- (UIButton *)exitButton
{
    if (!_exitButton) {
        _exitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_exitButton setTitle:String(@"退出登录") forState:UIControlStateNormal];
        [_exitButton addTarget:self action:@selector(exitAction) forControlEvents:UIControlEventTouchUpInside];
        [_exitButton setTitleColor:kWhiteColor forState:UIControlStateNormal];
        [_exitButton setBackgroundImage:[UIImage imageWithColor:kRedColor] forState:UIControlStateNormal];
    }
    return _exitButton;
}
#pragma mark - dealloc
- (void)dealloc
{
    
}


@end
