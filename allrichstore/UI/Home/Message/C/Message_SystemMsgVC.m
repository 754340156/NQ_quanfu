//
//  Message_SystemMsgVC.m
//  allrichstore
//
//  Created by 任强宾 on 16/11/15.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "Message_SystemMsgVC.h"         //系统消息
#import "SysytemMsgCell.h"              //系统消息cell
#import "Message_SystemMsgDetailVC.h"   //系统消息详情页面

@interface Message_SystemMsgVC ()

@end

@implementation Message_SystemMsgVC

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
    
    self.tableView.insets = UIEdgeInsetsMake(64 + LightAdapted(50), 0, 0, 0);
    [_tableView registerClass:[SysytemMsgCell class] forCellReuseIdentifier:[SysytemMsgCell className]];
    [_tableView setRefreshHeader:self.refreshHeader];
    [_tableView setRefreshFooter:self.refreshFooter];
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

#pragma mark - <UITableViewDataSource>
//设置组数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//设置每组的行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 10;
}

//返回cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SysytemMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:[SysytemMsgCell className] forIndexPath:indexPath];
    cell.imgView.image = ImageStr(@"login_password");
    cell.titleLabel.text = @"通知消息";
    cell.contentLabel.text = @"恭喜您使用微信登录成功，绑定手机号码之后即可正常使用";
    NSDate *date = [NSDate date];
    cell.timeLabel.text = [date minuteDescription];
    return cell;
}

#pragma mark - <UITableViewDelegate>
//cell被选中时触发
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    //系统消息详情
    Message_SystemMsgDetailVC *msgDetailVC = [Message_SystemMsgDetailVC new];
    [self.navigationController pushVC:msgDetailVC animated:YES];
}

//设置cell行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [SysytemMsgCell cellHeight];
}

#pragma mark - dealloc
- (void)dealloc
{
    
}

@end
