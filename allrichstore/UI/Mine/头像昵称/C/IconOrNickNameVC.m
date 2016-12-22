//
//  IconOrNickNameVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/12/2.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "IconOrNickNameVC.h"
#import "Person_TFCell.h"
#import "Person_PhotoCell.h"
@interface IconOrNickNameVC ()

@end

@implementation IconOrNickNameVC

#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    [super configParams];
    
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
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = QFColor_CoodsClassMenuViewBg;
    [self.tableView registerClass:[Person_PhotoCell class] forCellReuseIdentifier:[Person_PhotoCell className]];
    [self.tableView registerClass:[Person_TFCell class] forCellReuseIdentifier:[Person_TFCell className]];
    [self.view addSubview:_tableView];
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


#pragma mark - handle action

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row) {
        Person_PhotoCell * cell = [tableView dequeueReusableCellWithIdentifier:[Person_TFCell className]];
//        [cell configTitle:@"头像" imageUrl:[Single getUserModel].u_headimage];
        return cell;
    }else
    {
        Person_TFCell *cell = [tableView dequeueReusableCellWithIdentifier:[Person_TFCell className]];
//        [cell configTitle:@"昵称" tfText:[Single getUserModel].u_nickname];
        return  cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row ? 50 : 80;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - dealloc
- (void)dealloc
{
    
}


@end
