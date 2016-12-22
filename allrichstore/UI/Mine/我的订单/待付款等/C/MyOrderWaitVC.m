//
//  MyOrderWaitVC.m
//  allrichstore
//
//  Created by zhaozhe on 16/11/11.
//  Copyright © 2016年 allrich88. All rights reserved.
//

#import "MyOrderWaitVC.h"
#import "SendCommentVC.h" //发表评论
#import "MyOrderListCell.h"
#import "MyOrderListModel.h"
#import "MyOrderDetailVC.h"
@interface MyOrderWaitVC ()<MyOrderListCellDelegate>

@end

@implementation MyOrderWaitVC

#pragma mark - SubClass Override
//配置初始化的参数（继承重写）
- (void)configParams
{
    [super configParams];
    NSArray *array = @[@{@"shopName":@"柏杨九天",
                         @"shopIcon":@"jingxuan_icon",
                         @"goodsStatus":@"买家已付款",
                         @"buttonArray":@[],
                         @"goods":@[@{@"icon":@"jingxuan_cover",
                                      @"title":@"秋装新款简约百搭圆领衬衫 纯色打底衬衫女",
                                      @"subTitle1":@"颜色分类：白色",
                                      @"subTitle2":@"尺寸：S码",
                                      @"price":@"218.00",
                                      @"count":@"1"}]},
                       @{@"shopName":@"柏杨九天",
                         @"shopIcon":@"jingxuan_icon",
                         @"goodsStatus":@"买家已付款",
                         @"buttonArray":@[@"评价"],
                         @"goods":@[@{@"icon":@"jingxuan_cover",
                                      @"title":@"秋装新款简约百搭圆领衬衫 纯色打底衬衫女",
                                      @"subTitle1":@"颜色分类：白色",
                                      @"subTitle2":@"尺寸：S码",
                                      @"price":@"218.00",
                                      @"count":@"1"},
                                    @{@"icon":@"jingxuan_cover",
                                      @"title":@"秋装新款简约百搭圆领衬衫 纯色打底衬衫女",
                                      @"subTitle1":@"颜色分类：白色",
                                      @"subTitle2":@"尺寸：S码",
                                      @"price":@"218.00",
                                      @"count":@"1"},
                                    @{@"icon":@"jingxuan_cover",
                                      @"title":@"秋装新款简约百搭圆领衬衫 纯色打底衬衫女",
                                      @"subTitle1":@"颜色分类：白色",
                                      @"subTitle2":@"尺寸：S码",
                                      @"price":@"218.00",
                                      @"count":@"1"}]},
                       @{@"shopName":@"柏杨九天",
                         @"shopIcon":@"jingxuan_icon",
                         @"goodsStatus":@"买家已付款",
                         @"buttonArray":@[],
                         @"goods":@[@{@"icon":@"jingxuan_cover",
                                      @"title":@"秋装新款简约百搭圆领衬衫 纯色打底衬衫女",
                                      @"subTitle1":@"颜色分类：白色",
                                      @"subTitle2":@"尺寸：S码",
                                      @"price":@"218.00",
                                      @"count":@"1"},
                                    @{@"icon":@"jingxuan_cover",
                                      @"title":@"秋装新款简约百搭圆领衬衫 纯色打底衬衫女",
                                      @"subTitle1":@"颜色分类：白色",
                                      @"subTitle2":@"尺寸：S码",
                                      @"price":@"218.00",
                                      @"count":@"1"}]},
                       @{@"shopName":@"柏杨九天",
                         @"shopIcon":@"jingxuan_icon",
                         @"goodsStatus":@"买家已付款",
                         @"buttonArray":@[],
                         @"goods":@[@{@"icon":@"jingxuan_cover",
                                      @"title":@"秋装新款简约百搭圆领衬衫 纯色打底衬衫女",
                                      @"subTitle1":@"颜色分类：白色",
                                      @"subTitle2":@"尺寸：S码",
                                      @"price":@"218.00",
                                      @"count":@"1"}]}];
    self.listArray = [MyOrderListModel mj_objectArrayWithKeyValuesArray:array];
    
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
    [self.tableView registerClass:[MyOrderListCell class] forCellReuseIdentifier:[MyOrderListCell className]];
    
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
    return self.listArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:[MyOrderListCell className]];
    cell.model = self.listArray[indexPath.row];
    cell.delegate = self;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.listArray[indexPath.row] cellHeight];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MyOrderDetailVC * detailVC = [[MyOrderDetailVC alloc] init];
    detailVC.style = self.style;
    [self.navigationController pushVC:detailVC animated:YES];
}
#pragma mark - MyOrderListCellDelegate
- (void)MyOrderListCellDelegate_clickWithButton:(UIButton *)sender
{
    
}
- (void)MyOrderListCellDelegate_clickCellWithModel:(MyOrderListModel *)model
{
    MyOrderDetailVC *detailVC = [[MyOrderDetailVC alloc] init];
    detailVC.style = self.style;
    [self.navigationController pushVC:detailVC animated:YES];
}
#pragma mark - dealloc
- (void)dealloc
{
    
}

@end
