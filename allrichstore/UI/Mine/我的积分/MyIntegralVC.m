//
//  MyIntegralVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/8.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "MyIntegralVC.h"
#import "MyIntegralCell.h"
#import "MyintegralModel.h"
#define kHeaderViewH 40.0f

@interface MyIntegralVC ()
/**  model */
@property(nonatomic,strong) MyintegralModel * model;
@end

@implementation MyIntegralVC

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
    self.tableView.frame = self.view.bounds;
    self.tableView.backgroundColor = QFColor_CoodsClassMenuViewBg;
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[MyIntegralCell class] forCellReuseIdentifier:[MyIntegralCell className]];
    
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
    NSDictionary *parameters = @{@"userId":[Single getUserModel].ID};
    WS(weakSelf)
    [self POST:API_MyIntegral parameters:parameters success:^(NSDictionary *dic) {
        weakSelf.listArray = [MyintegralModel mj_objectArrayWithKeyValuesArray:dic[@"response"]];
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
    if (section == 0 ) return 1;
    return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        NSString *identifier = @"identifier";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.textLabel.text = String(@"当前积分");
        cell.textLabel.font = Font_Mid;
        cell.textLabel.textColor = QF_BlackColor;
        UILabel *subTitleLabel = [[UILabel alloc] init];
        subTitleLabel.textColor = QF_BlackColor;
        subTitleLabel.font = Font_Mid;
        [subTitleLabel sizeToFit];
        subTitleLabel.text = [Single getUserModel].uIntegral;
        [cell.contentView addSubview:subTitleLabel];
        [subTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(cell.mas_centerY);
            make.right.offset(-kMargin);
        }];
        return cell;
    }
    MyIntegralCell *cell = [tableView dequeueReusableCellWithIdentifier:[MyIntegralCell className]];
    cell.model = self.listArray[indexPath.row];
    return cell;

}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return kBottomH;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return kHeaderViewH;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *headerLabel= [[UILabel alloc] initWithFrame:CGRectMake(kMargin, kMargin, kScreenW, kHeaderViewH)];
    headerLabel.text = String(@"    收支明细");
    [headerLabel sizeToFit];
    headerLabel.font = Font_Min;
    headerLabel.textColor = QF_GrayColor;
    return headerLabel;
}
#pragma mark - lazy

#pragma mark - dealloc
- (void)dealloc
{
    
}


@end
