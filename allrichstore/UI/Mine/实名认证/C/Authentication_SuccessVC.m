//
//  Authentication_SuccessVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/9.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "Authentication_SuccessVC.h"
#import "Authentication_SuccessCell.h"
@interface Authentication_SuccessVC ()

@end

@implementation Authentication_SuccessVC

#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    [super configParams];
    self.listArray = @[@{@"title":String(@"真实姓名"),
                         @"subTitle":@"*铭"},
                       @{@"title":String(@"身份证"),
                         @"subTitle":@"412721********8990"},
                       @{@"title":String(@"证件信息"),
                         @"subTitle":@"认证通过"}].mutableCopy;
    
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
    [self.tableView registerClass:[Authentication_SuccessCell class] forCellReuseIdentifier:[Authentication_SuccessCell className]];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) return 1;
    return self.listArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NSString *identifier = @"identifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            UILabel *label = [[UILabel alloc] init];
            label.textColor =QF_BlackColor;
            label.text = String(@"您已通过认证");
            [label sizeToFit];
            [cell.contentView addSubview:label];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.equalTo(cell.mas_centerY);
                make.centerX.equalTo(cell.mas_centerX);
            }];
        }
        return cell;
    }else
    {
        Authentication_SuccessCell *cell = [tableView dequeueReusableCellWithIdentifier:[Authentication_SuccessCell className]];
        cell.title = self.listArray[indexPath.row][@"title"];
        cell.subTitle = self.listArray[indexPath.row][@"subTitle"];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) return Adapted(140);
    return kBottomH;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return  kFooterViewH;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenW, kFooterViewH)];
    view.backgroundColor = QFColor_CoodsClassMenuViewBg;
    return view;
}
#pragma mark - dealloc
- (void)dealloc
{
    
}


@end
