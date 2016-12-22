//
//  Message_SystemMsgDetailVC.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/15.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "Message_SystemMsgDetailVC.h"   //系统消息详情页面
#import "SystemMsgDetailsCell.h"        //系统消息详情cell

@interface Message_SystemMsgDetailVC ()

@end

@implementation Message_SystemMsgDetailVC

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
    self.title = String(@"消息");
}

//添加views（继承重写）
- (void)addOwnViews
{
    [super addOwnViews];
    [self.tableView registerClass:[SystemMsgDetailsCell class] forCellReuseIdentifier:[SystemMsgDetailsCell className]];
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
    
}

#pragma mark - custom method


#pragma mark - handle action

#pragma mark - <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SystemMsgDetailsCell *cell = [tableView dequeueReusableCellWithIdentifier:[SystemMsgDetailsCell className] forIndexPath:indexPath];
#warning  假数据。。。
    cell.imgView.image = ImageStr(@"login_password");
    cell.titleLabel.text = @"消息标题";
    cell.timeLabel.text = @"2016-08-06";
    cell.contentLabel.text = @"消息内容消息内容消息内容消息内容消消息内容消息内容消息内容消息内容消息内容消息内容消息内容消息内容消消息内容消息内容消息内容消息内容消息内容消息内容消息内容消息内容消消息内容消息内容消息内容消息内容消息内容消息内容消息内容消息内容消消息内容消息内容消息内容消息内容消息内容消息内容消息内容消息内容消消息内容消息内容消息内容消息内容消息内容消息内容消息内容消息内容消消息内容消息内容消息内容消息内容";
    return cell;
}

#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return [tableView fd_heightForCellWithIdentifier:[SystemMsgDetailsCell className] cacheByIndexPath:indexPath configuration:^(SystemMsgDetailsCell* cell) {
        
        cell.imgView.image = ImageStr(@"login_password");
        cell.titleLabel.text = @"消息标题";
        cell.timeLabel.text = @"2016-08-06";
        cell.contentLabel.text = @"消息内容消息内容消息内容消息内容消消息内容消息内容消息内容消息内容消息内容消息内容消息内容消息内容消消息内容消息内容消息内容消息内容消息内容消息内容消息内容消息内容消消息内容消息内容消息内容消息内容消息内容消息内容消息内容消息内容消消息内容消息内容消息内容消息内容消息内容消息内容消息内容消息内容消消息内容消息内容消息内容消息内容消息内容消息内容消息内容消息内容消消息内容消息内容消息内容消息内容";
    }];
}

#pragma mark - dealloc
- (void)dealloc
{
    
}

@end
